<!--
 * @Description: readme
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-11 22:46:08
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-12 17:52:54
 * @FilePath: \foundry_project\README.md
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved. 
-->
<h1 align="center"> 智能合约开发DEMO <br></h1>
<p align="center"><strong>展示如何使用 Foundry 框架进行 Solidity 智能合约的开发；如何使用cast指令与智能合约交互；以及如何使用ethers库让前端与智能合约交互 <br>作者：realrain</br></strong>
</p>

<br>

> [!WARNING]
> 本教程中构建的所有代码未经过严格审核，仅用于学习交流目的，禁止在实际的生产环境中使用！！！

<br>
<br>

# RealRainCoin

![alt text](image.png)

## 参考文档
1. [Solidity 官方文档](https://docs.soliditylang.org/): 如果你有一定的编程基础，对一些 `Solidity` 基础变量的定义或语法的使用还不太了解，又不想花太多的时间去看视频教程，那么结合文档进行学习会是一个更不错的选择
2. [Foundry 官方文档](https://book.getfoundry.sh/): 这是使用 `Foundry` 框架进行 `Solidity` 智能合约开发必须要阅读的资料，同时当你真正开始构建生产级别应用时，可以在其中找到很多我并未在提及到的开发技巧和解决错误的方法
3. [OpenZeppelin官网](https://www.openzeppelin.com/): 内有 Solidity 中最全的标准库，官方文档中包含不同操作系统的安装方式，以及查看标准库中一些合约的源代码，同时主页有一个简易的合约定制工具，可以快速生成 ERC-20, ERC-721 等合约的模板
4. [以太坊官网](https://ethereum.org/zh/): 这是以太坊的官方网站，页面大都进行了中文翻译，对中文开发者非常友好，你可以在这里了解到以太坊生态相关的基础知识，路线图和资讯。如果你对以太坊白皮书感兴趣的话，在导航栏中你也能找到 Vitalik 在 2014 年撰写的白皮书

## 环境配置
1. [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)：Git 是一个免费的开源 分布式版本控制系统，旨在快速高效地处理从小型到大型的所有项目。
  - 安装成功后运行 `git --version`查看版本，截止 2025 年 7 月，使用的版本为 `2.50.0.windows.2`。

2. [Node.js](https://nodejs.org/zh-cn)：Node.js® 是一个免费、开源、跨平台的 JavaScript 运行时环境，可让开发人员创建服务器、Web 应用程序、命令行工具和脚本。
  - 安装成功后运行 `node -v` 查看版本，截止 2025 年 7 月，使用的版本为 `22.17.0`。
  - 运行 `npm -v`，查看 `npm` 包管理器的版本，截止 2025 年 7 月，使用的版本为 `10.9.2`。
  - 推荐使用`nvm`管理`node`版本，运行 `nvm -v`查看版本，截止 2025 年 7 月，使用的版本为 `1.2.2`。

## 合约项目的环境配置
1. 安装 `Rustup`: Foundry 运行必须的环境时
   - [rust](https://www.rust-lang.org/tools/install)
        - 安装成功后运行 `rustc --version`查看版本 ，截止 2025 年 7 月，使用的版本为 `rustc 1.88.0 (6b00bc388 2025-06-23)`

<!-- 2. 安装 `HomeBrew`, 很好用的包管理工具
   - [homebrew](https://brew.sh/)
        - 安装成功后可以运行 `brew --version` ，如果安装成功则显示 `Homebrew x.x.x`，截止 2025 年 7 月，使用的版本为 `Homebrew 4.4.14` -->

2. 安装并配置 `Foundry`
    - [foundry](https://getfoundry.sh/)
        - 安装成功后运行 `forge --version`查看版本 ，如果安装成功则显示 `forge x.x.x`，截止 2025 年 7 月，使用的版本为 `forge Version: 1.2.3-stable Commit SHA: a813a2cee7dd4926e7c56fd8a785b54f32e0d10f`

## 前端项目的环境配置
1. 安装[Next.js](https://nextjs.org/): Next.js 是一个用于构建全栈 Web 应用程序的 React 框架。您可以使用 React 组件构建用户界面，并使用 Next.js 实现附加功能和优化。截止 2025 年 7 月，使用的版本为 `15.3.5`。
  - 在终端运行`npx create-next-app@latest` 初始化一个 Nextjs 项目，并根据自己的需求选择所需要的附加插件
  
2. 安装[tailwindcss](https://tailwindcss.com/docs/installation)，CSS框架，一般初始化Next项目时会提供选择。截止 2025 年 7 月，使用的版本为 `^4`。
  - 在终端运行`npm install -D tailwindcss npx tailwindcss init`,然后根据官网文档进行配置

3. 安装[Ethers](https://docs.ethers.org/v6/): ethers.js 库旨在成为一个与以太坊区块链及其生态系统交互的完整而紧凑的库。截止 2025 年 7 月，使用的版本为 `^6.15.0`。

## 常用 Foundry 指令

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

***更多详细的交互操作见doc目录文档***
<br><br>
<p align="center">
<strong>
作者： realrain<br>
联系方式: 1936648485@qq.com<br>
Blog：<a href="https://reallyrain.com">真雨の小破站<a/><br>
</strong>
</p>