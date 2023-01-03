// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


library Dto {
  enum Roles {
    DEFAULT, // This is the role that all addresses has by default 
    MARKETPLACE_MANAGER,
    AUCTION_ADMIN,
    FUNDS_MANAGER
  }

  struct AccessControlSchema {
    mapping(address => Roles) role; // address => role
    address superuser; // The superuser can preform all the role and assign role to addresses 
    bool is_initialized;
  }
}