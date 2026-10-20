
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {MagicNum} from "src/ethernaut18.sol";

contract ethernaut18Script is Script {
    MagicNum instance =
        MagicNum(payable(0xBfe2B6A46B4BF306922098c88Bb68AFc408BE5D8));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attacker attack = new Attacker(instance);

        vm.stopBroadcast();
    }
}

contract Attacker {
    constructor(MagicNum target) {
        // Creation code + 10-byte runtime code.
        bytes memory bytecode =
            hex"600a600c600039600a6000f3602a60005260206000f3";

        address solver;

        assembly {
            solver := create(
                0,
                add(bytecode, 0x20),
                mload(bytecode)
            )
        }

        require(solver != address(0), "Solver deployment failed");
        require(solver.code.length == 10, "Invalid runtime size");

        target.setSolver(solver);
    }
}
