pragma solidity ^0.4.24;
//pragma experimental ABIEncoderV2;

contract Flappy {
    /* Define variable owner of the type address */



    uint private highScore = 0;
    address private highScoreAddress;
    uint private payout;
    uint64[] public topTen;

    address owner;
    bytes32 name;

    constructor(bytes32 _name) public {
        // State variables are accessed via their name
        // and not via e.g. this.owner. This also applies
        // to functions and especially in the constructors,
        // you can only call them like that ("internally"),
        // because the contract itself does not exist yet.
        owner = msg.sender;
        // We do an explicit type conversion from `address`
        // to `TokenCreator` and assume that the type of
        // the calling contract is TokenCreator, there is
        // no real way to check that.

        name = _name;
    }


    function() payable public {
    }

    struct player{
        address addr;
        uint score;
    }

    player[] leaderboard;



    //when someone plays, they send eth to the smart contract that is added to the pot
    //when they are finished playing, their score and address get sent to this contract
    //their score and address is added to the ranking list, and removed if not in top 10
    //if the person just acheived the highscore, they instantly get half the pot
    //when this happens, 10% of the pot is split between the top 10 on the ranking board

    function checkScore(address playerAddress, uint64 playerScore) public returns(uint) {
        //checks if score is in the top 10, adds it to top 10 if so
        checkInTopTen(playerAddress, playerScore);
        //checks if score is the highest, if so disburse give 50% of pot
        checkHighScore(playerAddress, playerScore);
        //pay 1% of pot to each address in top 10
        //payDividendsToTopTen();
        return playerScore;



    }

    function getTopTen(uint index) public returns (uint64) {
        return topTen[index];
    }

    //only check the score of the address if it has been confirmed to pay to play the game
    function checkIfPaid() public{

    }

    function checkHighScore(address playerAddress, uint64 playerScore) public payable{
        if (playerScore > highScore) {
           //set old high score to new high score
            highScore = playerScore;
            //set address to pay winner
            highScoreAddress = playerAddress;
            //get current pot balance
            uint256 currentBalance = address(this).balance;
            payout = currentBalance/2;
            //send eth
            highScoreAddress.transfer(payout);
        }
    }

    function checkInTopTen(address playerAddress, uint64 playerScore) public {
        //create new struct with player's info
        player memory newPlayer = player(playerAddress, playerScore);
        //if top ten list isn't full yet, add player to top 10
        if (topTen.length < 10){
            topTen.push(playerScore);
            //sort scores
            sort_array(topTen);
            leaderboard.push(newPlayer);
        }
        if (topTen.length == 10) {
            topTen.push(playerScore);
            leaderboard.push(newPlayer);
            sort_array(topTen);
            delete topTen[topTen.length-1];
            delete leaderboard[leaderboard.length-1];
        }
    }

    function payDividendsToTopTen() public {
        uint256 currentBalance = address(this).balance;
        payout = currentBalance/100;
        for(uint i=0;i<10;i++){
            address recieverAddress = leaderboard[i].addr;
            recieverAddress.transfer(payout);
        }


    }


//quicksort function
    function sort_array(uint64[] arr_) public returns (uint64 [] ){
        uint256 l = arr_.length;
        uint64[] memory arr = new uint64[] (l);

        for(uint i=0;i<l;i++)
        {
            arr[i] = arr_[i];
        }

        for(i =0;i<l;i++)
        {
            for(uint j =i+1;j<l;j++)
            {
                if(arr[i]<arr[j])
                {
                    uint64 temp= arr[j];
                    arr[j]=arr[i];
                    arr[i] = temp;

                }

            }
        }

    return arr;
}


}
