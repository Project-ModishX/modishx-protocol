// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import {Dto} from "./dto.sol";
import {Positions} from "./postions.sol";
import {Errors} from "./errors.sol";




library AcessControl {
    // ================================
    // EVENT
    // ================================
    event RoleGranted(Dto.Roles role, address assignee);
    event RoleRevoked(Dto.Roles role, address assignee);
    event Setuped(address superuser);
    event SuperuserTransfered(address new_superuser);


  function accessControlStorage() internal pure returns (Dto.AccessControlSchema storage ms) {
    bytes32 position = Positions.ACCESS_CONTROL_STORAGE_POSITION;
    assembly {
      ms.slot := position
    }
  }

  function enforceSuperUser(address _addr) internal view {
    Dto.AccessControlSchema storage ms = accessControlStorage();
    if(_addr == ms.superuser) {
        revert Errors.NOT_SUPERUSER();
    }
  }

  function setUp(address _superuser) internal {
    Dto.AccessControlSchema storage ms = accessControlStorage();
    if(ms.is_initialized == true) {
        revert Errors.HAS_BEEN_INITIALIZED();
    }

    ms.superuser = _superuser;
    ms.is_initialized = true;

    emit Setuped(_superuser);
  }


  function grantRole(address _assignee, Dto.Roles _role) internal {
    enforceSuperUser(msg.sender);
    Dto.AccessControlSchema storage ms = accessControlStorage();
    ms.role[_assignee] = _role;

    emit RoleGranted(_role, _assignee);
  }

  function revokeRole(Dto.Roles _role, address _assignee) internal {
    enforceSuperUser(msg.sender);
    Dto.AccessControlSchema storage ms = accessControlStorage();
    ms.role[_assignee] = Dto.Roles.DEFAULT;

    emit RoleRevoked(_role, _assignee);
  }

  function hasRole(Dto.Roles _role, address _assignee) internal view returns(bool has_role) {
    Dto.AccessControlSchema storage ms = accessControlStorage();
    has_role = _assignee == ms.superuser|| _role == ms.role[_assignee];
  }

  
  function hasRoleWithRevert(Dto.Roles _role, address _assignee) internal view returns(bool has_role) {
    if(hasRole(_role, _assignee)) {
        return true;
    } else {
        revert Errors.NOT_ROLE_MEMBER();
    }
  }


  function transferSuper(address _superuser, address _current_caller) internal {
    enforceSuperUser(_current_caller);
    Dto.AccessControlSchema storage ms = accessControlStorage();
    ms.superuser = _superuser;

    emit SuperuserTransfered(_superuser);
  }
}