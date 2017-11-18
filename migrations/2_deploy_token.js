var SafeMath = artifacts.require("./SafeMath.sol");
var ERC20 = artifacts.require("./ERC20.sol");
var PeerNetworkToken = artifacts.require("./PeerNetworkToken.sol");

module.exports = function(deployer) {
  deployer.deploy(PeerNetworkToken);
};
