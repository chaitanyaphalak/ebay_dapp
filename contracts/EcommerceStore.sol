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
}
