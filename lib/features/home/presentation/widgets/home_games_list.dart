import 'package:flutter/material.dart';
import 'package:zema/features/home/domain/entities/game.dart';

class HomeGamesList extends StatelessWidget {
  final List<GameEntity> games;
  const HomeGamesList({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://images.igdb.com/igdb/image/upload/t_1080p/${game.imageId}.jpg",
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      game.name!,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(game.storyline != "" ? game.storyline! : game.summary!,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
