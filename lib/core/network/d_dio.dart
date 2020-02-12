import 'package:dio/dio.dart';
import 'package:dxdart/core/constants.dart';
import 'package:dxdart/core/network/network_info.dart';

final BaseOptions dioBaseOption = BaseOptions(
  connectTimeout: 10000,
  receiveTimeout: 10000,
  sendTimeout: 10000,
);

class DDio {
  final NetworkInfo networkInfo;
  final Dio dio;

  DDio({this.networkInfo, this.dio}) {
    dio.options = dioBaseOption;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
      ),
    );
  }

  Future<dynamic> onRequest(RequestOptions options) async {
    if (!await networkInfo.isConnected) {
      throw Exception;
    }

    options.headers = {'x-api-key': API_KEY};
    return options;
  }

  Future<dynamic> onResponse(Response response) async {
    return response;
  }

  Future<dynamic> onError(DioError e) async {
    return e;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) {
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) {
    return dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) {
    return dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) {
    return dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
