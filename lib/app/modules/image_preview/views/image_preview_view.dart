import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/utility.dart';
import '../../components/progress_bar.dart';
import '../controllers/image_preview_controller.dart';

class ImagePreviewView extends GetView<ImagePreviewController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePreviewController>(
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black,
              appBar: AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
              ),
              body: Center(
                child: SizedBox(
                  height: getMaxHeight(context),
                  width: getMaxWidth(context),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    child: CachedNetworkImage(
                      placeholder: (_, s) => CProgressBar(
                        color: Colors.white,
                      ),
                      imageUrl: "${controller.imageUrl}",
                      httpHeaders: {"Authorization": getBasicAuth()},
                    ),
                  ),
                ),
              ),
            ));
  }
}
