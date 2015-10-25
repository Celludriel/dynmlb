if(!isServer) exitWith {};

if(isNil "dynMlbFnLoaded") then {

	call compile preprocessfile "dynmlb\common\SHK_pos\shk_pos_init.sqf";
	DynMlbActiveMissions = [];
	DynMlbIdStore = 0;

	pGetNewId = {
		DynMlbIdStore = DynMlbIdStore + 1;
		DynMlbIdStore
	};

	pFindRandomOffRoadLandPositionFromLocation = {
		params ["_location", ["_radius",300], ["_vehicleToFit",[]]];

		diag_log format ["pFindRandomOffRoadLandPositionFromLocation params: %1, %2, %3", _location, _radius, _vehicleToFit];

		[_location, [0, _radius], random 360, 0, [0,0], _vehicleToFit] call SHK_pos
	};

	pAddActiveMission = {
		params ["_missionData"];
		DynMlbActiveMissions pushBack _missionData;
	};

	dynMlbFnLoaded = true;
};