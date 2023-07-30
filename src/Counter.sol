// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "openzeppelin/access/Ownable.sol";

contract Counter is Ownable {
    constructor() payable {}

    function withdraw() public onlyOwner{
        (bool owner, ) = payable(owner()).call{value: address(this).balance}("");
        require(owner);
    }
}
