// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Wearable} from "./services/Wearable.sol";
import {AcessControl, Dto as AccessControlDto} from "../access-control/providers/access-control.provider.sol";

contract CollectionFactory {
    // =====================================
    // EVENTS
    // =====================================
    event CollectionDeployed(address _new_collection);


    function create_collection(
        string memory _uri
    ) 
        external 
    {
        onlyOwner();
        Wearable collection = new Wearable(_uri, address(this));
        emit CollectionDeployed(address(collection));
    }


    function onlyOwner()
        internal
        view 
        returns(
            bool is_auth
        )
    {
        is_auth = AcessControl.hasRoleWithRevert(AccessControlDto.Roles.MARKETPLACE_MANAGER, msg.sender);
    }
}