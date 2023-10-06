// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface Collections { 
	function checkOwner(uint collectionId, address user) external view returns (bool);
}

contract NFT1155 is ERC1155, Ownable {
    constructor(address collectionsAddress) ERC1155("MoonBoat NFT") {
        collectionsContract = Collections(collectionsAddress);
    }
    event Minted(uint tokenId, uint collectionId, uint amount, address user, bytes32 hash);
    string private _name = 'MoonBoat NFT';
    uint tokenId = 1;
    mapping(uint => uint) public assets; // tokenId => collectionsId
    Collections collectionsContract;


    function name() public view virtual returns (string memory) {
        return _name;
    }

    function mint(uint collectionId, uint amount, bytes32 hash) public returns (uint){
        require(collectionsContract.checkOwner(collectionId, msg.sender), "collectionId error");
        tokenId++;
        assets[tokenId] = collectionId;
        _mint(msg.sender, tokenId, amount, "");
        emit Minted(tokenId, collectionId, amount, msg.sender, hash);
        return tokenId;
    } 

    function setURI(string memory newuri) public onlyOwner() {
        _setURI(newuri);
    }
    
}