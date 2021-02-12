// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
contract DeadManSwitch {
  
  address public testator;
  uint256 public last_alive_block = 0;
  uint256 public current_block = 0;
  address payable beneficiary;
  
  event assetsTransferred(address Sender, uint256 Amount);
  
  modifier isTestator {
    require(msg.sender == testator, "You Are Not The Testator!");
    _;
  }

  constructor(address payable _beneficiary) {
    testator = msg.sender;
    beneficiary = _beneficiary;
  }

  function stillAlive() external isTestator {
    last_alive_block = block.number;
  }
  
  function checkIfStillAlive() public returns (bool) {
    if (
      block.number >= last_alive_block &&
      block.number - last_alive_block > 10
    ) {
      transferAssets();
      return false;
    }
    return true;
  }

  function transferAssets() internal {
    selfdestruct(beneficiary);
  }
  
  receive() external payable isTestator {
        emit assetsTransferred(msg.sender, msg.value);
    }
}