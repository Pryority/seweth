// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Needle.sol";
import "../src/Thread.sol";
import "../src/Game.sol";

contract GameTest is Test {
    Game public game;
    Needle public needle;
    Thread public thread;

    function setUp() public {
        game = new Game();
        needle = new Needle();
        thread = new Thread();
    }
}
