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
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final categoryItem = widget.categoryList[index];
          return Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                Image.network(
                  categoryItem.picture ?? '',
                  width: 40,
                  height: 40,
                ),
                Text(
                  categoryItem.name ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.white),
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
