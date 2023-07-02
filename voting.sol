pragma solidity ^0.8.0;

contract VotingSystem {
    // Structure to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping to store candidates
    mapping(uint => Candidate) public candidates;

    // Mapping to keep track of whether an address has voted
    mapping(address => bool) public voters;

    // Total number of candidates
    uint public totalCandidates;

    // Event triggered when a vote is cast
    event VoteCast(uint indexed candidateId);

    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    // Function to add a candidate
    function addCandidate(string memory _name) private {
        totalCandidates++;
        candidates[totalCandidates] = Candidate(totalCandidates, _name, 0);
    }

    // Function to cast a vote
    function vote(uint _candidateId) public {
        // Check if the sender has already voted
        require(!voters[msg.sender], "You have already voted.");

        // Check if the candidate exists
        require(_candidateId > 0 && _candidateId <= totalCandidates, "Invalid candidate.");

        // Record the vote
        candidates[_candidateId].voteCount++;
        voters[msg.sender] = true;

        // Trigger the VoteCast event
        emit VoteCast(_candidateId);
    }

    // Function to get the total votes for a candidate
    function getTotalVotes(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= totalCandidates, "Invalid candidate.");
        return candidates[_candidateId].voteCount;
    }
}
