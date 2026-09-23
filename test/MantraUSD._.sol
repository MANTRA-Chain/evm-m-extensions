// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import { Test } from "forge-std/Test.sol";
import { MantraUSD } from "../src/MantraUSD.sol";
import { BaseUnitTest } from "./utils/BaseUnitTest.sol";

contract MantraUSDTest is BaseUnitTest {
    string public constant NAME = "MANTRA USD";
    string public constant SYMBOL = "mantraUSD";

    MantraUSD mantraUSD;
    // address admin = makeAddr("admin");
    address treasury = makeAddr("treasury");
    address user = makeAddr("user");

    function setUp() public override {
        super.setUp();
        mantraUSD = new MantraUSD(
            address(mToken), // M Token address
            address(swapFacility) // SwapFacility address
        );

        mantraUSD.initialize(
            NAME,
            SYMBOL,
            treasury, // Yield recipient
            admin, // Admin
            admin, // Freeze manager
            admin // Yield recipient manager
        );
    }

    function test_initialize() external view {
        assertEq(mantraUSD.name(), NAME);
        assertEq(mantraUSD.symbol(), SYMBOL);
        assertEq(mantraUSD.decimals(), 6);
        assertEq(mantraUSD.mToken(), address(mToken));
        assertEq(mantraUSD.swapFacility(), address(swapFacility));
    }

    function testYieldClaim() public {
        // Test yield claiming functionality
        // Mock some yield accrual
        // Call claimYield()
        // Assert yield goes to treasury
    }

    function testFreezing() public {
        // Test freezing functionality
        vm.prank(admin);
        mantraUSD.freeze(user);
        assertTrue(mantraUSD.isFrozen(user));
    }

    function testYieldRecipientChange() public {
        // Test changing yield recipient
        address newTreasury = makeAddr("newTreasury");
        vm.prank(admin);
        mantraUSD.setYieldRecipient(newTreasury);
        assertEq(mantraUSD.yieldRecipient(), newTreasury);
    }
}
