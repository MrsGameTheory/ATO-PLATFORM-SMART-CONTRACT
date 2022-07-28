// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract ATO_v2 is OwnableUpgradeable {
    struct _Dimension {
        uint256 width;
        uint256 height;
        uint256 length;
    }
    struct _Images {
        string side;
        string front;
        string back;
    }
    struct _Medium {       
        string medium;
        string frame;
        string paint;
        string stone;
        string metals;
        string compounds;
        string organics;
        string mixed;
        string finish;
    }

    struct _Properties {
        uint256 created;            // created year
        uint256 ownercount;         // number of owners
        uint256 size;               // edition size
        uint256 price;              // list price
        string pricolor;            // primary colors
    }
    struct Artwork {
        string artist;              // name of artist
        string birth;               // date of birth of artist
        string title;               // title of artwork
        _Dimension dimensionInInch; // dimensions of artwork
        _Dimension dimensionIncm;   // dimensions of artwork
        string description;         // description of what it looks like
        _Medium mediums;            // mediums used to create
        _Properties properties;     // some addtional info (_properties)
        _Images images;             // images
        string ownerid;
        string artistid;
    }
    struct ArtworkPrivate {
        string sign_location;       // location of signature
        string sign_image;          // image of signature
        bool hasfinger;             // fingerprint is included or not      
        string fp_location;         // location of fingerprint
        string fp_image;            // image of fingerprint
        string finger_miss;
        string owners;              // owner(s) actual names and link to their profile(s)
        string company;             // if an institution or company owns it list address of company 
    }

    // Mapping are cheaper than arrays
    mapping(string => Artwork) public artworks;
    mapping(string => ArtworkPrivate) public privateartworks;

    modifier notContract() {
        require(!_isContract(msg.sender), "Contract not allowed");
        require(msg.sender == tx.origin, "Proxy contract not allowed");
        _;
    }

    event ArtworkSubmit(string _id, Artwork _artwork);

    /**
     * @notice Constructor
     */
    constructor() {

    }

    function init() public {

    }

    function updateArtwork(
        string memory _id,
        Artwork memory artwork,
        ArtworkPrivate memory privateArtiwork
    ) external onlyOwner notContract {
        artworks[_id] = artwork;
        privateartworks[_id] = privateArtiwork;

        emit ArtworkSubmit(_id, artworks[_id]);
    }

    /**
     * @notice Check if an address is a contract
     */
    function _isContract(address _addr) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(_addr)
        }
        return size > 0;
    }

}