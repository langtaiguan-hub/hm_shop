import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class Hmsuggesrion extends StatefulWidget {
  const Hmsuggesrion({super.key, required this.preferenceItem});

  final PreferenceItem preferenceItem;

  @override
  State<Hmsuggesrion> createState() => _HmsuggesrionState();
}

class _HmsuggesrionState extends State<Hmsuggesrion> {
  List<PreferenceGoodsItem> _getDisplayItems() {
    if (widget.preferenceItem.subTypes?.isEmpty ?? true) {
      return [];
    }
    return widget.preferenceItem.subTypes?.first?.goodsItems?.items
            ?.take(3)
            .toList() ??
        [];
  }

  List<Widget> _getChildrenList() {
    List<PreferenceGoodsItem> list = _getDisplayItems();
    return List.generate(
      list.length,
      (index) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'lib/assets/tab/home_1.png',
                fit: BoxFit.cover,
                width: 100,
                height: 140,
              ),
              list[index].picture ?? '',
              fit: BoxFit.cover,
              width: 80,
              height: 120,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 177, 66, 58),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '¥${list[index].price ?? ''}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          '特惠推荐',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 94, 12, 12),
          ),
        ),
        SizedBox(width: 10),
        Text(
          '精选省攻略',
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 13, 1, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftItem() {
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.red,
        image: DecorationImage(
          image: AssetImage("lib/assets/tab/home_1.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage("lib/assets/tab/user-bg.svg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeftItem(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
