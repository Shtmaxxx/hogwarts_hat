import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const String envUrl = 'https://hp-api-sveu.onrender.com/api/';

@singleton
class ApiManager {
  late final Dio _dio;

  ApiManager() : _dio = Dio() {
    _dio.options = _defaultOption();
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<Response> patch(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.patch(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.put(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.delete(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }

  /// Default basic configuration
  BaseOptions _defaultOption() {
    BaseOptions option = BaseOptions();
    option.baseUrl = envUrl;
    option.contentType = 'application/json';
    option.connectTimeout = 1000 * 60;
    option.receiveTimeout = 1000 * 60;
    option.sendTimeout = 1000 * 60;
    option.headers = {'Accept': 'application/json', 'X-Requested-With': 'XMLHttpRequest'};
    return option;
  }
}
