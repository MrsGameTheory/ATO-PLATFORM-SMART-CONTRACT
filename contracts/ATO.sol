// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ATO is Ownable {
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
    struct Artwork {
        string artist;
        string title;
        string description;
        _Images images;
        _Dimension dimensionInInch;
        _Dimension dimensionIncm;
        uint256 price;
        string owner;
    }

    // Mapping are cheaper than arrays
    mapping(string => Artwork) public artworks;

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

    /**
     */
    function updateArtwork(
        string memory _id, 
        string memory _artist,
        string memory _title,
        string memory _description,
        string memory _image_side,
        string memory _image_front,
        string memory _image_back,
        _Dimension memory _dimensionInInch,
        _Dimension memory _dimensionIncm,
        uint256 _price,
        string memory _owner
    ) external onlyOwner notContract {
        artworks[_id] = Artwork({
            artist: _artist,
            title: _title,
            description: _description,
            images: _Images({
                side: _image_side,
                front: _image_front,
                back: _image_back
            }),
            dimensionInInch: _dimensionInInch,
            dimensionIncm: _dimensionIncm,
            price: _price,
            owner: _owner
        });

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