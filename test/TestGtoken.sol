pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Gtoken.sol";

contract TestGtoken {

  Gtoken gtoken;

  function testInitialBalanceUsingDeployedContract() public {
    gtoken = Gtoken(DeployedAddresses.Gtoken());
    uint expected = 1000;
    Assert.equal(gtoken.balanceOf(tx.origin), expected, "Owner should have 1000 Gtoken initially");
  }


  function testInitialBalanceWithNewGtoken() public {
    uint expected = 1000;
    Assert.equal(gtoken.balanceOf(tx.origin), expected, "Owner should have 1000 Gtoken initially");
  }

  function beforeAll() public {
    gtoken = new Gtoken();
  }

}
