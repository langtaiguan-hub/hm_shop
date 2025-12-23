import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
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
    // BannerItem(
    //   imgUrl:
    //       "https://sys-mgr.oss-cn-beijing.aliyuncs.com/mall/2025/12/186943b5e2e4b00ef9cbdd6093.jpeg",
    //   id: "1",
    // ),
    // BannerItem(
    //   imgUrl:
    //       "https://sys-mgr.oss-cn-beijing.aliyuncs.com/mall/2025/12/186943b5d3e4b00ef9cbdd6091.jpeg",
    //   id: "2",
    // ),
    // BannerItem(
    //   imgUrl:
    //       "https://sys-mgr.oss-cn-beijing.aliyuncs.com/mall/2025/12/1869439918e4b00ef9cbdd6074.jpeg",
    //   id: "3",
    // ),
  ];
  // 获取滚动容器的内容
  final ScrollController _scrollController = ScrollController();

  final List<CategoryItem> _categoryList = [];
  // ignore: unused_field
  PreferenceItem _preferenceItem = PreferenceItem(
    id: "",
    title: "",
    subTypes: [],
  );

  // 特惠推荐列表
  // 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Hmsuggesrion(preferenceItem: _preferenceItem)),
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

  // 初始化数据
  Future<void> _initData() async {
    // 获取轮播图数据
    await _getBannerList();
    // 获取分类列表数据
    await _getCategoryList();
    // 获取特惠推荐列表
    await _getPreferenceList();
  }

  // 获取轮播图数据
  Future<void> _getBannerList() async {
    List<BannerItem> bannerList = await getBannerListApi();
    setState(() {
      _bannerList.addAll(bannerList);
    });
  }

  // 获取分类列表数据
  Future<void> _getCategoryList() async {
    List<CategoryItem> categoryList = await getCategoryListApi();
    print(categoryList);
    setState(() {
      _categoryList.addAll(categoryList);
    });
  }

  // 获取特惠推荐列表
  Future<void> _getPreferenceList() async {
    _preferenceItem = await getPreferenceListApi();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: _getScrollChildern(),
    );
  }
}
