import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class RatingStars extends StatelessWidget {
  final int rate;

  const RatingStars({Key key, @required this.rate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(marginSmall),
      child: Row(
        children: [
          Icon(
            rate >= 1 ? Icons.star : Icons.star_outline,
            color: colorPrimaryDark,
          ),
          Icon(
            rate >= 2 ? Icons.star : Icons.star_outline,
            color: colorPrimaryDark,
          ),
          Icon(
            rate >= 3 ? Icons.star : Icons.star_outline,
            color: colorPrimaryDark,
          ),
          Icon(
            rate >= 4 ? Icons.star : Icons.star_outline_outlined,
            color: colorPrimaryDark,
          ),
          Icon(
            rate >= 5 ? Icons.star : Icons.star_outline,
            color: colorPrimaryDark,
          ),
        ],
      ),
    );
  }
}
