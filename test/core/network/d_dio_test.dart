import 'package:dio/dio.dart';
import 'package:dxdart/core/constants.dart';
import 'package:dxdart/core/network/d_dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:dxdart/core/network/network_info.dart';

class MockNetworkInfoImpl extends Mock implements NetworkInfoImpl {}

class MockDDio extends Mock implements DDio {}

void main() {
  MockNetworkInfoImpl mockNetWorkInfo;

  setUp(() {
    mockNetWorkInfo = MockNetworkInfoImpl();
  });

  test('#1 construct with intercepter', () async {
    final dio = Dio();
    DDio(dio: dio, networkInfo: mockNetWorkInfo);

    expect(dio.options, dioBaseOption);
    expect(dio.interceptors.length, 1);
  });

  test('#2 test onRequest Intercepter', () async {
    final dio = Dio();
    final dDio = DDio(dio: dio, networkInfo: mockNetWorkInfo);

    expect(dio.options, dioBaseOption);
    expect(dio.interceptors.length, 1);

    when(mockNetWorkInfo.isConnected)
        .thenAnswer((_) async => Future.value(true));

    final rqOption = await dDio.onRequest(RequestOptions()) as RequestOptions;

    expect(rqOption.headers['x-api-key'], API_KEY);
    verify(mockNetWorkInfo.isConnected).called(1);
  });
}
