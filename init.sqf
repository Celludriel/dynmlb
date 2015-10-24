diag_log format ["Calling init.sqf"];
[] execVM "T8_UnitsINIT.sqf";
[(getMarkerPos "missionlocation"),400,3,east] execVM "dynmlb\missions\stddom\createStdDom.sqf";