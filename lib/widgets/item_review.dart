import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/review.dart';
import 'package:organik/widgets/rating_stars.dart';

class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        marginStandard,
      ),
      margin: const EdgeInsets.all(
        marginSmall,
      ),
      decoration: BoxDecoration(
        color: colorPrimaryLight,
        borderRadius: BorderRadius.all(
          Radius.circular(
            radiusStandard,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorBgLight,
                ),
                child: review.imageUrl != null
                    ? Image.network(
                        review.imageUrl,
                      )
                    : Icon(
                        Icons.person,
                        color: colorPrimary,
                      ),
              ),
              SizedBox(
                width: marginStandard,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        review.reviewerId.substring(0, 10),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: colorPrimaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeStandard,
                        ),
                      ),
                    ),
                    RatingStars(
                      rate: review.rate,
                    ),
                  ],
                ),
              ),
              Text(
                "null",
                style: TextStyle(
                  color: colorPrimaryDark,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(marginStandard),
            child: Text(
              review.text,
              style: TextStyle(
                color: colorPrimaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
