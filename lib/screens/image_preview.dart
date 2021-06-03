import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  static const ROUTE_NAME = "ImagePreview";

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = ModalRoute.of(context).settings.arguments;

    List<Widget> _productImages() {
      List<Widget> images = [];
      for (String imageUrl in imageUrls) {
        images.add(
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      }
      return images;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [Icon(Icons.download_rounded)],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: _productImages(),
          ),
        ),
      ),
    );
  }
}
