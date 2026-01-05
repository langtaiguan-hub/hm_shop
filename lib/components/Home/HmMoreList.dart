import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class HmMoreList extends StatefulWidget {
  const HmMoreList({super.key, required this.productList});

  final ProductList productList;

  @override
  State<HmMoreList> createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  // 获取子项 - 正确的方法定义
  Widget _getChildren(int index) {
    if (widget.productList.items == null || widget.productList.items!.isEmpty) {
      return Text('暂无商品', style: TextStyle(fontSize: 16, color: Colors.white));
    }

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_buildContent(index)],
    );
  }

  // 构建子项的头部分
  Widget _buildContent(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [_buildHeader(index), _getContentChildren(index)],
      ),
    );
  }

  // 构建子项的内容部分
  Widget _getContentChildren(int index) {
    return Container(
      width: double.infinity,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.network(
            widget.productList.items![index].picture ?? "",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    '图片加载失败',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // 构建子项的头部分
  Widget _buildHeader(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4), // 添加垂直内边距
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20, // 固定高度
            child: Text(
              widget.productList.items![index].name ?? "",
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 23, 16, 37),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "¥${widget.productList.items![index].price?.toString() ?? ""}",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 44, 8, 8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "已售${widget.productList.items![index].payCount?.toString() ?? ""}",
                    style: TextStyle(
                      fontSize: 10,
                      color: const Color.fromARGB(255, 35, 33, 33),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 160, 54, 54),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${widget.productList.items![index].payCount?.toString() ?? ""}人付款",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: widget.productList.items?.length ?? 0,
      itemBuilder: (context, index) {
        return Container(
          color: const Color.fromARGB(255, 167, 160, 160),
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: _getChildren(index),
        );
      },
    );
  }
}
