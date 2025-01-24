import 'package:flutter/cupertino.dart';

class AboutGameDetail extends StatelessWidget {
  final String name;
  final String about;
  final List<dynamic> genres;
  const AboutGameDetail(
      {super.key,
      required this.name,
      required this.about,
      required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 18,
      children: [
      Wrap(
        spacing: 12,
        children: [
          for (var genre in genres)
            Text(
              genre["name"],
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            )
        ],
      ),
      Text(
        "About $name",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      Text(
        about,
        style: TextStyle(fontSize: 16),
      ),
    ]);
  }
}
