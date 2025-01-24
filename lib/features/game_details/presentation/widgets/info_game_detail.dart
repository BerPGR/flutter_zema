import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class InfoGameDetail extends StatelessWidget {
  final double stars;
  final double rating;
  final List<dynamic> platforms;
  const InfoGameDetail(
      {super.key,
      required this.stars,
      required this.rating,
      required this.platforms});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall rating",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            StarRating(
              rating: stars,
              allowHalfRating: false,
              color: Theme.of(context).primaryColor,
              borderColor: Colors.grey.shade800,
            )
          ],
        ),
        Flexible(
          child: Wrap(
            spacing: 12,
            alignment: WrapAlignment.end,
            children: [
              for (var platform in platforms)
                Chip(label: Text("${platform["abbreviation"]}"))
            ],
          ),
        ),
      ],
    );
  }
}
