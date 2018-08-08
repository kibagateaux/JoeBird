var SimpleStore = artifacts.require("./SimpleStore.sol");

console.log('art', artifacts);

module.exports = function(deployer) {
  deployer.deploy(SimpleStore);
};