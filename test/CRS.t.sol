// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/CRS.sol";

contract ChallengeTest is Test {
    struct User {
        bytes32 commitment; // Hashed answer submitted by the participant
        address addressUser; // Address of the participant
        string answer; // Revealed answer by the participant
    }

    Challenge public challenge;

    event AnswerRevealed(address indexed participant, string answer);
    event WinnerRevealed(address indexed winner, string winningAnswer);
    function setUp() public {
        challenge = new Challenge();
    }

    function testCommitAnswer() public {
        // Commit an answer using the commit function.
        challenge.commit(keccak256(abi.encodePacked("test1")));
        //Verify that the commitment is recorded correctly by checking the user's commitment in the users array.
    }

    function testRevealAnswer() public {
        // Commit an answer using the commit function.
        challenge.commit(keccak256(abi.encodePacked("test1")));

        //Verify that the commitment is recorded correctly by checking the user's commitment in the users array.

        (bytes32 commit,address user,string memory ans) = challenge.users(0);
        bytes32 answerHash = keccak256((abi.encodePacked("test1")));

        // Start the reveal phase using the startRevealPhase function
        challenge.startRevealPhase();

        // User reveal an answer using the reveal function.
        vm.expectEmit(true, true, false, false);
        emit AnswerRevealed(user, "test1");
        challenge.reveal("test1");

        // Or just do an assert 
        assertEq(commit, answerHash);
    }
}