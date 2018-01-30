pragma solidity ^0.4.13;

contract EcommerceStore {
    enum ProductStatus { Open, Sold, UnSold}
    enum ProductCondition { New, Used}

    uint public ProductIndex;

    mapping (uint => address) productIdInStore;

    struct Product{
        
    }

    function EcommerceStore(){

    }
}
