// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Needle.sol";
import "../src/Thread.sol";

contract NeedleTest is Test {
    Needle public needle;

    function setUp() public {
        needle = new Needle();
    }

    function testSetUp() public {
        // Retrieve the value of silk using the public getter function
        Thread.Weave[] memory silk = needle.getSilk();

        // Compare the value of silk with the expected value
        assertEq(
            silk[0].placeholder,
            hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B"
        );
        assertEq(silk[0].opcode, bytes1(0x60));
    }

    function testSilk() public {
        // Retrieve the value of silk using the public getter function
        Thread.Weave[] memory silk = needle.getSilk();

        // Compare the value of silk with the expected value
        assertEq(
            silk[0].placeholder,
            hex"5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B"
        );
    }

    // function testDoInjection() public {
    //     // Call the doInjection function with a sample input
    //     needle.doInjection();

    //     // Retrieve the value of silk using the public getter function
    //     Thread.Weave[] memory silk = needle.getSilk();

    //     // Assert that the value of silk has been updated to the expected value
    //     assertEq(silk[0].placeholder, hex"0123456789abcdef");
    // }
}
