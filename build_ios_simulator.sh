#!/bin/bash

# 完整的 iOS 模拟器构建脚本
# 解决 "resource fork, Finder information, or similar detritus not allowed" 签名错误

echo "=== Flutter iOS Simulator 构建脚本 ==="

# 1. 清理项目
echo "\n1. 清理 Flutter 项目..."
flutter clean

# 2. 安装依赖
echo "\n2. 安装依赖..."
flutter pub get

# 3. 清理 Pods 和生成 Podfile.lock
echo "\n3. 清理和安装 CocoaPods 依赖..."
cd ios
rm -rf Pods Podfile.lock .symlinks
pod install
cd ..

# 4. 清理所有可能导致签名错误的扩展属性
echo "\n4. 清理所有扩展属性..."
# 清理 Flutter 框架
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
rm -rf build
mkdir -p build
xattr -cr build

# 5. 使用 flutter devices 查找 iPhone 15 模拟器的设备 ID
echo "\n5. 获取 iPhone 15 模拟器设备 ID..."
IPHONE_15_ID=$(flutter devices | grep -E "iPhone 15.*ios.*simulator" | head -1 | awk '{print $5}')
echo "找到 iPhone 15 模拟器: $IPHONE_15_ID"

# 6. 启动模拟器
echo "\n6. 启动 iPhone 15 模拟器..."
if [ ! -z "$IPHONE_15_ID" ]; then
  xcrun simctl boot $IPHONE_15_ID
fi

# 7. 直接运行应用（会自动构建）
echo "\n7. 运行应用..."
flutter run -d "$IPHONE_15_ID"

echo "\n=== 构建脚本执行完成 ==="