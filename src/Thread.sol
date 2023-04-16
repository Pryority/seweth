// SPDX-License-Identifier: SHIT
pragma solidity ^0.8.7;

library Thread {
    struct Weave {
        bytes31 placeholder;
        bytes1 opcode;
    }

    function pull(Weave[] memory replacements) internal view {
        // Check if the contract is being called from a constructor
        bool isInsideConstructor;
        assembly {
            isInsideConstructor := iszero(extcodesize(address()))
        }

        // If not called from a constructor, revert
        if (isInsideConstructor == false) {
            revert("injection only works inside constructors");
        }

        // Get the size of the contract's bytecode
        uint256 size;
        assembly {
            size := codesize()
        }

        // Create a bytes array to hold the bytecode
        bytes memory code = new bytes(size);
        assembly {
            codecopy(add(code, 0x20), 0x00, size)
        }

        // Variables to keep track of target code copy offset and size
        bool foundTargetCodecopy;
        uint256 codeOffset = 0;
        uint256 codeSize = 0;

        // Loop through the bytecode to find the target code copy
        for (uint256 i = 0; i < size; i++) {
            // Look for the target code copy pattern
            if (foundTargetCodecopy == false && code[i] == bytes1(0x39)) {
                assembly {
                    let surroundingCode := mload(
                        sub(add(add(code, 0x20), i), 0x1C)
                    )
                    foundTargetCodecopy := eq(
                        shl(208, surroundingCode),
                        // Need to break this up using OR; otherwise we end up finding this string.
                        or(
                            0x6000390000000000000000000000000000000000000000000000000000000000,
                            0x0000006000f30000000000000000000000000000000000000000000000000000
                        )
                    )
                }

                // Once we've found our target, extract the code size and code offset.
                if (foundTargetCodecopy) {
                    // TODO: This is not 100% correct yet. It breaks for large contracts.
                    bytes6 prefix;
                    assembly {
                        prefix := mload(sub(add(add(code, 0x20), i), 0x08))
                    }
                    codeOffset = uint256(uint16(uint48(prefix)));
                    codeSize = uint256(uint16(bytes2(prefix)));
                }
            }

            // Look for placeholders in the bytecode and replace them with specified opcodes
            if (code[i] == bytes1(0x7E)) {
                for (uint256 j = 0; j < replacements.length; j++) {
                    bytes31 placeholder = replacements[j].placeholder;
                    bytes1 opcode = replacements[j].opcode;
                    assembly {
                        let maybePlaceholder := mload(add(add(code, 0x20), i))
                        if eq(shl(8, maybePlaceholder), placeholder) {
                            let replaceBytes := or(
                                opcode,
                                0x005B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B
                            )
                            mstore(add(add(code, 0x20), i), replaceBytes)
                        }
                    }
                }
            }
        }

        // Hack to get around the Solidity optimizer
        assembly {
            let hack := mload(add(code, 0x20))
            let x := add(hack, 0)
        }
        // Update the contract's bytecode with the modified code
        assembly {
            codecopy(0x00, add(code, 0x20), size)
            return(0x00, size)
        }
    }
}
