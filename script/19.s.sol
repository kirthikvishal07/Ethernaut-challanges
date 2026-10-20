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

