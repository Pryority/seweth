// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Needle.sol";
import "../src/Thread.sol";
import "../src/Game.sol";

contract GameTest is Test {
    Game public game;
    Thread.Weave[] public fabric;
    Thread.Weave[] initPatch;

    function setUp() public {
        game = new Game();
    }

    function testSetup() public {
        Thread.Weave[] memory expectedFabric = new Thread.Weave[](1);
        expectedFabric[0] = Thread.Weave({
            placeholder: hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B",
            opcode: bytes1(0x60)
        });

        Thread.Weave[] memory actualFabric = game.getFabric();
        assertEq(
            actualFabric[0].placeholder,
            expectedFabric[0].placeholder,
            "fabric[0].placeholder should match expected value"
        );
        assertEq(
            actualFabric[0].opcode,
            expectedFabric[0].opcode,
            "fabric[0].opcode should match expected value"
        );
    }

    function testPlayGame() public {
        // Call the playGame function
        game.playGame();

        // Check if gameScore is incremented by 1
        assertEq(game.gameScore(), 1, "gameScore should be incremented by 1");

        // Check if isGameOver is false
        assertEq(game.isGameOver(), false, "isGameOver should be false");

        // Check if fabric is updated with a new patch
        Thread.Weave[] memory expectedFabric = new Thread.Weave[](1);
        expectedFabric[0] = Thread.Weave({
            placeholder: hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B",
            opcode: bytes1(0x01)
        });

        Thread.Weave[] memory actualFabric = game.getFabric(); // Fix: Use getFabric() function to get the actual fabric
        assertEq(
            actualFabric[0].placeholder,
            expectedFabric[0].placeholder,
            "fabric[0].placeholder should match expected value"
        );
        assertEq(
            actualFabric[0].opcode,
            expectedFabric[0].opcode,
            "fabric[0].opcode should match expected value"
        );
    }
}
