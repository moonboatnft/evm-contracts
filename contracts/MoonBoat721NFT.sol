// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


interface Collections { 
	function checkOwner(uint collectionId, address user) external view returns (bool);
}

contract NFT721 is ERC721, Ownable {
    constructor(address collectionsAddress) ERC721("MoonBoat NFT", "MoonBoat") {
        collectionsContract = Collections(collectionsAddress);
    }
    event Minted(uint tokenId, uint collectionId, address user, bytes32 hash);
    string private baseTokenURI= 'uri';
    string private _name = 'MoonBoat NFT';
    uint tokenId = 1;
    mapping(uint => uint) public assets; // tokenId => collectionsId
    Collections collectionsContract;

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return string(abi.encodePacked(baseTokenURI, Strings.toString(_tokenId)));
    }
    
    function setBaseTokenURI(string memory _baseTokenURI) external onlyOwner {
        baseTokenURI = _baseTokenURI;
    }


    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function mint(uint collectionId, bytes32 hash) public returns (uint){
        require(collectionsContract.checkOwner(collectionId, msg.sender), "collectionId error");
        tokenId++;
        assets[tokenId] = collectionId;
        _safeMint(msg.sender, tokenId);
        emit Minted(tokenId, collectionId, msg.sender, hash);
        return tokenId;
    } 
    
}