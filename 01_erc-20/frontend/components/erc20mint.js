/*
 * @Description: 交互组件
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-10 23:23:01
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-12 14:12:52
 * @FilePath: \foundry_project\01_erc-20\frontend\components\erc20mint.js
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved. 
 */
// 从 ethers.js 库中导入 ethers，用于与区块链交互
import { ethers } from "ethers";
// 从 React 导入 useState 和 useEffect，用于管理组件的状态和副作用
import { useState, useEffect } from "react";
// 导入 RealRainCoin 智能合约的 ABI 文件，用于与合约进行交互
import RealRainCoin from "../RealRainCoin.json";

// 导出默认组件 MintERC20，用于实现 ERC20 代币的铸造功能
export default function MintERC20({ accounts }) {
  // 定义智能合约的部署地址
  const ContractAddress = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";

  // 使用 useState 钩子定义 balance（用户余额）和 mintAmount（用户希望铸造的代币数量）的状态
  const [balance, setBalance] = useState(null); // 初始余额为空
  const [mintAmount, setMintAmount] = useState('1'); // 默认铸造数量为 1
  // 判断是否连接了钱包，连接状态取决于 accounts 的第一个元素是否存在
  const isConnected = Boolean(accounts[0]);

  // 定义 handleMint 函数，用于铸造代币
  async function handleMint() {
    if (window.ethereum) {
      // 创建以太坊提供者和签名者实例
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      // 初始化智能合约实例
      const contract = new ethers.Contract(
        ContractAddress,
        RealRainCoin.abi,
        signer
      );

      try {
        // 将用户输入的铸造数量转换为以太坊单位（最小单位 Wei）
        const mintAmountInETH = ethers.parseEther(mintAmount); // BigInt: 12 ETH => 12000000000000000000n
        console.log("type:", `${typeof mintAmountInETH} ======> ${mintAmountInETH}`); // "bigint"
        // 调用智能合约的 mint 方法，并传入铸造数量
        const response = await contract.mint(mintAmountInETH);
        console.log("Minting response: ", response);

        // 监听合约的 Mint 事件，铸造完成后刷新余额
        contract.on("Mint", async () => {
          fetchBalance();
        });
      } catch (e) {
        // 捕获并打印铸造失败的错误信息
        console.log(e);
      }
    }
  }

  // 定义 fetchBalance 函数，用于获取用户的代币余额
  async function fetchBalance() {
    if (window.ethereum) {
      // 创建以太坊提供者和签名者实例
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      // 初始化智能合约实例
      const contract = new ethers.Contract(
        ContractAddress,
        RealRainCoin.abi,
        signer
      );

      try {
        // 调用智能合约的 balanceOf 方法获取用户余额
        // const userBalance = await contract.balanceOf(accounts[0]);
        const userBalance = await contract.balanceOf(accounts[0]); // 获取用户的代币余额
        // 格式化余额，将其转换为可读的浮点数
        const formattedBalance = ethers.formatEther(userBalance); // 转换为 ETH
        // const formattedBalance = parseFloat(
        //   ethers.utils.formatUnits(userBalance, 18)
        // ).toFixed(2);

        // 更新余额状态
        setBalance(formattedBalance);
      } catch (e) {
        // 捕获并打印获取余额失败的错误信息
        console.log(e);
      }
    }
  }

  // 使用 useEffect 钩子，在组件挂载和账户连接变化时调用 fetchBalance，并设置定时器定期刷新余额
  useEffect(() => {
    if (isConnected) {
      fetchBalance(); // 初次加载时获取余额
      const intervalId = setInterval(fetchBalance, 1000); // 每秒刷新余额
      return () => clearInterval(intervalId); // 清理定时器
    }
  }, [accounts, isConnected]);

  // 渲染组件内容
  return (
    <>
      {/* 使用 TailwindCSS 进行布局和样式设置 */}
      <div className="flex flex-col flex-grow justify-center items-center font-wq mb-12 mt-20 text-white">
        <div className="w-[640-px] text-center">
          {/* 标题：铸造 RealRainCoin */}
          <h1 className="text-6xl text-[#0c47f8]">铸造 RealRainCoin</h1>
          {isConnected ? (
            // 如果已连接钱包
            <>
              <p className="text-4xl mt-20 mb-12 animate-pulse">
                开始铸造你的第一个 RealRainCoin 代币吧!
              </p>
              {/* 输入框：输入用户想铸造的代币数量 */}
              <div className="flex justify-center mt-4">
                <input
                  value={mintAmount}
                  onChange={(e) => setMintAmount((e.target.value))}
                  className="text-center w-80 h-10 mt-4 mb-4 text-pink-600 text-2xl border border-gray-300 rounded-md p-2"
                  type="string"
                  placeholder="请输入你想要铸造的代币数量..."
                  min="0"
                />
              </div>

              {/* 按钮：触发铸造代币 */}
              <div className="flex-col justify-center items-center mt-8">
                <button
                  onClick={handleMint}
                  className="bg-[#1960f9] rounded-md shadow-md text-2xl p-4 w-80"
                >
                  立即铸造！
                </button>
                {/* 显示当前用户的代币余额 */}
                <p className="t text-[#ff2c73] text-xl animate-pulse mt-4">
                  当前账户地址：{accounts[0]}
                  <br />
                  当前的 RealRainCoin 代币余额：{" "}
                  {balance !== null ? `${balance} ETH` : "正在加载中..."}
                </p>
              </div>
            </>
          ) : (
            // 如果未连接钱包，提示用户连接钱包
            <div className="flex justify-center text-6xl items-center mt-48 mb-20">
              <p className="animate-pulse">连接钱包以开始铸造代币...</p>
            </div>
          )}
        </div>
      </div>
    </>
  );
}