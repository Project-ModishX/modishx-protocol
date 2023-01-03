// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Dto {
    struct MartketplaceItem {
        uint256 marketplace_item_id;
        address seller;
        address token_address;
        address reffer;
        uint256 wearable_id;
        uint256 quantity;
        uint256 price;
        uint256 created_at;
        uint256 sold_at;
        uint256 reffer_percentage; // in 10**6
        bool is_sold;
        bool is_cancelled;
    }

    struct MarketplaceSchema {
        uint256 listing_fee;
        mapping(uint256 => MartketplaceItem) market_items_mapping;
        MartketplaceItem[] market_items_array;
    }
}

