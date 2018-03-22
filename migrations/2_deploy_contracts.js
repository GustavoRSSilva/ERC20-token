var Gtoken = artifacts.require("./Gtoken.sol");

module.exports = function(deployer) {
  deployer.deploy(Gtoken);
};
