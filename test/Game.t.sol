// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Needle.sol";
import "../src/Thread.sol";
import "../src/Game.sol";

contract NeedleTest is Test {
    Game public game;

    function setUp() public {
        game = new Game();
    }
}
