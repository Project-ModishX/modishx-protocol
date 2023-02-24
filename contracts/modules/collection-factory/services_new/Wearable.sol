// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlController, Dto} from "../../access-control/controllers/access-control.controller.sol";
import {ERC721URIStorage} from "./URIStorage.sol";


/// @notice this is a NFT contract ERC1155 token type 
contract Wearable is ERC721URIStorage {
    // ============================================================================================================
    // -------------------------------------------- State Variables -------------------------------------------------------
    // ============================================================================================================
    uint256 public total_supply;
    bytes32 public dna;
    address public modishx;
    mapping(uint256 => bool) public isRedeemed;
    

    
    // ============================================================
    // CUSTOM ERRORS 
    // ============================================================
    error NOT_AUTHORIZED();


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

    }



    // =======================================================
    // MUTATION 
    // =======================================================





    // ========================================================
    // Query 
    // =========================================================
}