/*
 * @Description: 测试RealRainCoin合约的铸造和销毁功能
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-07 22:46:30
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-08 00:09:47
 * @FilePath: \contracts\test\RealRainCoinTest.sol
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved. 
 */
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import {RealRainCoin} from "../src/RealRainCoin.sol";

contract RealRainCoinTest is Test {
    RealRainCoin public rrc;

    address owner = vm.addr(1);
    address user = vm.addr(2);

    function setUp() public {
        rrc = new RealRainCoin(owner);
        vm.deal(owner, 10 ether); // Give owner some ether for testing
    }

    // 所有者铸造1000个代币成功
    // Test that the owner can mint tokens successfully
    function testSuccessIfOwnerMint() public {
        vm.startPrank(owner);
        uint256 mintAmount = 1000 * 10 ** 18; // 1000 tokens with 18 decimals
        rrc.mint(mintAmount);
        assertEq(rrc.balanceOf(owner), mintAmount, "Owner should have minted tokens");
    }

    // 用户尝试铸造1000个代币失败
    // Test that a user cannot mint tokens
    function testRevertIfUserMint() public {
        vm.startPrank(user);
        uint256 mintAmount = 1000 * 10 ** 18; // 1000 tokens with 18 decimals
        vm.expectRevert();
        rrc.mint(mintAmount);
        vm.stopPrank();

        assertEq(rrc.balanceOf(user), 0 ether);
    }

    //铸造10个代币，所有者销毁3个代币成功
    // Owner mints 10 tokens, then burns 3 tokens
    function testSuccessIfOwnerBurn() public {
        vm.startPrank(owner);
        rrc.mint(10 ether);
        vm.stopPrank();
        assertEq(rrc.balanceOf(owner), 10 ether);

        vm.startPrank(owner);
        rrc.burn(3 ether);
        vm.stopPrank();
        assertEq(rrc.balanceOf(owner), 7 ether);
    }

    // 铸造10个代币，用户尝试销毁5个代币失败
    // User tries to burn 5 tokens after owner mints 10 tokens, but fails
    function testRevertIfUserBurn() public {
        vm.startPrank(owner);
        rrc.mint(10 ether);
        vm.stopPrank();
        assertEq(rrc.balanceOf(owner), 10 ether);

        vm.startPrank(user);
        vm.expectRevert();
        rrc.burn(5 ether);
        vm.stopPrank();

        assertEq(rrc.balanceOf(owner), 10 ether);
        assertEq(rrc.balanceOf(user), 0 ether);
    }
}
