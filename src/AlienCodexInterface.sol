// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAlienCodex {
    function makeContact() external;
    function retract() external;
    function revise(uint256 i, bytes32 content) external;
    function owner() external view returns (address);
}