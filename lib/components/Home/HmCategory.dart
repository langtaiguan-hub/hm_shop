import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const HmCategory({super.key, required this.categoryList});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(), // 添加弹性滚动效果
        itemBuilder: (context, index) {
          final categoryItem = widget.categoryList[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.5, // 必须设置固定宽度
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10), // 只保留右侧边距
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  categoryItem.picture ?? '',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain, // 确保图片适应容器
                ),
                SizedBox(height: 5), // 添加间距
                Container(
                  child: Text(
                    categoryItem.name ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: widget.categoryList.length,
      ),
    );
  }
}
