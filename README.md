# Eth-Proof_AVAX1 

This Solidity program provides simple functionality for creating a smart contract and using statements like require(),assert() and revert().

## Description

This program consists of simple functions and variables which helps in mapping of the data along with its minting and also helps us to burn the resources as well as transfer them whenever needed with special functionalities of require() , assert () and revert() statements.

## Getting Started

This program contains straightforward functions and variables designed for mapping data, minting tokens, burning and trasnfering resources as necessary.Some special keywords like "event", "emit", require() , assert() and revert () are added as to make the code more functional.

### Executing program

To run this program, you can utilize Remix, an online Solidity IDE. Begin by navigating to the Remix website at https://remix.ethereum.org/.

Once you're on the Remix website, initiate a new file by selecting the "+" icon in the left-hand sidebar. Save the file with a .sol extension (for instance, myToken.sol). Then, copy and paste the provided code into the file.

```javascript
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
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile myToken.sol"(or whatever the file name) button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "myToken" contract from the dropdown menu, and then click on the "Deploy" button.

Now inorder for the Deployment to work we have to enter the TokenName and TokenAbbreviation beforehand. Then the project will be deployed after which we can select any of the default addresses given before hand to us. 
The address copied can be used to mint tokens and burn tokens on that address as well as transfering them to another address.The functions like require() , assert() and revert() statements make the code more functional and provides more robust as well.

## Authors

Samyak Jain
[@Chandigarh University](www.linkedin.com/in/samyak-jain-179710233/)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
