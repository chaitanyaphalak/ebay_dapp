README

Instructions:
1. set up a truffle project

mkdir ebay_dapp
cd ebay_dapp
truffle unbox webpack
rm contracts/ConvertLib.sol contracts/MetaCoin.sol

2. Create EcommerceStore.sol smart contract

3. Testing
    start ganache,
        1. use GUI
        2. use ganache cli command

Make sure to make changes to migrations/2_deploy_contracts.js to point to your smart contract

4. Compile
    truffle compile

5. migrate to test blockchain(ganache), make sure the port number in truffle.js matches your test blockchain
    truffle migrate

6. After successfully migrating your smart contract, open the truffle console to interact with your deployed contract
    truffle console

7. To check out amounts in wei and ether use the following commands in the console
    web3.toWei(1, 'ether')
    web3.fromWei(1, 'ether')

    amt_1 = web3.toWei(1, 'ether');
    current_time = Math.round(new Date() / 1000);

8. Start truffle console and add a product to the blockchain.
   You can enter random string name for image and description links.
   EcommerceStore.deployed().then(function(contractInstance) {contractInstance.addProductToStore('Google Pixel', 'Phone',
   'junk_image_link', 'junk_desc_link', current_time, current_time + 200, amt_1, 0).then(function(out) {console.log(out)})} )

9. Retrieve the product you inserted by product id (Since this was the first product you added, the product id will be 1).

    EcommerceStore.deployed().then(function(contractInstance) {contractInstance.getProduct(1).then(function(v) {console.log(v)})})

    Eutil = require('ethereumjs-util');
    sealedBid = '0x' + Eutil.sha3((2 * amt_1) + 'mysecretacc1').toString('hex');
    EcommerceStore.deployed().then(function(contractInstance) {contractInstance.bid(1, sealedBid, {value: 3*amt_1, from: web3.eth.accounts[1]}).then(function(i) {console.log(i)})})

    sealedBid = '0x' + Eutil.sha3((3 * amt_1) + 'mysecretacc2').toString('hex');
    EcommerceStore.deployed().then(function(contractInstance) {contractInstance.bid(1, sealedBid, {value: 4*amt_1, from: web3.eth.accounts[2]}).then(function(i) {console.log(i)})})

    web3.eth.getBalance(web3.eth.accounts[1])
    web3.eth.getBalance(web3.eth.accounts[2])

    EcommerceStore.deployed().then(function(i) {i.revealBid(1, (2*amt_1).toString(), 'mysecretacc1', {from: web3.eth.accounts[1]}).then(function(f) {console.log(f)})})
    EcommerceStore.deployed().then(function(i) {i.revealBid(1, (3*amt_1).toString(), 'mysecretacc2', {from: web3.eth.accounts[2]}).then(function(f) {console.log(f)})})

    EcommerceStore.deployed().then(function(i) {i.highestBidderInfo.call(1).then(function(f) {console.log(f)})})
    EcommerceStore.deployed().then(function(i) {i.highestBidderInfo.call(1).then(function(f) {console.log(f)})})




amt_1 = web3.toWei(1, 'ether');
current_time = Math.round(new Date() / 1000);
EcommerceStore.deployed().then(function(i) {i.addProductToStore('iphone 6', 'Cell Phones & Accessories', 'imagelink', 'desclink', current_time, current_time + 200, amt_1, 0).then(function(f) {console.log(f)})});
EcommerceStore.deployed().then(function(i) {i.getProduct.call(1).then(function(f) {console.log(f)})})

Eutil = require('ethereumjs-util');
sealedBid = '0x' + Eutil.sha3((2 * amt_1) + 'mysecretacc1').toString('hex');
EcommerceStore.deployed().then(function(i) {i.bid(1, sealedBid, {value: 3*amt_1, from: web3.eth.accounts[1]}).then(function(f) {console.log(f)})});
sealedBid = '0x' + Eutil.sha3((3 * amt_1) + 'mysecretacc2').toString('hex');
EcommerceStore.deployed().then(function(i) {i.bid(1, sealedBid, {value: 4*amt_1, from: web3.eth.accounts[2]}).then(function(f) {console.log(f)})});

web3.eth.getBalance(web3.eth.accounts[1])
web3.eth.getBalance(web3.eth.accounts[2])

EcommerceStore.deployed().then(function(i) {i.revealBid(1, (2*amt_1).toString(), 'mysecretacc1', {from: web3.eth.accounts[1]}).then(function(f) {console.log(f)})})
EcommerceStore.deployed().then(function(i) {i.revealBid(1, (3*amt_1).toString(), 'mysecretacc2', {from: web3.eth.accounts[2]}).then(function(f) {console.log(f)})})
EcommerceStore.deployed().then(function(i) {i.highestBidderInfo.call(1).then(function(f) {console.log(f)})})

