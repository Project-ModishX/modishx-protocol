// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Dto } from "./dto.sol";
import { Positions } from "./positions.sol";
import {Errors} from "./errors.sol";


library MarketplaceProvider {
    function marketplaceStorage() internal pure returns (Dto.MarketplaceSchema storage ms) {
        bytes32 position = Positions.MODISHX_MARKETPLACE_POSITION;
        assembly {
        ms.slot := position
        }
    }
}