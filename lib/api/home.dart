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
