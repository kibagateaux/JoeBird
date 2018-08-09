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
    string[] leaderboardNames;
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
        string name;
        address addr;
        uint256 score;
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
    
        
    

    function addNewScore(address playerAddress, uint256 playerScore, string name) public returns(uint[]) {
        if (checkAlreadyPayed(playerAddress) == true){
            //checks if score is in the top 10, adds it to top 10 if so
            player memory newPlayer;
            newPlayer.addr = playerAddress;
            newPlayer.score = playerScore;
            newPlayer.name = name;
            leaderboard.push(newPlayer);
            checkHighScore(playerAddress, playerScore);
        }

    }

    


    
    function getLeaderboard() external returns (address[], uint256[], string[]) {
       // leaderboard = sort_leaderboard(leaderboard);
        for(uint i=0;i<leaderboard.length;i++){
            leaderboardAddresses.push(leaderboard[i].addr);
            leaderboardScores.push(leaderboard[i].score);
            leaderboardNames.push(leaderboard[i].name);
        } 

        return (leaderboardAddresses, leaderboardScores, leaderboardNames);
    }
    
    function payDividendsToTopTen() public {
        uint256 currentBalance = this.balance;
        payout = price/100;
        if(topTen.length > 0){
            for(uint i=0;i<leaderboard.length;i++){
                address recieverAddress = leaderboard[i].addr;
                recieverAddress.transfer(payout);
            }
        }

    }
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


  // =====================================================================
  // FALLBACK
  // =====================================================================

  function() public payable {}

}
