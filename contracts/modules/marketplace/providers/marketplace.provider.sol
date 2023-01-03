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

    function return_market_item(uint256 _listing_id) 
        internal
        view 
        returns(
            Dto.MartketplaceItem memory market_item
        ) 
    {
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        market_item = ms.market_items_mapping[_listing_id];
    }

    function return_market_items(
        uint8 _amount, 
        uint256 _skip, 
        bool _skip_sold
    ) 
        internal 
        view 
        returns(
            Dto.MartketplaceItem[] memory market_items
        )
    {
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        uint8 current_index;
        market_items = new Dto.MartketplaceItem[](_amount);

        for(uint256 i = _skip; i < _amount + _skip; i++) {
            Dto.MartketplaceItem memory mt = ms.market_items_mapping[i];
            
            // remove sold items 
            if(_skip_sold && mt.is_sold) {
                continue;
            }

            // remove cancelled items
            if(mt.is_cancelled) {
                continue;
            }

            // setting the return array
            market_items[current_index] = mt;

            current_index++;
        }
    }

    function set_listing_fee(
        uint256 _listing_fee
    )
        internal
    {
        
        Dto.MarketplaceSchema storage ms = marketplaceStorage();

    }
}
