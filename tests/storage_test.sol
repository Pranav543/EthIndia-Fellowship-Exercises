// SPDX-License-Identifier: GPL-3.0
    
pragma solidity >=0.4.22 <0.8.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "remix_accounts.sol";
import "../contracts/1_Storage.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    // Contract instance created.    
    Storage state;
    
    // Random number for testing purposes.
    uint256 testNumber = 3301;

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    
    function beforeAll() public {
        state = new Storage();
    }
    
    function isStoredCorrect() public {
        state.store(testNumber);
        Assert.equal(state.retrieve(), testNumber, "Hey, Number is stored Incorrectly!");
    }  

    /// Custom Transaction Context
    /// See more: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    /// #sender: account-1
    /// #value: 100
    function checkSenderAndValue() public payable {
        // account index varies 0-9, value is in wei
        Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
        Assert.equal(msg.value, 100, "Invalid value");
    }
}