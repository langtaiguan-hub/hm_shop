class BannerItem {
  final String? imgUrl;
  final String? id;

  BannerItem({this.imgUrl, this.id});
  // 从json数据创建BannerItem实例的工厂构造函数 一般用factory 构造函数
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      imgUrl: json["imgUrl"] ?? "",
      id: json["id"] ?? "",
    );
  }
}
//flutter 必须强制转化 没有隐式转化

