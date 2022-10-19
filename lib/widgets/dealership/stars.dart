import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class stars extends StatelessWidget {
  const stars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.all(8),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amberAccent,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
