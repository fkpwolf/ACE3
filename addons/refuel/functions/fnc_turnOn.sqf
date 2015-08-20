/*
 * Author: GitHawk
 * Turn on a fuel nozzle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Nozzle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [nozzle] call ace_refuel_fnc_turnOn
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_nozzle"];

_nozzle setVariable [QGVAR(isRefueling), true, true];
[LSTRING(Hint_Started), 1.5, _unit] call EFUNC(common,displayTextStructured);
