import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequtest.dart';
import 'package:hm_shop/viewmodomals/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  try {
    List<dynamic> data = await dioRequest.get(HttpConstants.BANNER_LIST);
    List<BannerItem> bannerList = data
        .map((e) => BannerItem.fromJson(e))
        .toList();
    return bannerList;
  } catch (e) {
    return [];
  }
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  try {
    List<dynamic> data = await dioRequest.get(HttpConstants.CATEGORY_LIST);
    List<CategoryItem> categoryList = data
        .map((e) => CategoryItem.fromJson(e))
        .toList();
    return categoryList;
  } catch (e) {
    return [];
  }
}
// 获取特惠推荐列表

Future<PreferenceItem> getPreferenceListApi() async {
  try {
    dynamic data = await dioRequest.get(HttpConstants.HOT_PREFERENCE_LIST);
    PreferenceItem preferenceItem = PreferenceItem.fromJson(data);
    return preferenceItem;
  } catch (e) {
    return PreferenceItem();
  }
}

// 热推商品列表 API 函数
Future<HotRecommendItem> getHotRecommendListApi() async {
  try {
    final data = await dioRequest.get(HttpConstants.HOT_INVOUGE_LIST);
    if (data != null) {
      return HotRecommendItem.fromJson(data);
    } else {
      print('热推商品列表API返回数据为空');
      return HotRecommendItem();
    }
  } catch (e) {
    print('获取热推商品列表失败: $e');
    return HotRecommendItem();
  }
}

// 一站式推荐列表 API 函数
Future<HotOnestopViewModel> getHotOnestopListApi() async {
  try {
    final data = await dioRequest.get(HttpConstants.HOT_ONESTOP_LIST);
    if (data != null) {
      return HotOnestopViewModel(
        hotOnestopItem: HotRecommendItem.fromJson(data),
      );
    } else {
      print('一站式推荐列表API返回数据为空');
      return HotOnestopViewModel();
    }
  } catch (e) {
    print('获取一站式推荐列表失败: $e');
    return HotOnestopViewModel();
  }
}

// 获取推荐列表
Future<ProductList> getRecommendListApi(
  Map<String, int> map, {
  Map<String, dynamic>? params,
}) async {
  try {
    final data = await dioRequest.get(
      HttpConstants.RECOMMEND_LIST,
      params: params,
    );
    print('推荐列表API返回数据: $data');
    if (data != null) {
      return ProductList.fromJson(data);
    } else {
      print('推荐列表API返回数据为空');
      return ProductList(items: []); // 修改这里
    }
  } catch (e) {
    print('获取推荐列表失败: $e');
    return ProductList(items: []); // 修改这里
  }
}
