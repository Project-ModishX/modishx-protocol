// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @notice this is a marketplace contract for ERC1155 contract
/// @dev this main logics are done in the libries (provider)
contract Marketplace {
    // =======================================
    // QUERY FUNCTIONS
    // =======================================

    /// @notice this function returns the fee to be paid when listing a weariable [signle item & batch]
    /// @dev the highest a usr can least at ones is 20 items
    /// @param _amount: this is the amount of item you want to least on the marketplace
    function get_listing_fee(uint8 _amount) external view returns (uint256) {}

    /// @notice the function returns the details of a marketplace it item when the listing id is provided
    /// @param _listing_id: this is the id of the market item
    function get_item(uint256 _listing_id) external view returns (uint256) {}

    /// @notice this function would be returning a specified amount of marketplace item
    /// @param _amount: this is the amount of marketplace item that is to be returned
    /// @param _skip: this is the number of items should be skipping before fetching (similar to pagination)
    /// @param _skip_sold: this switch is used to tell the function to return sold items or not
    function get_items(uint8 _amount, uint256 _skip, bool _skip_sold) external view returns (uint256) {}

    /// @notice this function would be used to fetch items listed on the marketplace of a specified address
    /// @param _token_address: this is the address of the NFT
    /// @param _amount: this is the amount of marketplace item that is to be returned
    /// @param _skip: this is the number of items should be skipping before fetching (similar to pagination)
    /// @param _skip_sold: this switch is used to tell the function to return sold items or not
    function get_items_by_nft_address(address _token_address, uint8 _amount, uint256 _skip, bool _skip_sold)
        external
        view
        returns (uint256)
    {}

    /// @notice the function would be used to return the market-items belonging to an address
    /// @param _seller: this is the address in which you want to see the wearables the have listed on the marketplace
    /// @param _amount: this is the amount of marketplace item that is to be returned
    /// @param _skip: this is the number of items should be skipping before fetching (similar to pagination)
    /// @param _skip_sold: this switch is used to tell the function to return sold items or not
    function get_listing_by_seller(address _seller, uint8 _amount, uint256 _skip, bool _skip_sold)
        external
        view
        returns (uint256)
    {}

    // =======================================
    // MUTATION FUNCTION
    // =======================================

    /// @notice this is a function that would be responisible for setting the listing fee of the protocol
    /// @param _listing_fee: this is the new listing in wei
    function set_listing_fee(uint256 _listing_fee) external {}

    /// @notice this function is user be a wearable owner to list their weariable on the marketplace
    /// @dev function should make sure the approval for all is allowed in this address
    function list_items() external {}

    /// @notice this function would be used be the seller to tell the market they are no - longer selling
    function cancel_listing() external {}
}
