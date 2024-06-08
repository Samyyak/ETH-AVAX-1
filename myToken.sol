// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {

    string public tokenName = "Quantum Coin";
    string public tokenAbbrv = "QTC";
    uint public totalSupply = 0;

    mapping(address => uint) public balance;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    modifier validAddress(address addr) {
        require(addr != address(0), "Invalid address");
        _;
    }

    function mint(address Address, uint Value) public validAddress(Address) {
        uint initialBalance = balance[Address];
        totalSupply += Value;
        balance[Address] += Value;
        assert(balance[Address] == initialBalance + Value);
        emit Mint(Address, Value); 
    }

    function burn(address Address, uint Value) public validAddress(Address) {
        require(balance[Address] >= Value, "Insufficient balance to burn");
        assert(totalSupply >= Value);
        totalSupply -= Value;
        balance[Address] -= Value;
        emit Burn(Address, Value); 
    }

    function transfer(address from, address to, uint Value) public validAddress(from) validAddress(to) {
        require(balance[from] >= Value, "Insufficient balance to transfer");
        require(from != to, "Sender and recipient addresses cannot be the same");
        if (Value == 0) {
            revert("Transfer amount cannot be zero");
        }
        balance[from] -= Value;
        balance[to] += Value;
        emit Transfer(from, to, Value); 
    }
}
