import 'package:dio/dio.dart';

class ServiceManager {
  static ServiceManager? _instance;
  static ServiceManager get instance {
    _instance ??= ServiceManager._init();
    return _instance!;
  }

  late final Dio dio;
  final String baseUrl = 'https://picsum.photos/v2';

  ServiceManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );

    // Hata yakalama interceptor'ı
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          throw Exception('Bir hata oluştu: ${e.message}');
        },
      ),
    );
  }
}
