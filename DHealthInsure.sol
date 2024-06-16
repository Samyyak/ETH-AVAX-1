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
