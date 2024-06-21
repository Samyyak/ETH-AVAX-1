# Eth-Proof_AVAX1 

This Solidity program provides simple functionality for creating a smart contract and using statements like require(),assert() and revert().

## Description

This program consists of simple functions and variables which helps in mapping of the data along with its minting and also helps us to burn the resources as well as transfer them whenever needed with special functionalities of require() , assert () and revert() statements.

## Getting Started

This program contains straightforward functions and variables designed for mapping data, submitting claims , approving and rejecting claims as required.Some special keywords like "event", "emit", require() , assert() and revert () are added as to make the code more functional.

### Executing program

To run this program, you can utilize Remix, an online Solidity IDE. Begin by navigating to the Remix website at https://remix.ethereum.org/.

Once you're on the Remix website, initiate a new file by selecting the "+" icon in the left-hand sidebar. Save the file with a .sol extension (for instance, myToken.sol). Then, copy and paste the provided code into the file.

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {
    struct Task {
        string description;
        bool isCompleted;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;
    bool public isClosed;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }

    constructor() {
        owner = msg.sender;
        isClosed = false;
    }

    function addTask(string memory _description) public {
        require(!isClosed, "Task management is closed.");
        taskCount++;
        tasks[taskCount] = Task(_description, false);
    }

    function completeTask(uint256 _taskId) public {
        require(!isClosed, "Task management is closed.");
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID.");

        Task storage task = tasks[_taskId];
        require(!task.isCompleted, "Task already completed.");

        task.isCompleted = true;

        // Using assert to check an invariant
        assert(task.isCompleted == true);
    }

    function getTaskDetails(uint256 _taskId) public view returns (string memory description, bool isCompleted) {
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID.");
        Task storage task = tasks[_taskId];
        return (task.description, task.isCompleted);
    }

    function closeTaskManagement() public onlyOwner {
        require(!isClosed, "Task management is already closed.");
        isClosed = true;

        if (taskCount == 0) {
            revert("No tasks have been added.");
        }
    }

    function getTaskSummary() public view returns (uint256 totalTasks, uint256 completedTasks) {
        require(isClosed, "Task management is still ongoing.");
        uint256 completedCount = 0;
        for (uint256 i = 1; i <= taskCount; i++) {
            if (tasks[i].isCompleted) {
                completedCount++;
            }
        }
        return (taskCount, completedCount);
    }
}


```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile TaskManager.sol"(or whatever the file name) button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "TaskManager" contract from the dropdown menu, and then click on the "Deploy" button.

The project introduces innovative idea of Task Management System in which the owner of the contract has the right to add tasks and complete task as well as see its status.The use of require(),assert() and revert() statements places important role in making the project simple, easy to use and robust. These statements eases the complete functionality of the contract and thros understandable errors for better user interaction.

## Authors

Samyak Jain
[@Chandigarh University](www.linkedin.com/in/samyak-jain-179710233/)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
