import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,

      String lang = 'en'}) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': "application/json"
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': "application/json"
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> updateData(
      {required String url,
        Map<String, dynamic>? query,
         Map<String, dynamic>? data,
        String lang = 'en',
        String? token}) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': "application/json"
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
  static Future<Response> deleteData(
      {required String url,
        Map<String, dynamic>? query,
        Map<String, dynamic>? data,
        String lang = 'en',
        String? token}) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': "application/json"
    };
    return await dio.delete(url, queryParameters: query, data: data);
  }
}
