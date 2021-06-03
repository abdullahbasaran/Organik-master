import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class ProductGridItem extends StatelessWidget {
  final Function onTap;
  final Function onActionTap;
  final String image;
  final bool editIconEnabled;
  final bool isFavorite;
  final bool isLoading;

  ProductGridItem({
    @required this.image,
    @required this.onTap,
    this.onActionTap,
    this.editIconEnabled = false,
    this.isFavorite = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    // final _width = _size.width / 2 - marginStandard * 2;

    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radiusStandard),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          // width: _width,
          // height: _width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(radiusStandard),
            ),
            color: colorPrimaryLight,
          ),
          child: Stack(
            children: [
              Container(
                //product image container
                width: double.infinity,
                height: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image != null ? image : null,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Positioned(
                //action icon container
                right: marginStandard,
                bottom: marginStandard,
                child: InkWell(
                  onTap: onActionTap,
                  child: Container(
                    width: 25,
                    height: 25,
                    child: editIconEnabled
                        ? Icon(
                            Icons.edit,
                            color: colorPrimaryLight,
                          )
                        : isLoading
                            ? CircularProgressIndicator()
                            : isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: colorPrimaryDark,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: colorBgLight,
                                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
