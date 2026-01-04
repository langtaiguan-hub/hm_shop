#!/bin/bash

echo "=== 快速清理和构建脚本 ==="

# 清理所有可能导致签名错误的扩展属性
echo "\n清理所有扩展属性..."
# 清理整个项目目录
echo "清理项目根目录..."
xattr -cr .

# 清理构建目录
echo "清理构建目录..."
rm -rf build
mkdir -p build
xattr -cr build

# 启动 iPhone 15 模拟器
echo "\n启动 iPhone 15 模拟器..."
# 获取 iPhone 15 模拟器的设备 ID
iPhone15ID=$(xcrun simctl list devices | grep -E "iPhone 15.*(Booted|Shutdown)" | grep -v "unavailable" | head -1 | awk -F'[()]' '{print $2}')

if [ ! -z "$iPhone15ID" ]; then
  echo "找到 iPhone 15 模拟器: $iPhone15ID"
  # 启动模拟器
  xcrun simctl boot $iPhone15ID
  
  # 等待模拟器启动
  echo "等待模拟器启动..."
  sleep 5
  
  # 运行应用
  echo "\n运行应用..."
  flutter run -d "$iPhone15ID"
else
  echo "没有找到可用的 iPhone 15 模拟器！"
  echo "请确保模拟器已安装并可用。"
fi

echo "\n=== 脚本执行完成 ==="