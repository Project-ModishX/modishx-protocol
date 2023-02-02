// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dto, PriceSourceController} from "./dto.sol";
import {Positions} from "./postions.sol";
import {Errors} from "./errors.sol";
import {AcessControl, Dto as AccessControlDto} from "../../access-control/providers/access-control.provider.sol";
import {Wearable} from "../../collection-factory/services/Wearable.sol";



library MarketplaceProvider {
    uint256 constant PRECESION = 10**8;


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
        AcessControl.hasRoleWithRevert(AccessControlDto.Roles.MARKETPLACE_MANAGER, msg.sender);
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        ms.listing_fee = _listing_fee;
    }

    function list_market_items(

    )
        internal
    {

    }

    function list_internal(
        address _wearable_token_address,
        uint256[] _wearable_token_ids,
        uint256[] _quantities,
        uint40 _price,
        uint8 _referrer_percentage,
        address _seller
    )
        internal 
    {
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        Wearable wearable = Wearable(_wearable_token_address);

        if(_quantities.length != _wearable_token_ids.length) {
            revert Errors.IDS_AND_QUANTITY_NEEDS_TO_BE_THE_SAME_LENGTH()
        }

        if(quantities.length > 10) {
            revert Errors.MAXIMUM_WEARABLE_LENGTH();
        }

        wearable.modishBalanceOfBatchWithCheck(_seller, _wearable_token_ids, _quantities);

        if(!wearable.isApprovedForAll(seller, address(this))) {
            revert Errors.INSUFFICIENT_AUTHORIZATION_OVER_TOKENS();
        }

        cost_check(_quantities, _price, ms.minimum_tradeable);

        Dto.MartketplaceItem memory wb = Dto.MartketplaceItem({
            marketplace_item_id: ms.next_listing_id,
            wearable_ids: _wearable_token_ids,
            price: cost
            quantities: _quantities,
            seller
            created_at
            sold_at
            referrer_percentage
            is_sold
            is_cancelled
        })
    }

    function update_listing_price(

    )
        internal
    {

    }

    function cancel_market_listing(

    ) 
        internal 
    {

    }

    function buy_wearable(

    )
        internal 
    {

    }

    function increment__list_id(Dto.MarketplaceSchema storage ms)
        internal 
    {
        ms.last_listing_id++;
    }

    function cost_check(
        uint256[] _quantities, 
        uint256 _price, 
        uint256 mt
    ) 
        internal 
        pure
        returns {
            bool checks_out
        }
    {
        for (uint256 i; i < _quantities.length; i++) {
            uint256 total_cost_or_wearables = _quantity * _price;
            if(total_cost_or_wearables < mt) {
                revert Errors.COST_TOO_LOW();
            }
        }
    }


    /// @dev this function would get the listing fee from storage convert it to the price of polygon and take it from the user(_from)
    function check_if_listing_fee_is_enough()
        internal
        view
        returns(
            bool status_
        )
    {
        // obtain the listing fee from storage and obtain price in matic 
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        uint256 listing_fee_in_matic = (ms.listing_fee * get_polygon_current_price_to_dollar()) / PRECESION**2;
        uint256 value = msg.value;

        if(value >= listing_fee_in_matic) {
            status_ = true;
        } else {
            revert Errors.INSUFFICIENT_FUNDS();
        }
    }

    function get_price_source()
        internal
        view
        returns (
            PriceSourceController price_source_
        )
    {
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        price_source_ = ms.price_source;
    }

    function set_price_source(
        PriceSourceController _price_source
    ) 
        internal
    {
        AcessControl.hasRoleWithRevert(AccessControlDto.Roles.MARKETPLACE_MANAGER, msg.sender);
        Dto.MarketplaceSchema storage ms = marketplaceStorage();
        ms.price_source = _price_source;
    }

    /// @dev the price retruned by this function is already in precision 10**8
    function get_polygon_current_price_to_dollar()
        internal
        view
        returns(
            uint256 price_
        )
    {
        (
            ,
            int price,
            ,
            ,
        ) = get_price_source().latestRoundData();

        price_ = uint256(price);
    }
}



// MATIC/USD -> 0xAB594600376Ec9fD91F8e885dADF0CE036862dE0 [MAINNET]
// MATIC/USD -> 0xAB594600376Ec9fD91F8e885dADF0CE036862dE0 [TESTNET]