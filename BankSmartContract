// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract tryingBank{
    address public owner;
    bool public paused;
    mapping(address => uint) public balance;
    address[] public userList;
    address public userID;
    constructor (){
        userID = msg.sender;
        //paused = false;
        //balance[owner] = 100000;
    }
    modifier isOwner(){
        require(msg.sender == owner, "sorry mate, you ain't the owner!");
        _;
    }

    modifier isPaused(){
        require(paused == false, "I ain't on pause!");
        _;
    }

    function pause() public isOwner{
        paused = true; 
    }
    function notPause() public isOwner{
        paused = false;
    }

    function transfer(address to , uint256 amount) public {
        require(balance[msg.sender] > amount, "Sorry, you ain't got enought money");
        balance[msg.sender] = balance[msg.sender]-amount;
        balance[to] += amount;
    }

    function BalanceDisplay() public view returns (uint256){
        return balance[msg.sender];
    }

    function withdrawal(uint256 amount) public {
        require(balance[msg.sender]>amount,"You ain't got enough money");
        balance[msg.sender] -= amount;
    }

    function loan(uint256 loan_amount ) public {
        require(balance[msg.sender] >= (loan_amount)/2, "Sorry you are ineligible for loan");
        balance[msg.sender] += loan_amount;  //msg.sender is the borrower
    }

}
