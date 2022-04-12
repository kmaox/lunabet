//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

interface IERC20 {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract LunaBet {
    
    function sendUSDT(address _to, uint256 _amount) internal {
        IERC20 usdt = IERC20(address(0xdAC17F958D2ee523a2206206994597C13D831ec7));
        usdt.transfer(_to, _amount);
    }

    function sendUSDC(address _to, uint256 _amount) internal {
        IERC20 usdc = IERC20(address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48));
        usdc.transfer(_to, _amount);
    }
}