// Dio请求类
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options.baseUrl = GlobalConstant.baseUrl;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstant.timeOut);
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstant.timeOut);
    _addInterceptors();
  }
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          // 在发送请求之前做一些事情
          return handler.next(request);
        },
        onResponse: (response, handler) {
          // 在收到响应之前做一些事情
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response);
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (DioException e, handler) {
          // 在发生错误时做一些事情
          return handler.reject(e);
        },
      ),
    );
  }

  // get请求
  Future<dynamic> get(url, {params}) async {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }
  // post请求
  Future<dynamic> post(url, {data}) async {
    return _handleResponse(_dio.post(url, data: data));
  }

  // 处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      if (res.data["code"] != GlobalConstant.SUCCESS_CODE) {
        throw Exception(res.data["msg"] ?? "加载数据异常");
      }
      return res.data["result"];
    } on DioException catch (e) {
      return Exception(e);
    }
  }
}

// 单例模式，确保只有一个实例
final dioRequest = DioRequest();


// dio 请求工具发出请求 返回的数据 Response<dynamic> .data
// 把所有的接口的data解放出来 拿到data 直接返回 要判断业务状态码是不是==1 如果不是 要抛出异常


