
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/utility.dart';

class CLoadImage extends StatelessWidget {
  String? imageUrl;
  bool? isProduct;
  double? width;
  double? height;

  CLoadImage({required this.imageUrl, this.isProduct, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$imageUrl",
      httpHeaders: <String, String>{'authorization': getBasicAuth()},
      fit: BoxFit.cover,
      width: width,
      height: height,
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(height != null ? 25 : 4),
        child: PlaceholderImage(),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: EdgeInsets.all(height != null ? 25 : 4),
        child: PlaceholderImage(),
      ),
    );
  }
}


class CAssetImage extends StatelessWidget {
  Color? imageColor;
  double? height;
  String? imagePath;

  CAssetImage({required this.imagePath, this.imageColor, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$imagePath',
      color: imageColor,
      height: height,
    );
  }
}

class PlaceholderImage extends StatelessWidget {
  bool? whiteImage;
  double? height;

  PlaceholderImage({this.whiteImage, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: const Icon(
          Icons.image_outlined,
          size: 30,
          color: Colors.grey,
        ));

    Image.asset(
      'assets/images/ic_placeholder.jpg',
      height: height,
    );
  }
}


