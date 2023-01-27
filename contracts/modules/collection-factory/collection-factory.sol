// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Wearable} from "./services/Wearable.sol";
import {AcessControl, Dto as AccessControlDto} from "../access-control/providers/access-control.provider.sol";
import {Create3} from "./provider/create3.sol";
import {Dna} from "./controllers/dna.controller.sol";


contract CollectionFactory {
    // =====================================
    // EVENTS
    // =====================================
    event CollectionDeployed(address _new_collection);


    function create_collection(
        string memory _uri
    ) 
        external 
        returns (
            address _new_collection
        )
    {
        only_owner();

        bytes32 childs_dna = bytes32(abi.encodePacked(_uri, block.timestamp));

        _new_collection = Create3.create3(
            childs_dna, 
            abi.encodePacked(
                type(Wearable).creationCode,
                abi.encode(
                    _uri,address(this),childs_dna
                ))
            );

        emit CollectionDeployed(_new_collection);
    }


    function only_owner()
        internal
        view 
        returns(
            bool is_auth
        )
    {
        is_auth = AcessControl.hasRoleWithRevert(AccessControlDto.Roles.MARKETPLACE_MANAGER, msg.sender);
    }

    
    /// @param _child: the is the address of the child to be verified 
    /// @notice this a view function that would return true if the provided address was created by the contract
    function is_modishx_wearable(
        address _child
    ) 
        view 
        public 
        returns(
            bool isMine
        ) 
    {
        bytes32 _salt = Dna(_child).dna(); 
        address mine = Create3.addressOf(_salt);

        if(mine == _child) {
            isMine = true;
        }
    }

    /// @notice this a view function that would return true if the provided address was created by the contract
    function is_modishx_wearable_strict() 
        view 
        public 
        returns(
            bool isMine
        ) 
    {
        address caller = msg.sender;
        bytes32 _salt = Dna(caller).dna(); 
        address mine = Create3.addressOf(_salt);

        if(mine == caller) {
            isMine = true;
        }
    }
}