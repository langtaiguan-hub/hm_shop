#!/bin/bash

# 清理所有框架的扩展属性
echo "清理所有框架的扩展属性..."

# 清理 Flutter 框架相关文件
if [ -d "ios/Flutter" ]; then
  xattr -cr ios/Flutter
  echo "✓ 清理了 ios/Flutter 目录"
fi

# 清理 Pods 目录下的所有框架
if [ -d "ios/Pods" ]; then
  xattr -cr ios/Pods
  echo "✓ 清理了 ios/Pods 目录"
fi

# 清理构建目录
if [ -d "build" ]; then
  xattr -cr build
  echo "✓ 清理了 build 目录"
fi

echo "所有扩展属性清理完成！"