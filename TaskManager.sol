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
