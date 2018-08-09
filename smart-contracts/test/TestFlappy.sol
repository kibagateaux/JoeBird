pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/flappy.sol";

contract TestFlappy {

    function testInitialBalanceWithNewFlappy() {
        Flappy flappy = new Flappy();

        uint expected = 10000;

        Assert.equal(flappy.checkScore(tx.origin, 10000), expected, "Owner should have 10000 MetaCoin initially");
  }
}