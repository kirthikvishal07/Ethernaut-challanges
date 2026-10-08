//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Instance} from "../src/ethernaut0.sol";
import {console} from "forge-std/console.sol";


contract ethernaut0Script is Script{

    Instance instance = new Instance("0x10Dcb97E79E7FC0e5b2a3d5d06CF97Ee63213027");

    function run() public{
        string memory password = instance.password();
        console.log(instance.getCleared());
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        instance.authenticate(password);
        console.log(instance.getCleared());
        vm.stopBroadcast();
    }
}