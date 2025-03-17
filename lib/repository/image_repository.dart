import 'package:get/get.dart';
import '../core/service/service_manager.dart';
import '../models/image_model.dart';
import 'package:dio/dio.dart';

class ImageRepository {
  final ServiceManager _serviceManager = ServiceManager.instance;

  Future<List<ImageModel>> getImages({int page = 1, int perPage = 10}) async {
    try {
      final response = await _serviceManager.dio.get(
        '/list',
        queryParameters: {
          'page': page,
          'limit': perPage,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        if (data.isEmpty) {
          throw Exception('Resim bulunamadı');
        }
        return data.map((json) {
          final image = ImageModel.fromJson(json);
          // Resim URL'lerini düzgün formatta oluştur
          if (image.id != null) {
            image.url = 'https://picsum.photos/id/${image.id}/800/600';
            image.thumbUrl = 'https://picsum.photos/id/${image.id}/200/300';
          }
          return image;
        }).toList();
      } else {
        throw Exception(
            'Resimler yüklenirken bir hata oluştu: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Bağlantı zaman aşımına uğradı');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('İnternet bağlantınızı kontrol edin');
      }
      throw Exception('Resimler yüklenirken bir hata oluştu: ${e.message}');
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu: $e');
    }
  }
}
