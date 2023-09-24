// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentGateway {
    address public owner; // Owner of the contract
    address public backendAddress; // Address of the backend authorized to make payments

    constructor(address _backendAddress) {
        owner = msg.sender;
        backendAddress = _backendAddress;
    }

    // Receive payments into the contract
    receive() external payable {
        // This function can receive payments
    }

    // Function to make a payment to a specific address
    function makePayment(address payable recipient, uint256 amount) external {
        require(msg.sender == backendAddress, "Only the backend can make payments");
        require(address(this).balance >= amount, "Insufficient balance in the contract");

        recipient.transfer(amount);
    }

    // Function to withdraw funds from the contract (only the owner)
    function withdraw(uint256 amount) external {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(address(this).balance >= amount, "Insufficient balance in the contract");

        payable(owner).transfer(amount);
    }

    // Function to change the backend address (only the owner)
    function setBackendAddress(address newBackendAddress) external {
        require(msg.sender == owner, "Only the owner can change the backend address");
        backendAddress = newBackendAddress;
    }
}
