// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dto} from "../providers/Dto.sol";

interface AccessControlController {
    function setUp(address _superuser) external;
    function revokeRole(Dto.Roles _role, address _assignee) external;
    function hasRole(Dto.Roles _role, address _assignee) external view returns(bool isAdmin_);
    function transferSuper(address _superuser) external;
}