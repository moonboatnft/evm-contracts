// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
contract NFTCollections {

    event CollectionCreated(uint collectionId,  address user, bytes32 hash);
    uint currentCollectionId = 1;
    mapping(uint => address) private collections;
    
    function createCollection(bytes32 hash) public returns (uint){
        currentCollectionId++;
        collections[currentCollectionId] = msg.sender;
        emit CollectionCreated(currentCollectionId, msg.sender, hash);
        return currentCollectionId;
    }

    function checkOwner(uint collectionId, address user) public view returns (bool){
        return collections[collectionId] == user;
    }

    
}