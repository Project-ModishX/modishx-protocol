// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface CollectionFactoryController {
    function create_collection(
        string memory _uri
    ) 
        external 
        returns (
            address _new_collection
        );
    
    function only_owner()
        external
        view 
        returns(
            bool is_auth
        );
    
    function is_modishx_wearable(
        address _child
    ) 
        view 
        external 
        returns(
            bool isMine
        );

    function is_modishx_wearable_strict() 
        view 
        external 
        returns(
            bool isMine
        );
}