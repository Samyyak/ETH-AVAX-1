# Eth-Proof_AVAX1 

This Solidity program provides simple functionality for creating a smart contract and using statements like require(),assert() and revert().

## Description

This program consists of simple functions and variables which helps in mapping of the data along with its minting and also helps us to burn the resources as well as transfer them whenever needed with special functionalities of require() , assert () and revert() statements.

## Getting Started

This program contains straightforward functions and variables designed for mapping data, submitting claims , approving and rejecting claims as required.Some special keywords like "event", "emit", require() , assert() and revert () are added as to make the code more functional.

### Executing program

To run this program, you can utilize Remix, an online Solidity IDE. Begin by navigating to the Remix website at https://remix.ethereum.org/.

Once you're on the Remix website, initiate a new file by selecting the "+" icon in the left-hand sidebar. Save the file with a .sol extension (for instance, myToken.sol). Then, copy and paste the provided code into the file.

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedHealthInsurance {
    // Enum to track claim state
    enum ClaimState { Pending, Approved, Rejected }

    // Struct to store claim details
    struct Claim {
        address patient;     // Address of the patient making the claim
        uint amount;         // Amount of the claim in wei
        ClaimState state;    // Current state of the claim (Pending, Approved, Rejected)
        string description;  // Description of the claim
    }

    // Mapping to store claims
    mapping(uint => Claim) public claims;
    uint public claimCount;  // Counter for total number of claims

    // Address of the insurer
    address public insurer;

    // Events
    event ClaimSubmitted(uint claimId, address patient, uint amount, string description);
    event ClaimApproved(uint claimId);
    event ClaimRejected(uint claimId);
    event PayoutProcessed(uint claimId, address patient, uint amount);

    // Constructor to set the insurer address and make it payable
    constructor() payable {
        insurer = msg.sender;
    }

    // Modifier to check if the caller is the insurer
    modifier onlyInsurer() {
        require(msg.sender == insurer, "Only insurer can call this function");
        _;
    }

    // Function to submit a claim
    function submitClaim(uint _amount, string memory _description) external {
        claimCount++;
        claims[claimCount] = Claim({
            patient: msg.sender,
            amount: _amount,
            state: ClaimState.Pending,
            description: _description
        });

        emit ClaimSubmitted(claimCount, msg.sender, _amount, _description);
    }

    // Function to approve a claim
    function approveClaim(uint _claimId) external onlyInsurer {
        Claim storage claim = claims[_claimId];
        
        require(claim.state == ClaimState.Pending, "Claim is not pending");
        
        claim.state = ClaimState.Approved;
        
        emit ClaimApproved(_claimId);

        processPayout(_claimId);
    }

    // Function to reject a claim
    function rejectClaim(uint _claimId) external onlyInsurer {
        Claim storage claim = claims[_claimId];
        
        require(claim.state == ClaimState.Pending, "Claim is not pending");
        
        claim.state = ClaimState.Rejected;
        
        emit ClaimRejected(_claimId);
    }

    // Internal function to process payout
    function processPayout(uint _claimId) internal {
        Claim storage claim = claims[_claimId];
        
        require(claim.state == ClaimState.Approved, "Claim is not approved");

        uint amount = claim.amount;
        claim.amount = 0;
        
        bool payoutSuccess = (payable(claim.patient)).send(amount);
        assert(payoutSuccess);  // Ensure the payout was successful
        
        emit PayoutProcessed(_claimId, claim.patient, amount);
    }

    // Function to get claim state as string
    function getClaimState(uint _claimId) public view returns (string memory) {
        ClaimState state = claims[_claimId].state;
        if (state == ClaimState.Pending) {
            return "Pending";
        } else if (state == ClaimState.Approved) {
            return "Approved";
        } else if (state == ClaimState.Rejected) {
            return "Rejected";
        } else {
            revert("Invalid claim state"); // Revert if state is unknown
        }
    }

    // Fallback function to receive funds
    receive() external payable {}
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile DHealthInsure.sol"(or whatever the file name) button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DHealthInsure" contract from the dropdown menu, and then click on the "Deploy" button.

The project introduces innovative idea of Decentralized Health Insurance System in which the insurer and the paitent have different addresses to functions which can be accessed by the both can differs.The use of require(),assert() and revert() statements places important role in making the project simple, easy to use and robust. These statements eases the complete functionality of the contract and thros understandable errors for better user interaction.

## Authors

Samyak Jain
[@Chandigarh University](www.linkedin.com/in/samyak-jain-179710233/)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
