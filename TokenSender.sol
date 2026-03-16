// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract TokenDistributor {

    address public owner;
    IERC20 public wipToken;

    constructor(address _wipToken) {
        owner = msg.sender;
        wipToken = IERC20(_wipToken);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function deposit(uint256 amount) external onlyOwner {
        wipToken.transferFrom(msg.sender, address(this), amount);
    }

    function sendReward(address user, uint256 amount) external onlyOwner {
        wipToken.transfer(user, amount);
    }

    function contractBalance() external view returns(uint256) {
        return wipToken.balanceOf(address(this));
    }
}
