import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'blocs/dog_breed_bloc.dart';
import 'core/network/d_dio.dart';
import 'core/network/network_info.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  getIt.registerSingleton<Dio>(Dio());

  getIt
      .registerSingleton<NetworkInfo>(NetworkInfoImpl(DataConnectionChecker()));

  getIt.registerSingleton<DDio>(
      DDio(networkInfo: getIt<NetworkInfo>(), dio: getIt<Dio>()));

  getIt.registerSingleton<NumberTriviaBloc>(
      NumberTriviaBloc(dioClient: getIt<DDio>()));
}

void unregisterInjection() {
  getIt.unregister<NumberTriviaBloc>(
    disposingFunction: (numberTriviaBloc) {
      numberTriviaBloc.dispose();
    },
  );
}
