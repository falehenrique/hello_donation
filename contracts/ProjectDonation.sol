// SPDX-License-Identifier: MIT

pragma solidity "0.8.10";
/**
constructor
fallback function (if exists)
external
public
internal
private
*/
import "./Organization.sol";
import "./IProjectDonation.sol";
import "./IERC20.sol";

contract ProjectDonation is Organization, IProjectDonation {

    uint16 lastCodeProject = 0;

    Project[] public projects;
    mapping (uint16 => Project) public projectsCode;
    mapping (uint16 => Donation[]) public projectsDonations;
    Donation[] public donations;
    
    IERC20 public tokenERC20;

    struct Project {
        uint16 codeProject;
        string name;
        uint totalFund;
    }

    struct Donation {
        uint16 codeProject;
        address donator;
        uint value;
    }    
    
    event ProjetCreated(uint16 newCodeProject, address owner, string name, uint totalFund);

    constructor() {
        Organization(msg.sender);
    }

    receive() external payable {
        revert("You can use the app to donation");
    }

    // function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]
    //https://stackoverflow.com/questions/58258808/data-location-must-be-memory-for-return-parameter-in-function-but-none-was-gi
    function addProject(string memory _name, uint _totalFund) override public {
        require(owner_ong == msg.sender, "Only the owner can create new projects donation!!!");
        uint16  newCodeProject = lastCodeProject++;
        Project memory project = Project(newCodeProject, _name, _totalFund);
        //add in list
        projects.push(project);
        //add in map with the code key project 
        projectsCode[newCodeProject] = project;
        emit ProjetCreated(newCodeProject, msg.sender, _name, _totalFund);
    }

    function donation(uint16 codeProject) override public payable {
        assert(address(this).balance + msg.value > address(this).balance);
        Donation memory d = Donation(codeProject, msg.sender, msg.value);
        projectsDonations[codeProject].push(d);
    }

    function checkBalance() override public view returns (uint){
        return address(this).balance;
    }

    function setTokenERC20(address _token) public {
        tokenERC20 = IERC20(_token);
    }
}