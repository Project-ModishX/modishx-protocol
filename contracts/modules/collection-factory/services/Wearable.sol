// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlController, Dto} from "../../access-control/controllers/access-control.controller.sol";
import {ERC1155} from "./ERC1155.service.sol";
import {Strings} from "./Strings.sol";

/// @notice this is a NFT contract ERC1155 token type 
contract Wearable is ERC1155 {
    // ============================================================================================================
    // -------------------------------------------- State Variables -------------------------------------------------------
    // ============================================================================================================
    bool isRedeemed;
    address modishx;


    // ============================================================
    // CUSTOM ERRORS 
    // ============================================================
    error NOT_AUTHORIZED();


    // ==============================================================
    // CONSTRUCTION
    // ==============================================================
    /// @param _uri: this is the link to the metadata [https://bafybeihul6zsmbzyrgmjth3ynkmchepyvyhcwecn2yxc57ppqgpvr35zsq.ipfs.dweb.link/]
    constructor(
        string memory _uri, 
        address _modishx
    ) 
        ERC1155(
            _uri
        ) 
    {
        modishx = _modishx;
    }






    // =======================================================
    // MUTATION 
    // =======================================================


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
    {
        onlyOwner();
        _mint(_account, _id, _amount, _data);
    }

    function mintBatch(
        address _to, 
        uint256[] memory _ids, 
        uint256[] memory _amounts, 
        bytes memory _data
    )
        public
    {
        onlyOwner();
        _mintBatch(_to, _ids, _amounts, _data);
    }







    // ========================================================
    // Query 
    // =========================================================

    /// @notice this function would return true or false if a wearable has been redeemed
    /// @dev wearables which has been redeemed can on longer be traded on the marketplace and is no longer redeemable able 
    function hasBeenRedeemed()
        external
        view 
        returns(
            bool redeemed_status
        )
    {
        redeemed_status = isRedeemed;
    }

    function onlyOwner()
        internal
        view 
        returns(
            bool is_auth
        )
    {
        is_auth = AccessControlController(modishx).hasRole(Dto.Roles.MARKETPLACE_MANAGER, msg.sender);

        if (!is_auth) {
            revert NOT_AUTHORIZED();
        }
    }

    function uri(
        uint256 _token_id
    )
        override
        public 
        view
        returns(
            string memory uri_
        )
    {
        uri_ = string(
            abi.encodePacked(
                super.uri(_token_id), 
                Strings.toString(_token_id), 
                ".json"
            )
        );
    }
}