//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

// ERC20 interface implementation for Tether and USDC transfers
interface IERC20 {
    function transfer(address _to, uint256 _value) external returns (bool);
}

// Interface for price oracles from @chainlink
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

// Contract implementatin
contract EthPriceBet {

    address gcr = 0xdA27937582B0ed4211e9C322778658b7B151e44d;
    address dokwon = 0x4Ef3933d49689E05A3d337c73F4B7F40C5E9b5dE;
    uint start = block.timestamp;
    
    function claimReward() external {

      // check eth price here
      require(getLatestPrice() < 3500, "ETH Price is lower than 3500");
      
      // has enough time passed?
      require(block.timestamp >  start + 3 minutes, "Not enough time has passed");

      // send winnings
      sendUSDT(gcr, 1000);
    }

    AggregatorV3Interface internal priceFeed;
      
    function sendUSDT(address _to, uint256 _amount) internal {
        IERC20 usdt = IERC20(address(0xD92E713d051C37EbB2561803a3b5FBAbc4962431));
        usdt.transfer(_to, _amount);
    }

    function sendUSDC(address _to, uint256 _amount) internal {
        IERC20 usdc = IERC20(address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48));
        usdc.transfer(_to, _amount);
    }

    /**
     * Network: Rinkeby
     * Aggregator: ETH/USD
     * Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    }

    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }   


}
