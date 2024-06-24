# DegenToken

The "DegenToken" contract is a Solidity smart contract implementing a ERC20 token . It allows for token minting, redeeming, burning, transferring, and approval functionalities. The contract includes ownership control, decimal precision management.

## Description

This project is a Solidity smart contract named "DegenToken" that implements a ERC20 token . It includes functions for minting new tokens ("mintTokens"), burning existing tokens ("burnUserTokens"), transferring tokens ("transferDegenTokens"), and redeeming products ("redeemProduct"). The contract also provides a function to check token balances ("getBalance") and lists available products ("listProducts") that users can redeem using their token balances. Additionally, it features ownership control, manages decimal precision.

The contract is already deployed to Avalanche Fuji Testnet. The address of the contract is 0x0F1E76a4Ba31fd626Dbe9A9F135450Ded3214327.
The Contract is verified at https://testnet.snowtrace.io/address/0x0F1E76a4Ba31fd626Dbe9A9F135450Ded3214327

## Getting Started

### Steps to Deploy and Test a Smart Contract on Fuji Testnet

1. **Claim AVAX from Fuji Faucet on Chainlink:**
   - Go to [Chainlink Fuji Faucet](https://faucets.chain.link/avax).
   - Claim 0.25 AVAX by following the instructions provided.

2. **Switch Metamask to Fuji Testnet:**
   - Open Metamask and switch the network to "Fuji Testnet".

3. **Deploy Smart Contract Using Remix IDE:**
   - Open [Remix IDE](https://remix.ethereum.org/) in your browser.
   - Connect Remix to Metamask (ensure it's set to inject the Metamask provider).
   - Paste below smart contract code into Remix.
```javascript
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

    constructor() ERC20("DegenCoin", "DGC") Ownable(msg.sender) {
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

```
   - Compile and deploy  smart contract on the Fuji Testnet.
   - Interact with your smart contract functions through Remix IDE.
   - Verify the code execution and transaction details in Remix IDE.
     
4. **Check Contract History on SnowTrace:**
   - Go to [SnowTrace](https://snowtrace.io/).
   - Click on the network selector at the top right and switch to "Fuji Testnet".
   - Enter your contract address in the search bar to view its transaction history.


## Authors

Amandeep Sharma

inspireamandeep1@gmail.com

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
