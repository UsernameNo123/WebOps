// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract MutualFunds{
    address internal owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    mapping(address => uint) internal balance;
    mapping(address => uint256) public investmentList;
    mapping(address => uint256[]) public investmentTime;
    address[] internal userList;
    bool internal existing = false;
    uint8 internal counter=0;
    uint256 public owner_balance = 0;
    function loginpage(address userID) public
    {
        for(uint8 i=0;i<userList.length;i++){
            //require(userList[i]==msg.sender , userList.push(msg.sender));
            if(userList[i]==userID){
                existing = true;
                break;
            }
            else{
                counter++;
            }
        }
        if(counter == userList.length){
            userList.push(userID);
            existing = true;
        }
        if(existing == true && counter != userList.length){
            balance[userID]= 100000;
        }
    }

    function Make_Investment(uint256 amount) external
    {   
        require(amount <= balance[msg.sender], "You don't have money mate!");
        if(amount <= balance[msg.sender]){
            owner_balance += amount;
            balance[msg.sender] -=amount;
            investmentList[msg.sender] += amount;
            investmentTime[msg.sender].push(block.timestamp);
        }
        
    }

    function Withdraw_Investment (uint256 amount) external {
        require(amount <= investmentList[msg.sender], "You don't have sufficient balance");
        
        if(amount <= investmentList[msg.sender])
        {
            balance[msg.sender] += amount;
            owner_balance -= amount;
            investmentList[msg.sender] -= amount;
        }
    }

}
