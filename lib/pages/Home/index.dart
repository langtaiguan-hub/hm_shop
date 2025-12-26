import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmSuggesrion.dart';
import 'package:hm_shop/utils/Toast.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerItem> _bannerList = [];
  // 获取滚动容器的内容
  final ScrollController _scrollController = ScrollController();

  final List<CategoryItem> _categoryList = [];
  // ignore: unused_field
  PreferenceItem _preferenceItem = PreferenceItem(
    id: "",
    title: "",
    subTypes: [],
  );
  HotOnestopViewModel _hotOnestopList = HotOnestopViewModel();

  HotRecommendItem _hotInVogueList = HotRecommendItem(
    id: "",
    title: "",
    subTypes: [],
  );

  ProductList _recommendList = ProductList(items: []);
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
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Hmhot(result: _hotInVogueList, type: 'hot'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Hmhot(
                  result: _hotOnestopList.hotOnestopItem,
                  type: 'step',
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(productList: _recommendList),
    ];
  }

  // 初始化数据
  Future<void> _initData() async {
    _pageNum = 1;
    _hasMore = true;
    _isLoading = false;
    // 获取轮播图数据
    await _getBannerList();
    // 获取分类列表数据
    await _getCategoryList();
    // 获取特惠推荐列表
    await _getPreferenceList();
    // 获取热推商品列表
    await _getHotInVogueList();
    // 获取一站式推荐列表
    await _getHotOnestopList();
    // 获取推荐列表
    await _getRecommendList();
    _registerScrollController();
  }

  // 注册滚动控制器
  void _registerScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 50 &&
          _hasMore) {
        print('加载更多数据');
        // 加载更多数据

        _getRecommendList();
      }
    });
  }

  int _pageNum = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int pageSize = 10; // 每页显示10条数据

    // 正确传递分页参数
    final ProductList recommendList = await getRecommendListApi(
      {}, // 第一个参数是空的Map<String, int>
      params: {"page": _pageNum, "limit": pageSize * _pageNum},
    );

    setState(() {
      if (_pageNum == 1) {
        // 如果是第一页，直接替换数据
        _recommendList = recommendList;
      } else {
        // 如果是加载更多，追加数据
        _recommendList = ProductList(
          items: [..._recommendList.items ?? [], ...recommendList.items ?? []],
        );
      }
    });

    if (recommendList.items == null || recommendList.items!.length < pageSize) {
      _hasMore = false;
    } else {
      _pageNum++;
    }
    _isLoading = false;
  }

  // 获取一站式推荐列表
  Future<void> _getHotOnestopList() async {
    final hotOnestopList = await getHotOnestopListApi();
    setState(() {
      _hotOnestopList = hotOnestopList;
    });
  }

  // 获取热推商品列表
  Future<void> _getHotInVogueList() async {
    final hotInVogueList = await getHotRecommendListApi();
    setState(() {
      _hotInVogueList = hotInVogueList;
    });
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
    Future.microtask(() {
      // 初始化完成后，将顶部 padding 设为 0
      setState(() {
        _paddingTop = 100;
      });
      // 初始化完成后，调用刷新方法
      _refreshIndicatorKey.currentState?.show();
    });
  }

  // 刷新时，顶部 padding 为 0
  double _paddingTop = 0;

  // globalKey 用于刷新Indicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await _initData();
        // 刷新成功后，显示Toast提示
        Toast.showToast(context, '刷新成功了');
        // 刷新成功后，将顶部 padding 设为 0
        setState(() {
          _paddingTop = 0;
        });
      }, 
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getScrollChildern(),
        ),
      ),
    );
  }
}
