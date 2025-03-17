import 'package:get/get.dart';
import '../models/image_model.dart';
import '../repository/image_repository.dart';

class ImageController extends GetxController {
  final ImageListModel imageListModel = ImageListModel();
  final ImageRepository _repository = ImageRepository();
  var selectedImage = Rxn<ImageModel>();
  var currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  Future<void> fetchImages({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      imageListModel.images.clear();
    }

    try {
      imageListModel.isLoading.value = true;
      imageListModel.error.value = '';

      final images = await _repository.getImages(
        page: currentPage,
        perPage: 10,
      );

      imageListModel.images.addAll(images);
      currentPage++;
    } catch (e) {
      imageListModel.error.value = e.toString();
      String errorMessage = 'Resimler yüklenirken bir hata oluştu';

      if (e.toString().contains('API key')) {
        errorMessage = 'Lütfen Unsplash API key\'inizi ekleyin';
      } else if (e.toString().contains('İnternet bağlantınızı')) {
        errorMessage = 'İnternet bağlantınızı kontrol edin';
      } else if (e.toString().contains('zaman aşımı')) {
        errorMessage = 'Bağlantı zaman aşımına uğradı';
      }

      Get.snackbar(
        'Hata',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      imageListModel.isLoading.value = false;
    }
  }

  void setSelectedImage(ImageModel image) {
    selectedImage.value = image;
  }

  void clearSelectedImage() {
    selectedImage.value = null;
  }

  void loadMore() {
    if (!imageListModel.isLoading.value) {
      fetchImages();
    }
  }
}
