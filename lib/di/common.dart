import 'package:ecommerce_app/core/networkchecker/network_info.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void registerCommonDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
   sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => HttpClient(baseUrl: "baseUrl"));




  // Register NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}