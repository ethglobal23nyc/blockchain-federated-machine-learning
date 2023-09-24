// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the LilypadCallerInterface
// https://github.com/bacalhau-project/lilypad/tree/main/hardhat
import "./LilypadCallerInterface.sol";

contract PaymentGateway is LilypadCallerInterface {
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

        // Call the LilypadEvents contract to trigger a job
        LilypadEvents lilypadEvents = LilypadEvents(0xMyLilypadEventsContractAddress);
        lilypadEvents.runLilypadJob("YourDockerSpecJSONData", address(this), amount);
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

    // Implement the lilypadFulfilled callback function
    function lilypadFulfilled(
        address _from,
        uint256 _jobId,
        LilypadResultType _resultType,
        string calldata _result
    ) external override {
        // Handle the successful completion of the Lilypad job here
    }

    // Implement the lilypadCancelled callback function
    function lilypadCancelled(address _from, uint256 _jobId, string calldata _errorMsg) external override {
        // Handle the cancellation or failure of the Lilypad job here
    }
}
