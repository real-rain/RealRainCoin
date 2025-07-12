/*
 * @Description: 测试RealRainCoin合约的铸造和销毁功能
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-07 22:46:30
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-12 12:26:57
 * @FilePath: \foundry_project\01_erc-20\contracts\test\RealRainCoinTest.sol
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved.
 */
// SPDX-License-Identifier: MIT
// 许可证声明：指定合约的版权许可为 MIT，允许代码的自由使用和修改。

// 指定 Solidity 编译器的版本。
pragma solidity ^0.8.30;

// 从 OpenZeppelin 导入 ERC20 合约，提供标准的 ERC20 代币功能。
import "forge-std/Test.sol";

// 导入要测试的主合约 RealRainCoin
import {RealRainCoin} from "../src/RealRainCoin.sol";

// 声明 RealRainCoinTest 测试合约，继承 Foundry 的 Test 基类。
contract RealRainCoinTest is Test {
    // 定义 RealRainCoin 类型的公共变量 `rrc`，用于保存被测试的合约实例。
    RealRainCoin public rrc;

    // 使用 Foundry 提供的虚拟地址生成器生成一个模拟的所有者地址。
    address owner = vm.addr(1);

    // 使用 Foundry 提供的虚拟地址生成器生成一个模拟的用户地址。
    address user = vm.addr(2);

    // setUp 函数：在每个测试用例运行之前调用，用于初始化测试环境。
    function setUp() public {
        // 部署 RealRainCoin 合约实例，并将 `owner` 设置为合约所有者。
        rrc = new RealRainCoin(owner);

        // 为 `owner` 地址分配 10 ETH，用于支付交易费用或操作测试逻辑。
        vm.deal(owner, 10 ether); // Give owner some ether for testing
    }

    // 测试用例：所有者铸造1000个代币成功
    function testSuccessIfOwnerMint() public {
        // 开始模拟 `owner` 地址的交易行为。
        vm.startPrank(owner);

        // 定义要铸造的代币数量为 1000 个，考虑到 ERC20 代币通常有 18 位小数。
        // 这里使用 10 ** 18 来表示 1 个代币的最小单位。
        // 例如，1000 个代币等于 1000 * 10 ** 18。
        uint256 mintAmount = 1000 * 10 ** 18; // 1000 tokens with 18 decimals

        // 调用 `mint` 函数铸造代币。
        rrc.mint(mintAmount);

        vm.stopPrank();
        // 停止模拟交易行为。

        // 验证 `owner` 地址的代币余额是否为 1000 个代币。
        // 使用 `assertEq` 函数检查实际余额与预期余额是否相等。
        // 如果不相等，测试将失败，并显示错误信息 "Owner should have minted tokens"。
        // assertEq 函数是 Foundry 提供的断言函数，用于验证测试结果。
        assertEq(
            rrc.balanceOf(owner),
            mintAmount,
            "Owner should have minted tokens"
        );
    }

    // 测试用例：用户尝试铸造1000个代币失败
    function testRevertIfUserMint() public {
        vm.startPrank(user);
        uint256 mintAmount = 1000 * 10 ** 18;

        // 期待 revert 操作，因为 `user` 不是合约所有者。
        vm.expectRevert();

        rrc.mint(mintAmount);
        vm.stopPrank();
        
        // 验证 `user` 地址的代币余额仍为 0，因为铸造操作失败。
        assertEq(rrc.balanceOf(user), 0 ether);
    }

    //  测试用例：铸造10个代币，所有者销毁3个代币成功
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

    // 测试用例：铸造10个代币，用户尝试销毁5个代币失败
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
