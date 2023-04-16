// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./Thread.sol";

contract Needle {
    // Define the replacements to be made in the bytecode
    Thread.Weave[] public fabric;

    constructor() {
        // Add replacements here
        fabric.push(
            Thread.Weave({
                placeholder: hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B",
                opcode: bytes1(0x60)
            })
        );
    }

    function pull() public view {
        // Call the inject function from the library with the replacements
        Thread.pull(fabric);
    }

    function sew(Thread.Weave memory pin) public {
        fabric.push(pin);
    }

    function getFabric() public view returns (Thread.Weave[] memory) {
        return fabric;
    }
}
