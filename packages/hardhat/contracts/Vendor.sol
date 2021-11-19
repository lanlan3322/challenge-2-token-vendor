pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    YourToken yourToken;

    uint256 public constant tokensPerEth = 100;

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    constructor(address _owner) public {
        yourToken = YourToken(_owner);
    }

    //ToDo: create a payable buyTokens() function:
    function buyTokens() public payable {
        uint256 amountOfTokens = msg.value * tokensPerEth;
        uint256 balance = yourToken.balanceOf(address(this));

        require(balance >= amountOfTokens, "Insufficient token balance");
        yourToken.transfer(msg.sender, amountOfTokens);

        emit BuyTokens(msg.sender, msg.value, amountOfTokens);
    }

    //ToDo: create a sellTokens() function:
    function sellTokens(uint256 amountOfTokens) public {
        // Check sender has enough tokens
        uint256 userTokenBalance = yourToken.balanceOf(msg.sender);
        require(
            userTokenBalance >= amountOfTokens,
            "Insufficient token balance"
        );

        uint256 ethToSwap = amountOfTokens / tokensPerEth;
        uint256 contractEthBalance = address(this).balance;

        // Check vendor contract has enough eth to swap
        require(contractEthBalance >= ethToSwap, "Insufficient ETH balance");

        // Receive tokens
        yourToken.transferFrom(msg.sender, address(this), amountOfTokens);

        // Send eth
        msg.sender.transfer(ethToSwap);
    }

    //ToDo: create a withdraw() function that lets the owner, you can
    //use the Ownable.sol import above:
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        msg.sender.transfer(balance);
    }
}
