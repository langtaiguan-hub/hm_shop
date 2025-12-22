import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmSuggesrion.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
 final List<BannerItem> _bannerList = [
    BannerItem(
      imgUrl:
          "https://sys-mgr.oss-cn-beijing.aliyuncs.com/mall/2025/12/186943b5e2e4b00ef9cbdd6093.jpeg",
      id: "1",
    ),
    BannerItem(
      imgUrl:
          "https://sys-mgr.oss-cn-beijing.aliyuncs.com/mall/2025/12/186943b5d3e4b00ef9cbdd6091.jpeg",
      id: "2",
    ),
    BannerItem(
      imgUrl:
          "https://sys-mgr.oss-cn-beijing.aliyuncs.com/mall/2025/12/1869439918e4b00ef9cbdd6074.jpeg",
      id: "3",
    ),
  ];
  // 获取滚动容器的内容
  final ScrollController _scrollController = ScrollController();
  List<Widget> _getScrollChildern() {
    return [
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Hmsuggesrion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hmhot()),
              SizedBox(width: 10),
              Expanded(child: Hmhot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: _getScrollChildern(),
    );
  }
}
