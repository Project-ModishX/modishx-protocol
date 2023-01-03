// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dto} from "./dto.sol";
import {Positions} from "./postions.sol";
import {Errors} from "./errors.sol";

library MarketplaceProvider {
    function marketplaceStorage() 
        internal 
        pure 
        returns (
            Dto.MarketplaceSchema storage ms
        ) 
    {
        bytes32 position = Positions.MODISHX_MARKETPLACE_POSITION;
        assembly {
            ms.slot := position
        }
    }

    function return_listing_fee() 
        internal 
        view 
        returns(
            uint256 listing_fee
        ) 
    {
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        listing_fee = ms.listing_fee;
    }
}
