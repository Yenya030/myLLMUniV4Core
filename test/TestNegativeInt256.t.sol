// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "../src/PoolManager.sol";
import "@uniswap/v4-core/test/ERC20.t.sol";
import "forge-std/Test.sol";

contract TestNegativeInt256 is Test {
    PoolManager public poolManager;
    ERC20 public token0;
    ERC20 public token1;

    function setUp() public {
        token0 = new ERC20("TOKEN0", "TKN0", 18);
        token1 = new ERC20("TOKEN1", "TKN1", 18);
        
        poolManager = new PoolManager(address(token0), address(token1));
        
        // Initialize a pool with valid parameters
        uint256 liquidity = 1e18;
        uint160 sqrtPriceX96 = 2**180;
        uint24 fee = 3000;
        uint24 tickSpacing = 64;
        address[] memory hooks = new address[](0);
        
        poolManager.initialize(
            new PoolKey(token0.address, token1.address, fee, tickSpacing, hooks),
            sqrtPriceX96
        );
    }

    function testModifyLiquidityWithInvalidDelta() public {
        uint256 invalidDelta = type(uint256).max; // This is > 2^127-1, should cause SafeCast overflow

        vm.expectRevert(bytes4(keccak256("SafeCastOverflow()")));
        poolManager.modifyLiquidity(
            new ModifyLiquidityParams({
                liquidityDelta: int128(invalidDelta) // This cast itself might revert, but we test via modifyLiquidity
            }),
            new bytes(0)
        );
    }

    function testModifyLiquidityWithOutOfBoundsDelta() public {
        // This value is 2^127 which cannot be represented in int128 (max positive is 2^127-1)
        uint256 largeDelta = 1 << 127;
        
        // This should trigger SafeCast.toInt128(uint256 x) revert in the modifyLiquidity path
        vm.expectRevert(bytes4(keccak256("SafeCastOverflow()")));
        poolManager.modifyLiquidity(
            new ModifyLiquidityParams({
                liquidityDelta: int128(largeDelta) // This conversion will overflow in Solidity before reaching the function?
            }),
            new bytes(0)
        );
    }

    function testDirectSafeCastRevert() public {
        // Direct test of SafeCast behavior
        uint256 tooBig = 1 << 127;
        vm.expectRevert(bytes4(keccak256("SafeCastOverflow()"));
        SafeCast.toInt128(tooBig);
        
        int256 negativeTooSmall = - (1 << 127) - 1; // Less than -2^127
        vm.expectRevert(bytes4(keccak256("SafeCastOverflow()"));
        SafeCast.toInt128(negativeTooSmall);
    }
}