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
        require(
            msg.sender == chairperson,
            "Only chairperson can call this."
        );
        // Check if voter hasn't already voted
        require(
            !voters[voter].voted,
            "The voter has already casted their vote."
        );
        // Check voter has not been given the right to vote before
        require(voters[voter].weight == 0);
        // Voting rights assigned. Can now cast 1 vote
        voters[voter].weight = 1;
    }

    /*
    Used to delegate a vote
    */
    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You have already voted.");
        require(to != msg.sender, "You can't delegate a vote to yourself.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // We found a loop in the delegation, not allowed.
            require(to != msg.sender, "Found loop in delegation.");
        }
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            // If the delegate already voted,
            // directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to their weight.
            delegate_.weight += sender.weight;
        }
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