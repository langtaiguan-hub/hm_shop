import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/viewmodomals/home.dart';

class Hmslider extends StatefulWidget {
  const Hmslider({super.key, required this.bannerList});

  final List<BannerItem> bannerList;

  @override
  State<Hmslider> createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  final UserController _userController = Get.put(UserController());

  int _currentIndex = 0;
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  Widget _getSlider() {
    final double width = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _carouselSliderController,
      items: List.generate(
        widget.bannerList.length,
        (index) => Image.network(
          widget.bannerList[index].imgUrl ?? '',
          fit: BoxFit.cover,
          width: width,
        ),
      ),
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
            _userController.updateUserInfo({'nickName': '请搜索拉'});
          });
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Obx(
        () => Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  _userController.userInfo.value?['nickName'] ?? '搜索商品',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.bannerList.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _carouselSliderController.animateToPage(index);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 40 : 20,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
