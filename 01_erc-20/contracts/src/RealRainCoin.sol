/*
 * @Description: RealRainCoin合约的铸造和销毁功能
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-07 19:37:18
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-08 00:49:05
 * @FilePath: \contracts\src\RealRainCoin.sol
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved. 
 */
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract RealRainCoin is ERC20, Ownable {
    event Mint(uint256 indexed amount);
    event Burn(uint256 indexed amount);

    string public _name = "RealRainCoin";
    string public _symbol = "RRC";

    constructor(address initialOwner) ERC20("RealRainCoin", "RRC") Ownable(initialOwner) {}

    function mint(uint256 _amount) public onlyOwner {
        _mint(msg.sender, _amount);

        emit Mint(_amount);
    }

    function burn(uint256 _amount) public onlyOwner {
        _burn(msg.sender, _amount);

        emit Mint(_amount);
    }
}
