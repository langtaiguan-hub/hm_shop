import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class Hmhot extends StatefulWidget {
  final HotRecommendItem result;
  final String type;
  const Hmhot({super.key, required this.result, required this.type});

  @override
  State<Hmhot> createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  //获取两条数据
  List<PreferenceGoodsItem> get _items {
    if (widget.result.subTypes?.isEmpty ?? true) {
      return [];
    }
    return widget.result.subTypes!.first.goodsItems?.items?.take(2).toList() ??
        [];
  }

  // 构建头部
  Widget _buildHeader() {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            // 使用Expanded确保文本不会溢出
            child: Text(
              widget.type == 'step' ? '一站买全' : '爆款推荐',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 161, 47, 47),
              ),
              maxLines: 1, // 限制为单行
              overflow: TextOverflow.ellipsis, // 溢出时显示省略号
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            // 使用Expanded确保文本不会溢出
            child: Text(
              widget.type == 'step' ? '精心优选' : '最受欢迎',
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 109, 71, 71),
              ),
              maxLines: 1, // 限制为单行
              overflow: TextOverflow.ellipsis, // 溢出时显示省略号
            ),
          ),
        ],
      ),
    );
  }

  // 构建内容
  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            SizedBox(height: 2),
            _items.isNotEmpty
                ? Container(
                    width: double.infinity, // 确保容器宽度适应父容器
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // 改为start对齐
                        children: _buildItemList(),
                      ),
                    ),
                  )
                : Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '暂无商品数据',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // 构建商品列表
  List<Widget> _buildItemList() {
    return _items.map((item) {
      return Container(
        height: 150,

        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(8),
        child: _buildItem(item),
      );
    }).toList();
  }

  // 构建商品项
  Widget _buildItem(PreferenceGoodsItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 80, maxHeight: 80), // 添加最大约束
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.picture ?? '',
              fit: BoxFit.contain, // 改为contain确保图片适应容器
              width: double.infinity, // 使用自适应宽度
              height: double.infinity, // 使用自适应高度
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.image, color: Colors.grey[400], size: 30),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          // 移除Expanded，使用固定高度容器
          height: 40, // 固定高度
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // 为商品名称添加固定高度容器
                height: 20,
                child: Text(
                  item.name ?? '商品名称',
                  style: TextStyle(
                    fontSize: 10, // 减小字体大小
                    color: const Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2, // 允许最多2行
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 2), // 减小间距
              Text(
                "¥${item.price ?? '0.00'}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: widget.type == 'step'
            ? const Color.fromARGB(255, 249, 242, 242)
            : const Color.fromARGB(255, 249, 242, 242),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: _buildContent(),
    );
  }
}
