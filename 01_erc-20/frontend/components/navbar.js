/*
 * @Description: 标题栏组件
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-10 00:24:50
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-12 14:12:01
 * @FilePath: \foundry_project\01_erc-20\frontend\components\navbar.js
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved. 
 */
// 导入 Next.js 提供的 Link 组件，用于实现页面跳转
import Link from "next/link";
// 导入 Next.js 提供的 Image 组件，用于优化图像加载
import Image from "next/image";
// 导入本地的 Blog 图标资源
import Blog from "@/public/assets/blog.png";
// 导入本地的 GitHub 图标资源
import Github from "@/public/assets/github.png";
// 导入 ethers 库，用于与以太坊区块链进行交互
import { ethers } from "ethers";

// 导出默认组件 Navbar，接收两个 props：accounts（当前连接的账户列表）和 setAccounts（更新账户的方法）
export default function Navbar({ accounts, setAccounts }) {
  // 判断是否已连接账户，若 accounts 数组的第一个元素存在，则表示已连接
  const isConnected = Boolean(accounts[0]);

  // 定义异步函数 connectAccount，用于连接用户的以太坊钱包
  async function connectAccount() {
    try {
      // 检查浏览器是否提供了以太坊对象（window.ethereum），这是与钱包交互的入口
      if (window.ethereum) {
        // 调用以太坊对象的请求方法，请求用户授权并返回账户列表
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        // 更新父组件传递的账户状态
        setAccounts(accounts);
      } else {
        // 如果未检测到以太坊对象，输出错误信息
        console.error("Ethereum provider not found.");
      }
    } catch (e) {
      // 捕获连接失败的异常，并在控制台打印错误信息
      console.error(e);
    }
  }

  // 返回 Navbar 的 JSX 内容
  return (
    <>
      {/* 整体布局为水平排列，使用 TailwindCSS 进行样式控制 */}
      <div className="flex justify-between items-center text-2xl px-8 py-6 font-wq text-white">
        {/* 左侧部分：包含社交媒体的链接与图标 */}
        <div className="flex">
          {/* 链接到博客 */}
          <Link
            href="https://reallyrain.com"
            target="_blank"
            rel="noop"
          >
            {/* 图标和文字水平排列 */}
            <div className="flex items-center space-x-2">
              {/* 博客图标 */}
              <Image src={Blog} alt="@real_rain" width={36} height={36} />
              {/* 博客名称 */}
              <span className="text-3xl px-4">@真雨☔の小破站</span>
            </div>
          </Link>

          {/* 链接到 GitHub 个人仓库 */}
          <Link
            href="https://github.com/real-rain"
            target="_blank"
            rel="rel_link"
          >
            {/* 图标和文字水平排列 */}
            <div className="flex items-center space-x-2">
              {/* GitHub 图标 */}
              <Image src={Github} alt="@real_rain" width={36} height={36} />
              {/* 显示 GitHub 仓库链接描述 */}
              <span className="text-3xl px-4">@源代码仓库</span>
            </div>
          </Link>
        </div>

        {/* 右侧部分：包含连接钱包按钮和其他操作 */}
        <div className="flex items-center space-x-6 text-2xl">
          {/* 联系作者的链接，点击后通过邮件联系 */}
          <Link
            href="mailto:1936648485@qq.com"
            target="_blank"
            rel="rel_link"
          >
            联系作者
          </Link>

          {/* 根据是否已连接钱包动态显示内容 */}
          {isConnected ? (
            // 如果已连接账户，显示已连接状态
            <p className="bg-red-600 px-6 py-2 rounded-md">已连接</p>
          ) : (
            // 如果未连接账户，显示连接钱包按钮
            <button
              onClick={connectAccount}
              className="bg-blue-600 px-6 py-2 rounded-md shadow-lg hover:bg-blue-800 transition duration-300"
            >
              连接钱包
            </button>
          )}
        </div>
      </div>
    </>
  );
}