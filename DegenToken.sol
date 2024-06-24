// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DegenToken is ERC20, Ownable {

    
    struct Product {
        string productName;
        uint productPrice;
    }

    Product[] private availableProducts;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        availableProducts.push(Product("Goggles", 100));
        availableProducts.push(Product("Classic Watch", 200));
        availableProducts.push(Product("Locket", 300));
        availableProducts.push(Product("Digital Camera", 400));
    }

    function mintTokens(address recipient, uint256 tokenAmount) public onlyOwner {
        _mint(recipient, tokenAmount);
    }

    function transferDegenTokens(address recipient, uint256 tokenAmount) external {
        require(balanceOf(msg.sender) >= tokenAmount, "Not enough balance");
        transfer(recipient, tokenAmount);
    }

    function redeemProduct(uint8 productIndex) external returns (string memory) {
        require(productIndex > 0 && productIndex <= availableProducts.length, "Invalid product index");
        Product memory selectedProduct = availableProducts[productIndex - 1];
        require(balanceOf(msg.sender) >= selectedProduct.productPrice, "Not enough balance");
        transfer(owner(), selectedProduct.productPrice);
        return string(abi.encodePacked("Redeemed: ", selectedProduct.productName));
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burnUserTokens(uint256 tokenAmount) external {
        _burn(msg.sender, tokenAmount);
    }

    function listProducts() external view returns (string memory) {
        string memory productList = "Available Products:";
        for (uint i = 0; i < availableProducts.length; i++) {
            productList = string.concat(productList, "\n", Strings.toString(i + 1), ". ", availableProducts[i].productName);
    }
    return productList;
}
}
