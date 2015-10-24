diag_log format ["Calling createStdDom.sqf"];
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

diag_log format ["MissionData: %1", _missionData];

// setup capture positions
_captureLocations = [];
for "_i" from 1 to _amountOfCapturePoints do {
	_captureLocations pushBack ([_location, _radius, "Land_Cargo_Patrol_V1_F"] call pFindRandomOffRoadLandPositionFromLocation);
};

diag_log format ["CaptureLocations: %1", _captureLocations];

_captureBuildings = [];
{
	_captureBuildings pushBack ([_x, 5, "Land_Cargo_Patrol_V1_F", 60, _enemySide] call compileFinal preprocessFileLineNumbers "common\dyncap\createCaptureLocation.sqf");
} forEach _captureLocations;

diag_log format ["CaptureBuildings: %1", _captureBuildings];

_missionData pushBack _captureBuildings;
diag_log format ["MissionData: %1", _missionData];

// militarize the zone
/*nul = [[[1, [_location,2,300,[true,false],[true,false,true],false,[20,10],[10,5],[0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5],nil,nil,1]]], 300, true] execVM "common\LV\LV_functions\LV_fnc_simpleCachev2.sqf";*/

_marker = createMarker ["spawnMarker", _location];
_container = [ "INFANTRY", 10, 5, east ] call T8U_rnd_SpawnContainer;

diag_log format ["Container: %1", _container];

_unitsAtMarker = [
      [[_container, "spawnMarker"], ["PATROL_URBAN"]]
];

[ _unitsAtMarker ] spawn T8U_fnc_Spawn;

diag_log format ["UnitsAtMarker: %1", _unitsAtMarker];