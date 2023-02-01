// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PriceSourceController} from "../controllers/price-source.controller.sol";

library Dto {
    struct MartketplaceItem {
        uint256 marketplace_item_id; // this is the id the marketplace uses to track it items 
        uint256[] wearable_ids; // is is a list of token id of the nft to be listed 
        uint256 price; // this is the price the nft would be sold for
        uint256[] quantities; // this is the amount of the indivual items 
        address seller;
        address token_address; // this is the address of the nft contract 
        uint40 created_at; // this is the block.timestamp this token was placed for sale 
        uint40 sold_at; // this is the block.timestamp this token wa sold 
        uint8 reffer_percentage; // in 1 = 1%
        bool is_sold; //this is a market to sold when a token is sold or not 
        bool is_cancelled; //  this is a pointer to show if a wearable listed for sale has been cancalled 
    }

    struct MarketplaceSchema {
        uint256 listing_fee; // in dollar and percison is 10**6
        mapping(uint256 => MartketplaceItem) market_items_mapping;
        MartketplaceItem[] market_items_array;
        PriceSourceController price_source;
    }
}

