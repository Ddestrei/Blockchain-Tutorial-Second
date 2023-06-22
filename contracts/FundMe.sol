// SPDX-License-Identifier: MIT 
// SPDX-Licence-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "/Users/Patryk/.brownie/packages/smartcontractkit/chainlink-brownie-contracts@0.2.2/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    // in gwei 1000000000
    mapping(address => uint256) public addressToAmountFound;
    address[] public funders;
    address public owner;

    constructor(){
      owner = msg.sender;
    }

    modifier checkOwner(){
      require(msg.sender == owner, "you can not withdrow the founds!!!");
      _;
    }

    function withdrow() public payable checkOwner {
      payable(owner).transfer(address(this).balance);
      for (uint256 i=0;i<funders.length; i++){
          address funder = funders[i];
          addressToAmountFound[funder] = 0;
      }
      funders = new address[](0);
    }

    function fund() public payable {
      addressToAmountFound[msg.sender] +=(msg.value/1000000000);
      funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
      return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
      (,int256 answer,,,
      ) = priceFeed.latestRoundData();
      return uint256(answer*10000000000);
    }
    //1000000000
    function getConversion(uint256 ethAmount) public view returns(uint256){
      uint256 ethPrice = getPrice();
      uint ethAmountInUsd = (ethPrice * ethAmount)/1000000000000000000;
      return ethAmountInUsd;
    }
}

