pragma solidity ^0.4.13;

contract EcommerceStore {
    enum ProductStatus { Open, Sold, UnSold}
    enum ProductCondition { New, Used}

    uint public productIndex;

    mapping (address => mapping(uint => Product)) stores;
    mapping (uint => address) productIdInStore;

    struct Product {
        uint id;
        string name;
        string category;
        string imageLink;
        string descLink;
        uint auctionStartTime;
        uint auctionEndTime;
        uint startPrice;
        address highestBidder;
        uint highestBid;
        uint secondHighestBid;
        uint totalBids;
        ProductStatus status;
        ProductCondition condition;
        mapping (address => mapping(bytes32 => Bid)) bids;
    }

    struct Bid {
        address bidder;
        uint productId;
        uint value;
        bool revealed;
    }

    function EcommerceStore() public{
        productIndex = 0;
    }

    function addProductToStore(string name, string category, string imageLink, string descLink,
        uint auctionStartTime, uint auctionEndTime, uint startPrice, uint condition) public{
        require(auctionStartTime < auctionEndTime);
        productIndex += 1;
        Product memory product = Product(productIndex, name, category, imageLink, descLink, auctionStartTime, auctionEndTime,
                                 startPrice, 0, 0, 0, 0, ProductStatus.Open, ProductCondition(condition));
        stores[msg.sender][productIndex] = product;
        productIdInStore[productIndex] = msg.sender;
    }

    function getProduct(uint productId) view public returns (uint, string, string, string, string, uint, uint, uint,
        ProductStatus, ProductCondition) {
        Product memory product = stores[productIdInStore[productId]][productId];
        return (product.id, product.name, product.category, product.imageLink, product.descLink,
                product.auctionStartTime, product.auctionEndTime, product.startPrice, product.status,
                product.condition);
    }

    function bid(uint productId, bytes32 bid) payable public returns (bool) {
        Product storage product = stores[productIdInStore[productId]][productId];
        require (now >= product.auctionStartTime);
        require (now <= product.auctionEndTime);
        require (msg.value > product.startPrice);
        require (product.bids[msg.sender][bid].bidder == 0);
        product.bids[msg.sender][bid] = Bid(msg.sender, productId, msg.value, false);
        product.totalBids += 1;
        return true;
    }

    function revealBid(uint productId, string _amount, string secretKey) public {
        Product storage product = stores[productIdInStore[productId]][productId];
        require (now > product.auctionEndTime);
        bytes32 sealedBid = keccak256(_amount, secretKey);

        Bid memory bidInfo = product.bids[msg.sender][sealedBid];
        require(bidInfo.bidder > 0);
        require(bidInfo.revealed == false);

        uint refund;
        uint amount = stringToUint(_amount);
        if (bidInfo.value < amount){
            refund = bidInfo.value;
        }
        else {
            if (address(product.highestBidder) == 0){
                product.highestBidder = msg.sender;
                product.highestBid = amount;
                product.secondHighestBid = product.startPrice;
                refund = bidInfo.value - amount;
            }
            else if (amount > product.highestBid) {
                product.secondHighestBid = product.highestBid;
                // send ether to address
                product.highestBidder.transfer(product.highestBid);
                product.highestBidder = msg.sender;
                product.highestBid = amount;
                refund = bidInfo.value - amount;
            }
            else if (amount > product.secondHighestBid){
                product.secondHighestBid = amount;
                refund = amount;
            }
            else {
                refund = amount;
            }
        }
        if (refund > 0){
            msg.sender.transfer(refund);
            product.bids[msg.sender][sealedBid].revealed = true;
        }
    }

    function highestBidderInfo(uint _productId) view public returns (address, uint, uint) {
        Product memory product = stores[productIdInStore[_productId]][_productId];
        return (product.highestBidder, product.highestBid, product.secondHighestBid);
    }

    function totalBids(uint _productId) view public returns (uint) {
        Product memory product = stores[productIdInStore[_productId]][_productId];
        return product.totalBids;
    }

    function stringToUint(string s) pure private returns (uint) {
        bytes memory b = bytes(s);
        uint result = 0;
        for (uint i = 0; i < b.length; i++) {
            if (b[i] >= 48 && b[i] <= 57) {
                result = result * 10 + (uint(b[i]) - 48);
            }
        }
        return result;
    }
}
