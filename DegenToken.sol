// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9; 

contract DegenToken 
{
    string public name = "DEGENTOKEN";
    string public abbr = "DGT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint256) public balances;

    function mint(address _to, uint256 _amount) public {
        require(msg.sender == owner, "The tokens can only be minted by the owner of this contract");
        require(_amount > 0, "Please specify an amount greater than 0");
        balances[_to] += _amount;
        totalSupply += _amount;
    }

    function burn(address _from, uint256 _amount) public {
        require(_amount <= balances[_from], "Amount cannot be greater than balance");
        balances[_from] -= _amount;
        totalSupply -= _amount;
    }

    function redeem(address _to, uint256 _amount, uint256 _storeItem) public { 
        require(_amount <= balances[_to], "Amount cannot be greater than balance");
        if (_storeItem == 1) {
            require(_amount >= 50, "You don't have enough tokens for Flaming Sword");
            burn(_to, _amount);
        } else if (_storeItem == 2) {
            require(_amount >= 100, "You don't have enough tokens for Hydron Canon");
            burn(_to, _amount);
        } else if (_storeItem == 3) {
            require(_amount>=200, "You don't have enough tokens for Omnipotent Chakra");
            burn(_to, _amount);
        } else {
            revert("The store item is invalid");
        }
    }
    
    function transfer(address _to, uint256 _amount) public {
        require(_amount <= balances[msg.sender], "Amount cannot be greater than balance");
        require(_to != address(0), "This is an invalid address");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}