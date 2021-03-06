/*
 * Author: Dslyecxi, Jonpas
 * Primes the throwable, creates global throwable vehicle and throws Fired XEH.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Show Hint <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call ace_advanced_throwing_fnc_prime
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", ["_showHint", false]];
TRACE_2("params",_unit,_showHint);

_unit setVariable [QGVAR(primed), true];

// Remove item before cooking to prevent weaponselect showing more throwables than there actually are in inventory
private _throwableMag = (currentThrowable _unit) select 0;
_unit removeItem _throwableMag;

private _throwableType = getText (configFile >> "CfgMagazines" >> _throwableMag >> "ammo");
private _muzzle = _throwableMag call FUNC(getMuzzle);

// Create actual throwable globally
private _activeThrowableOld = _unit getVariable [QGVAR(activeThrowable), objNull];
private _activeThrowable = createVehicle [_throwableType, _activeThrowableOld, [], 0, "CAN_COLLIDE"];
_unit setVariable [QGVAR(activeThrowable), _activeThrowable];
deleteVehicle _activeThrowableOld;

// Throw Fired XEH
[QGVAR(throwFiredXEH), [
    _unit, // unit
    "Throw", // weapon
    _muzzle, // muzzle
    _muzzle, // mode
    _throwableType, // ammo
    _throwableMag, // magazine
    _activeThrowable // projectile
]] call CBA_fnc_globalEvent;

if (_showHint) then {
    // Show primed hint
    private _displayNameShort = getText (configFile >> "CfgMagazines" >> _throwableMag >> "displayNameShort");
    private _picture = getText (configFile >> "CfgMagazines" >> _throwableMag >> "picture");

    [[_displayNameShort, localize LSTRING(Primed)] joinString " ", _picture] call EFUNC(common,displayTextPicture);

    // Change controls hint for RMB
    call FUNC(updateControlsHint);
};
