// SPDX-License-Identifier: GPL-3.0
pragma solidity =0.8.1;

contract DVSC {

    //mapping(address => uint) public balances;
    uint public balance;
    address public owner;
    bool public still_paying;

    // Acess control
    function init() public {
        owner = msg.sender;
    }

    function withdraw_reentrancy(uint _amount) public {
        //require(msg.sender == owner, "Only owner can widthdar");
        require(balance >= _amount );

        //Re-entrancy
        (bool ret,) = msg.sender.call{value: _amount}("");
        require(ret, "Send Failed");
        balance -= _amount;
    }

    function withdraw_noRetCheck(uint _amount) public {
        require(msg.sender == owner, "Only owner can widthdar");
        require(balance >= _amount );
        //balances[msg.sender] -= _amount;
        balance -= _amount;

        // Not catching return values
        msg.sender.call{value: _amount}("");	    
    }
    
    //Overflow Variant
    function deposit(uint _amount) public payable {
        //require(balance + amount >= balance,"Overflow detected");  
        balance+= _amount;
    }

    //Underflow Variant
    function withdraw_underflow(uint _amount) public {
        require(msg.sender == owner, "Only owner can widthdar");
        uint diff = balance - _amount;
        //require(diff >= 0);
        balance -= _amount;

        //Re-entrancy mitigation 
        (bool ret,) = msg.sender.call{value: _amount}("");
        require(ret, "Send Failed");	    
    }

}

/*contract Attack {
    DVSC public dvsc;

    constructor(address _dvscAddress) {
        dvsc = DVSC(_dvscAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (msg.value >= 1 ether) {
            dvsc.withdraw_reentrancy(1);
        }
    }

   // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Helper function to check the balance of this contract
    function deposit(uint _amount) public payable{
        dvsc.deposit(_amount);
    }
}*/

