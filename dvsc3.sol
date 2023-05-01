pragma solidity =0.4.1;

contract DVSC3 {

    // private values such as solutions to puzzles for PoW and RSA private keys should never be stored in contracts
    // since contracts are public, anyone can see its contents
    //Front running
    uint mySecretSol = 75;

    //Bad Randomness Variant 1
    function bad_random1() public payable {
        require(msg.value >= 1 ether);
        // using the hash of a block number to generate a random number is vulnerable
        // if a recent block number is used, it is easy for an attacker to recreate the hash
        if (block.blockhash(blockNumber) % 2 == 0) {
            msg.sender.transfer(this.balance);
        }
    } 

    //Bad Randomness Variant 2
    function bad_random2() public payable {

    uint 256 private seed;    
	require(msg.value >= 1 ether);
	iteration++;
	uint randomNumber = uint(keccak256(seed + iteration));
	if (randomNumber % 2 == 0) {
		msg.sender.transfer(this.balance);
	}
}

}