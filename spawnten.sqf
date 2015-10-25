if(!isServer) exitWith {};

_container = [ "INFANTRY", 10, 0, east ] call T8U_rnd_SpawnContainer;
_unitsAtMarker = [
      [[_container, "missionlocation"], ["PATROL_URBAN"]]
];

[ _unitsAtMarker ] spawn T8U_fnc_Spawn;