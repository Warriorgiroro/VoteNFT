// SPDX-License-Identifier: GNU
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VoteNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => address) tokenVoteRecord;
    mapping(uint256 => bool) tokenUsed;
    mapping(address => uint256) voteCount;


    constructor() ERC721("VoteNFT", "Vote") {}

    function safeMint(address to) public onlyOwner {
        require(balanceOf(to) <= 0, "Each voter can only vote once.");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function vote(uint256 tokenId, address to) public {
        require(
            ERC721.ownerOf(tokenId) == _msgSender(),
            "The vote caller is not owner"
        );
        require(_exists(tokenId), "Token doesn't exist");
        require(!tokenUsed[tokenId], "This VoteNFT was used.");

        tokenVoteRecord[tokenId] = to;
        tokenUsed[tokenId] = true;
        voteCount[to] = voteCount[to] + 1;
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public virtual override {
        require(false, "Soul Bounded NFT Can't Transfer.");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(false, "Soul Bounded NFT Can't Transfer.");
    }
}