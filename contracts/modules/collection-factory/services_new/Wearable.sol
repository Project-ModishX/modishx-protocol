// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlController, Dto} from "../../access-control/controllers/access-control.controller.sol";
import {ERC721URIStorage} from "./URIStorage.sol";

import {Counters} from "./Counter.sol";


/// @notice this is a NFT contract ERC1155 token type 
contract Wearable is ERC721URIStorage {
    // =========================================================================
    // using libraries 
    // =========================================================================

    using Counters for Counters.Counter;


    // ============================================================================================================
    // -------------------------------------------- State Variables -------------------------------------------------------
    // ============================================================================================================
    uint256 public total_supply;
    bytes32 public dna;
    address public modishx;
    mapping(uint256 => bool) public isRedeemed;
    Counters.Counter private _tokenIdCounter;


    // ============================================================
    // CUSTOM ERRORS 
    // ============================================================

    error NOT_AUTHORIZED();
    error CANT_REDEEM_WEARABLE();
    error ALREADY_REDEEMED();


    // =====================================================
    //  EVENTS 
    // =====================================================

    event Redeemed(address _owner, uint256 _token_id, uint256 _redeemed_at);


    // ==============================================================
    // CONSTRUCTION
    // ==============================================================
    constructor(
        string memory wearable_name, string memory wearable_symbol
    ) 
        ERC721URIStorage(
            wearable_name,
            wearable_symbol
        ) 
    {
        modishx = _msgSender();
    }



    // =======================================================
    // MUTATION 
    // =======================================================


    /// @notice this function would mint wearable to a user
    /// @dev this function can only be called my the modisx main contract address
    /// @param _to: this is the address the nft would be minted to 
    function safeMint(
        address _to
    ) 
        external
    {
        if(msg.sender != modishx) {
            revert NOT_AUTHORIZED();
        }

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(_to, tokenId);
    }


    /// @notice NFTs on modishx are redeemable and redeemable nft cannot be traded on modishx marketplace 
    /// @dev only modishx can make the redeption call
    function redeem(
        uint256 _token_id,
        address _wearable_owner
    )
        external 
    {
        if(msg.sender != modishx) {
            revert NOT_AUTHORIZED();
        }

        if (ownerOf(_token_id) == _wearable_owner) {
            revert CANT_REDEEM_WEARABLE();
        }

        if(isRedeemed[_token_id] == true) {
            revert ALREADY_REDEEMED();
        }

        isRedeemed[_token_id] = true;

        emit Redeemed(_wearable_owner, _token_id, block.timestamp);
    }








    // ========================================================
    // Query 
    // =========================================================

    
}