pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YourToken is ERC20 {
    //ToDo: add constructor and mint tokens for deployer,
    //you can use the above import for ERC20.sol. Read the docs ^^^
    constructor() public ERC20("Challenge2", "CH2") {
        _mint(msg.sender, 10000 * 10**18);
    }
}
