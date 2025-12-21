import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

// 管理路由
Widget getRootWidget( ) {
  return MaterialApp(
     initialRoute: '/',
     routes:getRootRoutes(),
  );
}
// 路由表
Map<String,Widget Function(BuildContext)> getRootRoutes(){
  return {
    '/':(context)=>  MainPage(),
    '/login':(context)=>  LoginPage(),
  };
}
