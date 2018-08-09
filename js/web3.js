$(document).ready(function() {
  web3 = new Web3(new Web3.providers.HttpProvider("http://ropsten.infura.io/"));
  console.log(window.web3, web3); 
});