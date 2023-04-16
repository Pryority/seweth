// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./Thread.sol";

contract Needle {
    // Define the replacements to be made in the bytecode
    Thread.Weave[] public silk;

    constructor() {
        // Add replacements here
        silk.push(
            Thread.Weave({
                placeholder: hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B",
                opcode: bytes1(0x60)
            })
        );
    }

    function doInjection() public view {
        // Call the inject function from the library with the replacements
        Thread.inject(silk);
    }

    function getSilk() public view returns (Thread.Weave[] memory) {
        return silk;
    }
}
