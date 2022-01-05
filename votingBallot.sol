// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ballot {
   
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to
        uint vote;   // index of the voted proposal
    }

    struct Proposal {
        bytes32 name;   
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    mapping(address => Voter) public voters;

    Proposal[] public proposals;

    // Constructor run when Contract is first initialized
    constructor(bytes32[3] memory proposalNames=["Conservative Party","Labour Party","Robert"]) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // Adding all the proposal names into the proposals array
        for (uint i = 0; i  proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    /**
    Gives a voter address the right to vote. This is called only by the Chairperson
    */
    function giveRightToVote(address voter) public {
        
    }

    /*
    Used to delegate a vote
    */
    function delegate(address to) public {
    }

    /*
    Used to cast vote ( including votes delegated to person )
    */
    function vote(uint proposal) public {
    }

    /*
    Calculating Votes
     */
    function winningProposal() public view
        
    }


    function winnerName() public view
            
    }

}