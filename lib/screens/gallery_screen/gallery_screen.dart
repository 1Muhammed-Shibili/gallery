import 'package:flutter/material.dart';
import 'package:gallery/controllers/gallery_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryPage extends StatelessWidget {
  final GalleryController controller = Get.put(GalleryController());

  GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Gallery',
          style: GoogleFonts.hedvigLettersSans(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.images.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (!controller.isLoading.value && controller.images.isEmpty) {
          return Center(child: Text('No images found or failed to load.'));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !controller.isLoading.value) {
              controller.fetchImages();
            }
            return false;
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).size.width ~/ 150).toInt(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: controller.images.length,
            itemBuilder: (context, index) {
              final image = controller.images[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      image.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Likes: ${image.likes}, Views: ${image.views}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.akatab(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
