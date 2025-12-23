// 首页banner 模型类
class BannerItem {
  final String? imgUrl;
  final String? id;

  BannerItem({this.imgUrl, this.id});
  // 从json数据创建BannerItem实例的工厂构造函数 一般用factory 构造函数
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(imgUrl: json["imgUrl"] ?? "", id: json["id"] ?? "");
  }
}

// 首页分类 模型类
class CategoryItem {
  final String? name;
  final String? id;
  final String? picture;
  final List<CategoryItem>? children;

  CategoryItem({this.name, this.id, this.picture, this.children});
  // 从json数据创建CategoryItem实例的工厂构造函数 一般用factory 构造函数
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      name: json["name"] ?? "",
      id: json["id"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] != null
          ? List<CategoryItem>.from(
              json["children"].map((x) => CategoryItem.fromJson(x)),
            )
          : null,
    );
  }
}



// 首页特惠推荐 商品项模型类
class PreferenceGoodsItem {
  final String? id;
  final String? name;
  final String? desc;
  final String? price;
  final String? picture;
  final int? orderNum;

  PreferenceGoodsItem({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.picture,
    this.orderNum,
  });

  factory PreferenceGoodsItem.fromJson(Map<String, dynamic> json) {
    return PreferenceGoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"] ?? "",
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

// 首页特惠推荐 商品列表模型类
class PreferenceGoodsItems {
  final int? counts;
  final int? pageSize;
  final int? pages;
  final int? page;
  final List<PreferenceGoodsItem>? items;

  PreferenceGoodsItems({
    this.counts,
    this.pageSize,
    this.pages,
    this.page,
    this.items,
  });

  factory PreferenceGoodsItems.fromJson(Map<String, dynamic> json) {
    return PreferenceGoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] != null
          ? List<PreferenceGoodsItem>.from(
              json["items"].map((x) => PreferenceGoodsItem.fromJson(x)),
            )
          : null,
    );
  }
}

// 首页特惠推荐 子类型模型类
class PreferenceSubType {
  final String? id;
  final String? title;
  final PreferenceGoodsItems? goodsItems;

  PreferenceSubType({this.id, this.title, this.goodsItems});

  factory PreferenceSubType.fromJson(Map<String, dynamic> json) {
    return PreferenceSubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: json["goodsItems"] != null
          ? PreferenceGoodsItems.fromJson(json["goodsItems"])
          : null,
    );
  }
}

// 首页特惠推荐 主模型类
class PreferenceItem {
  final String? id;
  final String? title;
  final List<PreferenceSubType>? subTypes;

  PreferenceItem({this.id, this.title, this.subTypes});

  factory PreferenceItem.fromJson(Map<String, dynamic> json) {
    return PreferenceItem(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] != null
          ? List<PreferenceSubType>.from(
              json["subTypes"].map((x) => PreferenceSubType.fromJson(x)),
            )
          : null,
    );
  }
}

//flutter 必须强制转化 没有隐式转化
