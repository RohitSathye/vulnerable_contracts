// SPDX-License-Identifier: GPL-3.0
pragma solidity =0.4.1;

contract DVSC2 {

    uint public answer;
    bool neverPlayed;
    //Arthmetic exploit : deprecated data-types
    function loop_arithmetic() public {
        uint value = 1000;
        for (var i = 0; i < value; i ++) {
            answer = i;
        }

        // When i goes past 255, it wraps back to 0;
        // The loop continues for ever and runs out of gas.
    }
    //Time Dependence Exploit

    function time_exploit() public {
	require(now > 1521763200 && neverPlayed == true);
	neverPlayed = false;
	msg.sender.transfer(1500 ether);
    }
}