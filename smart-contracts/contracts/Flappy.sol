pragma solidity ^0.4.2;
pragma experimental ABIEncoderV2;

contract Flappy {

  // =====================================================================
  // VARIABLES
  // =====================================================================
    uint256 private highScore = 0;
    address private highScoreAddress;
    uint256 private payout;
    uint256[] public topTen;
    uint[] leaderboardScores;
    address[] leaderboardAddresses;
    uint playPrice = 1;
    uint public price;
    mapping (address => uint) balance;
    address[] alreadyPayed;

    address owner;
    bytes32 name;

    // =====================================================================
    // CONSTRUCTOR
    // =====================================================================

    /**
    @param _name Bytes32 address of owner
    */
    constructor (bytes32 _name) payable public {
        owner = msg.sender;
        name = _name;
    }

    struct player{
        address addr;
        uint score;
    }

    player[] leaderboard;

    // =====================================================================
    // FLAPPY
    // =====================================================================

    /**
    @notice when someone plays, they send eth to the smart contract that is added to the pot
    when they are finished playing, their score and address get sent to this contract
    their score and address is added to the ranking list, and removed if not in top 10
    if the person just acheived the highscore, they instantly get half the pot
    when this happens, 10% of the pot is split between the top 10 on the ranking board
    */


    function AcceptEth() {
        // set owner as the address of the one who created the contract
        owner = msg.sender;
        // set the price to 1 ether
        price = 1 ether;
    }

    function sendPayment(uint256 deposit) payable {
        // Error out if anything other than 2 ether is sent
        require(msg.value == price);

        // Track that calling account deposited ether
        balance[msg.sender] += msg.value;
        alreadyPayed.push(msg.sender);
        payDividendsToTopTen();
        
    }
    
    function checkAlreadyPayed(address playerAddress) public returns(bool){
        for(uint i=0;i<alreadyPayed.length;i++){
            if (playerAddress == alreadyPayed[i]){
                bool result = true;
                
            }
        }
        return result;
            
    }
    
    function getBalance() public returns(uint){
        uint256 currentBalance = address(this).balance;
        return currentBalance;
    }
        
    

    function addNewScore(address playerAddress, uint256 playerScore) public returns(uint[]) {
        if (checkAlreadyPayed(playerAddress) == true){
            //checks if score is in the top 10, adds it to top 10 if so
            checkInTopTen(playerAddress, playerScore);
            //checks if score is the highest, if so disburse give 50% of pot
            checkHighScore(playerAddress, playerScore);
            //pay 1% of pot to each address in top 10
            //
            return topTen;
        }

    }

    

    //only check the score of the address if it has been confirmed to pay to play the game
    /* function checkIfPaid() public{
    } */

    function checkHighScore(address playerAddress, uint256 playerScore) public returns (uint[]){
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
            return topTen;
        }
        
    }

    function checkInTopTen(address playerAddress, uint256 playerScore) public {
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
            delete topTen[10];
            delete leaderboard[10];
        }
    }

    function payDividendsToTopTen() public {
        uint256 currentBalance = this.balance;
        payout = price/100;
        if(topTen.length > 0){
            for(uint i=0;i<topTen.length;i++){
                address recieverAddress = leaderboard[i].addr;
                recieverAddress.transfer(payout);
            }
        }

    }
    
    function payAddress(address payee) public payable {
        uint256 currentBalance = this.balance;
        payout = currentBalance;
        payee.transfer(payout);
    }
    
    function getLeaderboard() external returns (address[], uint[]) {

        for(uint i=0;i<topTen.length;i++){
            leaderboardAddresses.push(leaderboard[i].addr);
            leaderboardScores.push(leaderboard[i].score);
        } 
        return (leaderboardAddresses, leaderboardScores);
    }


//quicksort function
    function sort_array(uint256[] arr_) public returns (uint256 [] ){
        uint256 l = arr_.length;
        uint256[] memory arr = new uint256[] (l);

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
                    uint256 temp= arr[j];
                    arr[j]=arr[i];
                    arr[i] = temp;

                }

            }
        }

    return arr;
}

  // =====================================================================
  // FALLBACK
  // =====================================================================

  function() public payable {}

}
