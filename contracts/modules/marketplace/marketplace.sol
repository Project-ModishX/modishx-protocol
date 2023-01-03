// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import {MarketplaceProvider as provider, Dto} from "./providers/marketplace.provider.sol";



/// @notice this is a marketplace contract for ERC1155 contract
/// @dev this main logics are done in the libries (provider)
contract Marketplace {
    // =======================================
    // QUERY FUNCTIONS
    // =======================================

    /// @notice this function returns the fee to be paid when listing a weariable [signle item & batch]
    /// @dev the highest a usr can least at ones is 20 items
    /// @param _amount: this is the amount of item you want to least on the marketplace
    function get_listing_fee(
        uint8 _amount
    ) 
        external 
        view 
        returns (
            uint256 listing_fee
        ) 
    {
        listing_fee = provider.return_listing_fee() * _amount;
    }

    /// @notice the function returns the details of a marketplace it item when the listing id is provided
    /// @param _listing_id: this is the id of the market item
    function get_item(uint256 _listing_id) external view returns (Dto.MartketplaceItem memory market_item) {
        market_item = provider.return_market_item(_listing_id);
    }

    /// @notice this function would be returning a specified amount of marketplace item
    /// @param _amount: this is the amount of marketplace item that is to be returned
    /// @param _skip: this is the number of items should be skipping before fetching (similar to pagination)
    /// @param _skip_sold: this switch is used to tell the function to return sold items or not
    function get_items(
        uint8 _amount, 
        uint256 _skip, 
        bool _skip_sold
    ) 
        external 
        view 
        returns (
            Dto.MartketplaceItem[] memory market_items
        ) 
    {
        market_items = provider.return_market_items(_amount, _skip, _skip_sold);
    }

    // =======================================
    // MUTATION FUNCTION
    // =======================================

    /// @notice this is a function that would be responisible for setting the listing fee of the protocol
    /// @param _listing_fee: this is the new listing in wei
    /// @dev this function would be guarded using access control
    function set_listing_fee(
        uint256 _listing_fee
    ) 
        external 
    {

    }

    /// @notice this function is user be a wearable owner to list their weariable on the marketplace
    /// @dev function should make sure the approval for all is allowed in this address
    function list_items() external {}

    /// @notice this function would be used be the seller to tell the market they are no - longer selling
    function cancel_listing() external {}
}
