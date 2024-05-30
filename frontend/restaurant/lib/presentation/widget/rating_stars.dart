import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final Color color;
  final double size;

  const RatingStars(
      {super.key, this.rating = 0, this.color = Colors.orange, this.size = 30});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData starIcon = i >= rating ? Icons.star_border : Icons.star;
      stars.add(
        Icon(
          starIcon,
          color: color,
          size: size,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }
}
