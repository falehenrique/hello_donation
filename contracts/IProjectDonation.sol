// SPDX-License-Identifier: MIT

// Solidity program to 
// demonstrate the working 
// of the interface
pragma solidity "0.8.10";
  
// A simple interface
interface IProjectDonation {
  
    // Functions having only 
    // declaration not definition

    function addProject(string memory _name, uint _totalFund) external;

    function donation(uint16 codeProject) external payable;

    function checkBalance() external view returns (uint);
}