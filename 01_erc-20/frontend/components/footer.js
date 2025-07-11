/*
 * @Description: 页脚组件
 * @Author: 真雨☔ 1936648485@qq.com
 * @Date: 2025-07-10 23:17:55
 * @LastEditors: 真雨☔ 1936648485@qq.com
 * @LastEditTime: 2025-07-11 20:28:37
 * @FilePath: \frontend\components\footer.js
 * @X/Facebook: 1936648485@qq.com ~~~~~~~~~~~~~~~~~~~~~~~ Blog：reallyrain.com
 * Copyright (c) 2025 by real-rain, All Rights Reserved. 
 */
// 导出默认组件 Footer，用于显示页面的底部内容
export default function Footer() {
  return (
    <>
      {/* 使用 TailwindCSS 定义 Footer 的样式 */}
      <footer className="font-wq w-full text-white text-center mt-auto py-4 text-xl">
        {/* 提示信息，提醒用户不要将该教程直接用于生产环境 */}
        <p>本教程仅供参考，不建议在生产环境中使用</p>

        {/* 提供关于教程的更多信息，并鼓励用户支持作者 */}
        <h2>
          {/* <br /> */}
          {/* 鼓励用户通过 GitHub 点星*/}
          如果这个作品对你有所帮助, 欢迎在 github 给作者一个星星，非常感谢！！！
        </h2>
      </footer>
    </>
  );
}