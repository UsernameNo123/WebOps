// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract tryingBank{
    address public owner;
    //bool public paused;
    mapping(address => uint) internal balance;
    mapping(address => uint256[]) public loanList;
    mapping(address => uint256[]) public loanTime;
    address[] internal userList;
    bool public existing = false;
    
    uint8 counter=0;
    function inputUserID(address userID) public{
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
    function getUserList()public view returns (address[] memory){
        return userList;
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

    function loan(uint256 loan_amount , uint256 total_collateral) public {
        require(total_collateral >= (loan_amount)/2, "Sorry you are ineligible for loan");
        balance[msg.sender] += loan_amount;
        loanList[msg.sender].push(loan_amount);
        loanTime[msg.sender].push(block.timestamp); //msg.sender is the borrower
    }

    function repayLoan(uint8 loanamount,uint8 LoanID) public{
        uint256 timestamp = block.timestamp;
        uint256 time = loanTime[msg.sender][LoanID];
        if(timestamp-time >= 60){
            loanamount += 100;
        }
        balance[msg.sender] -=loanamount;
    }
}
