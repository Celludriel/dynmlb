if (!isServer) exitWith {};

[] call compileFinal preprocessFileLineNumbers "common\dynmlb_fn.sqf";

_location = _this select 0;
_radius = _this select 1;
_amountOfCapturePoints = _this select 2;
_enemySide = _this select 3;

// setup mission data record
_missionData = [];
_missionCode = format ["STANDARDDOM_%1", [] call pGetNewId];
_missionData pushBack _missionCode;

// setup capture positions
_captureLocations = [];
for "_i" from 1 to _amountOfCapturePoints do {
	_captureLocations pushBack ([_location, _radius, "Land_Cargo_Patrol_V1_F"] call pFindRandomOffRoadLandPositionFromLocation);
};

_captureBuildings = [];
{
	_captureBuildings pushBack [_x, 5, "Land_Cargo_Patrol_V1_F", 60, _enemySide] call compileFinal preprocessFileLineNumbers "common\dyncap\createCaptureLocation.sqf";
} forEach _captureLocations;

_missionData pushBack _captureBuildings;

// militarize the zone
nul = [[[1, [_location,2,300,[true,false],[true,false,true],false,[20,10],[10,5],[0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5],nil,nil,1]]], 300, true] execVM "common\LV\LV_functions\LV_fnc_simpleCachev2.sqf";