diag_log format ["Calling createStdDom.sqf"];
if (!isServer) exitWith {};

[] call compileFinal preprocessFileLineNumbers "dynmlb\common\dynmlb_fn.sqf";

params ["_location","_radius","_amountOfCapturePoints","_enemySide"];

// setup mission data record
_missionData = [];
_missionCode = format ["STANDARDDOM_%1", [] call pGetNewId];
_missionData pushBack _missionCode;

diag_log format ["MissionData: %1", _missionData];

// setup capture positions
_captureLocations = [];
for "_capturePoint" from 1 to _amountOfCapturePoints do {
	_captureLocations pushBack ([_location, _radius, "Land_Cargo_Patrol_V1_F"] call pFindRandomOffRoadLandPositionFromLocation);
};

diag_log format ["CaptureLocations: %1", _captureLocations];

_captureBuildings = [];
{
	_captureBuildings pushBack ([_x, 5, "Land_Cargo_Patrol_V1_F", 60, _enemySide] call compileFinal preprocessFileLineNumbers "dynmlb\common\dyncap\createCaptureLocation.sqf");
} forEach _captureLocations;

diag_log format ["CaptureBuildings: %1", _captureBuildings];

_missionData pushBack _captureBuildings;
diag_log format ["MissionData: %1", _missionData];

// militarize the zone
/*nul = [[[1, [_location,2,300,[true,false],[true,false,true],false,[20,10],[10,5],[0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5],nil,nil,1]]], 300, true] execVM "common\LV\LV_functions\LV_fnc_simpleCachev2.sqf";*/

_spawns = [];
_markers = [];
_spawnMarkerSuffix=0;
for [{},{_spawnMarkerSuffix<8},{_spawnMarkerSuffix = _spawnMarkerSuffix+1}] do {
	_markerName = format ["%1_spawnmarker_%2", _missionCode, _spawnMarkerSuffix];
	diag_log format ["_markerName: %1, %2, %3", _markerName, _location, _radius];

	_markers pushBack _markerName;

	_spawnLocation = [_location, _radius, "O_G_Soldier_F"] call pFindRandomOffRoadLandPositionFromLocation;
	diag_log format ["_spawnLocation: %1", _spawnLocation];

	createMarker [_markerName, _spawnLocation];
	_markerName setMarkerSize [300, 300];

	_spawns pushBack [[[ "INFANTRY", 5, 0, east ] call T8U_rnd_SpawnContainer, _markerName], ["PATROL_URBAN"]];
};

for [{},{_spawnMarkerSuffix<10},{_spawnMarkerSuffix = _spawnMarkerSuffix+1}] do {
	_markerName = format ["%1_spawnmarker_%2", _missionCode, _spawnMarkerSuffix];
	diag_log format ["_markerName: %1, %2, %3", _markerName, _location, _radius];

	_markers pushBack _markerName;

	_spawnLocation = [_location, _radius, "O_MBT_02_cannon_F"] call pFindRandomOffRoadLandPositionFromLocation;
	diag_log format ["_spawnLocation: %1", _spawnLocation];

	createMarker [_markerName, _spawnLocation];
	_markerName setMarkerSize [300, 300];

	_spawns pushBack [[[ "VEHICLE", 5, 0, east ] call T8U_rnd_SpawnContainer, _markerName], ["PATROL_AROUND"]];
};

for [{},{_spawnMarkerSuffix<12},{_spawnMarkerSuffix = _spawnMarkerSuffix+1}] do {
	_markerName = format ["%1_spawnmarker_%2", _missionCode, _spawnMarkerSuffix];
	diag_log format ["_markerName: %1, %2, %3", _markerName, _location, _radius];

	_markers pushBack _markerName;

	_spawnLocation = [_location, _radius, "O_Heli_Attack_02_F"] call pFindRandomOffRoadLandPositionFromLocation;
	diag_log format ["_spawnLocation: %1", _spawnLocation];

	createMarker [_markerName, _spawnLocation];
	_markerName setMarkerSize [300, 300];

	_spawns pushBack [[[ "HELICOPTER", 5, 0, east ] call T8U_rnd_SpawnContainer, _markerName], ["PATROL_AROUND"]];
};

_missionData pushBack _markers;

diag_log format ["UnitsAtMarker: %1", _spawns];

[ _spawns ] spawn T8U_fnc_Spawn;

_missionData