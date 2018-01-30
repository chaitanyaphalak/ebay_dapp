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

8. Start truffle console and add a product to the blockchain.
   You can enter random string name for image and description links.
   EcommerceStore.deployed().then(function(contractInstance) {contractInstance.addProductToStore().then()} )