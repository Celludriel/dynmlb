if(!isServer) exitWith {};

if(isNil "dynMlbFnLoaded") then {

	call compile preprocessfile "common\SHK_pos\shk_pos_init.sqf";
	DynMlbActiveMissions = [];
	DynMlbIdStore = 0;

	pGetNewId = {
		DynMlbIdStore = DynMlbIdStore + 1;
		DynMlbIdStore
	};

	pFindRandomOffRoadLandPositionFromLocation = {
		private ["_location", "_radius", "_vehicleToFit"];
		_location = _this select 0;
		_radius = _this select 1;
		_vehicleToFit = _this select 2;

		[_location, [0, _radius], random 360, 0, 0, _vehicleToFit] call SHK_pos
	};

	pAddActiveMission = {
		private ["_missionData"];
		DynMlbActiveMissions pushBack _missionData;
	};

	dynMlbFnLoaded = true;
};