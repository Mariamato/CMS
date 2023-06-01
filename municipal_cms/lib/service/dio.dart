import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  //ios
  //dio.options.baseUrl = 'http://127.0.0.1:8000/api';
  //android
  dio.options.baseUrl = 'http://127.0.0.1:8000/api/';
  dio.options.headers['accept'] = 'Applicatio/json';

  return dio;
}
