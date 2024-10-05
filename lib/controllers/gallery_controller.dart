import 'package:gallery/controllers/pixabay_controller.dart';
import 'package:gallery/models/image_card.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  var images = <PixabayImage>[].obs;
  var isLoading = false.obs;
  var page = 1;

  final PixabayService pixabayService = PixabayService();

  @override
  void onInit() {
    fetchImages();
    super.onInit();
  }

  void fetchImages() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final newImages = await pixabayService.fetchImages(page);
      images.addAll(newImages);
      page++;
    } catch (e) {
      print('Error fetching images: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
