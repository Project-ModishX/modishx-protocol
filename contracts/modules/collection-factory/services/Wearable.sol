// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/// @notice this is a NFT contract ERC1155 token type 
contract Wearable {
    // ============================================================================================================
    // -------------------------------------------- Exposed -------------------------------------------------------
    // ============================================================================================================


    /// @notice this function would return true or false if a wearable has been redeemed
    /// @dev wearables which has been redeemed can on longer be traded on the marketplace and is no longer redeemable able 
    function hasBeenRedeemed(

    )
        external 
        view 
    {

    }

    /// @notice this is the function the admins of modishx would be using to mint new fashon wearable into the modishx marketplace 
    /// @dev this function should not be guarded by only owner but by access control
    /// @param _account:
    /// @param _id:
    /// @param _amount:
    /// @param _data:
    function mint(
        address _account, 
        uint256 _id, 
        uint256 _amount, 
        bytes memory _data
    )
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(
        address to, 
        uint256[] memory ids, 
        uint256[] memory amounts, 
        bytes memory data
    )
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }




    // ============================================================================================================
    // -------------------------------------------- Backend -------------------------------------------------------
    // ============================================================================================================
    
}