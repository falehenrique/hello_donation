// SPDX-License-Identifier: MIT
pragma solidity "0.8.10";

contract Organization {
    address public owner_ong;

    event Changed_Owner(address new_ownwer, address oldOwner); // Event

    constructor() {
        owner_ong = msg.sender;
    }

    function change_owner() public returns (address new_ownwer) {
        require(owner_ong == msg.sender, "Only the owner can change the contract");
        emit Changed_Owner(msg.sender, owner_ong);
        owner_ong = msg.sender;
        return msg.sender;
    }

    //withdraw


    //checkBalance
}