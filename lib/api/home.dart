import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequtest.dart';
import 'package:hm_shop/viewmodomals/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  try {
    List<dynamic> data = await dioRequest.get(HttpConstants.BANNER_LIST);
    List<BannerItem> bannerList = data.map((e) => BannerItem.fromJson(e)).toList();
    return bannerList;
  } catch (e) {
    return [];
  }
}