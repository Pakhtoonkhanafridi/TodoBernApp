// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Todo
{
    struct Task
    {
        uint Id;
        string name ;
        string date;
    }

    address owner;
    Task task;
    mapping (uint=>Task) tasks; // list of all tasks
    uint taskId=1;  // taskId

    modifier checkId(uint id)
    {
        require(id!=0 && id<taskId,"Invalid Id");
        _;
    } 
    modifier checkOwner()
    {
        require(owner==msg.sender , "Invalid owner");
        _;
    }
    constructor()
    {
        owner=msg.sender;
    }

    function createTask(string calldata _taskName, string calldata _date) public 
    {
        tasks[taskId]=Task(taskId, _taskName,_date);
        taskId++;
    }

    function updateTask(uint _taskId,string calldata _taskName, string calldata _date)checkId(_taskId) public 
    {
        tasks[_taskId]=Task(_taskId,_taskName,_date);
    }

    function allTask() public view returns(Task[] memory)
    {
        Task[] memory taskList = new Task[](taskId-1); // array ->length -> taskId-1
        for(uint i=0; i<taskId-1; i++)
        {
            taskList[i]=tasks[i+1];
        }
        return taskList; // We can not represent the all mapping because of that we use the array
    }
 
    function viewTask(uint _taskId) checkId(_taskId) public view returns(Task memory )
    {
        return tasks[_taskId];
    }
    
    // 1 , blockchian , 4-6-204
    //after delete 0, " " , 0
    function deleteTask(uint _taskId) checkId(_taskId) public 
    {
        delete tasks[_taskId];
    }




}