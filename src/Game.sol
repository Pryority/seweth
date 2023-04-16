// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Thread.sol";
import "./Needle.sol";

contract Game {
    // Define the game state
    uint public gameScore;
    bool public isGameOver;

    Needle needle;

    Thread.Weave[] public fabric;

    function playGame() public {
        require(!isGameOver, "Game over");

        gameScore += 1;

        if (gameScore >= 10) {
            isGameOver = true;
        }

        for (uint i = 0; i < fabric.length; i++) {
            Thread.Weave memory replacement = fabric[i];

            // Replace the opcode at the placeholder in the game logic
            bytes memory gameLogic = abi.encodePacked(
                replacement.opcode,
                gameScore
            );
        }

        // Create the new patch fabric
        Thread.Weave memory patch = Thread.Weave({
            placeholder: hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B",
            opcode: bytes1(0x01)
        });

        // Apply the new fabric to patch the game logic
        sew(patch);
    }

    // function getFabric() public view returns (Thread.Weave memory) {
    //     return;
    // }

    // Allow game developers to inject custom logic at runtime
    function sew(Thread.Weave memory pin) public {
        fabric.push(pin);
    }
}
