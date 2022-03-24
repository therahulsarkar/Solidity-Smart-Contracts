// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

abstract contract RandomNumber is VRFConsumerBase {
    bytes32 internal keyHash; //Identifies which chainlink oracle to use 
    uint internal fee;        //Fee to get random number
    uint public randomResult;

 constructor() VRFConsumerBase(
            	0x6168499c0cFfCaCD319c818142124B7A15E857ab, //VRF Coordinator, this contract verifies the randomness the number returned by chainlink
                0x01BE23585060835E02B77ef475b0Cc51aA1e0709 //LINK token address
        )
        {
            keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;
            fee = 0.25 * 10 ** 18; //0.25 LINK in gwei
        }

        function getRandomNumber() public returns (bytes32 requestId){
            require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK in contract");
            return requestRandomness(keyHash, fee); 
        }

        function fullfillRandomness(/*bytes32 requestId,*/ uint randomness) internal   {
            randomResult = randomness;
        }

    }
