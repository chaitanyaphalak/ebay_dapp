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
    }

    function EcommerceStore() public{
        productIndex = 0;
    }

    function addProductToStore(uint id, string name, string category, string imageLink, string descLink,
        uint auctionStartTime, uint auctionEndTime, uint startPrice, uint condition) public{
        require(auctionStartTime < auctionEndTime);
        productIndex += 1;
        Product memory product = Product(id, name, category, imageLink, descLink, auctionStartTime, auctionEndTime,
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
}
