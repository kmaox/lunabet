//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import '@openzeppelin/contracts/access/Ownable.sol';
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


interface IERC20 {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract lunaBet {
    AggregatorV3Interface internal priceFeed;
    priceFeed = AggregatorV3Interface(0x91E9331556ED76C9393055719986409e11b56f73);

    uint256 lunaPrice = 125.95;

    function claimRewards() external onlyOwner {
        require(block.timestamp >= today + 300 days, "The bet has not ended");
        
    }

    function sendUSDT(address _to, uint256 _amount) internal {
        IERC20 usdt = IERC20(address(0xdAC17F958D2ee523a2206206994597C13D831ec7));
        usdt.transfer(_to, _amount);
    }

    function sendUSDC(address _to, uint256 _amount) internal {
        IERC20 usdc = IERC20(address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48));
        usdc.transfer(_to, _amount);
    }
    
    function getLatestPrice() public view returns (int) {
    (
        uint80 roundID, 
        int price,
        uint startedAt,
        uint timeStamp,
        uint80 answeredInRound
    ) = lunaPrice.latestRoundData();
        return price;
    }

}