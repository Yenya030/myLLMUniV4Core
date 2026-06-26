// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "forge-std/Test.sol";

contract SafetyCheckTest is Test {
    function testBalanceDeltaAdditionOverflow() public {
        // Test addition overflow case
        int128 a = type(int128).max;
        int128 b = 1;
        BalanceDelta result = toBalanceDelta(a, 0) + toBalanceDelta(0, b);
        // This should hit SafeCast.toInt128() in add()
        vm.expectRevert();
        assertEq(result.amount0(), type(int128).max);
        assertEq(result.amount1(), 1);
    }

    function testBalanceDeltaSubtractionUnderflow() public {
        // Test MAX negative case
        int128 a = type(int128).min;
        int128 b = -1;
        BalanceDelta result = toBalanceDelta(a, 0) - toBalanceDelta(0, b);
        // Should revert via SafeCast.toInt128()
        vm.expectRevert();
        assertEq(result.amount0(), type(int128).min);
        assertEq(result.amount1(), -1);
    }

    function testModifyLiquidityExploit() public {
        // Test interaction with UniversalRouter's modifyLiquidity
        uint24 spacing = 100; // Use minimal spacing to maximize delta impact
        uint256 liquidityDelta = 1SolidityUnit * 2**126;
        modifier mockOptions {
            uint24 newSpacing = spacing;
        }
        // Cast liquidityDelta to int128 in modifyLiquidity params
        PoolManager(self).modifyLiquidity(modifier(mockOptions), new ModifyLiquidityParams({
            liquidityDelta: liquidityDelta
        }), ZERO_BYTES);
        // This should trigger SafeCast overflow in PoolManager.modifyLiquidity
        vm.expectRevert();
    }
}