/*
 * @Description: RealRainCoin合约的铸造和销毁功能
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-07 19:37:18
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-12 13:26:09
 * @FilePath: \foundry_project\01_erc-20\contracts\src\RealRainCoin.sol
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved.
 */
// SPDX-License-Identifier: MIT
// 许可证声明：指定合约的版权许可为 MIT，允许代码的自由使用和修改。

// 指定 Solidity 编译器的版本。
pragma solidity ^0.8.30;

// 从 OpenZeppelin 导入 ERC20 合约，提供标准的 ERC20 代币功能。
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 从 OpenZeppelin 导入 Ownable 合约，确保只有合约所有者可以执行特定操作。
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// 声明 RealRainCoin 合约，继承 ERC20 和 Ownable 两个功能模块。
contract RealRainCoin is ERC20, Ownable {
    // 声明 Mint 事件：在代币铸造时记录铸造的数量。
    event Mint(uint256 indexed amount);

    // 声明 Burn 事件：在代币销毁时记录销毁的数量。
    event Burn(uint256 indexed amount);

    // 代币名称，供外部调用查询。
    string public _name = "RealRainCoin";

    // 代币符号，供外部调用查询。
    string public _symbol = "RRC";

    // 构造函数：初始化合约时设置代币的名称、符号，以及指定初始所有者。
    constructor(
        address initialOwner
    ) ERC20("RealRainCoin", "RRC") Ownable(initialOwner) {}

    // mint 函数：仅允许合约所有者铸造代币。
    // 参数 _amount：铸造的代币数量。
    function mint(uint256 _amount) public onlyOwner {
        // 调用 OpenZeppelin 提供的 _mint 函数，将指定数量的代币铸造到调用者账户。
        _mint(msg.sender, _amount);

        // 触发 Mint 事件，记录铸造的数量。
        emit Mint(_amount);
    }

    // burn 函数：仅允许合约所有者销毁代币。
    // 参数 _amount：销毁的代币数量。
    function burn(uint256 _amount) public onlyOwner {
        // 调用 OpenZeppelin 提供的 _burn 函数，从调用者账户销毁指定数量的代币。
        _burn(msg.sender, _amount);

        // 触发 Burn 事件，记录销毁的数量。
        emit Burn(_amount);
    }
}
