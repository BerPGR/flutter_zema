import 'package:zema/features/home/data/model/game.dart';

class GameEntity {
  final int? id;
  final String? name;
  final String? storyline;
  final String? summary;
  final String? imageId;
  final List<dynamic>? genres;
  final List<dynamic>? platforms;
  final String? screenshot;
  final double? rating;

  const GameEntity(
      {required this.id,
      required this.name,
      required this.storyline,
      required this.imageId,
      required this.summary,
      required this.genres,
      required this.platforms,
      required this.screenshot, required this.rating});

  factory GameEntity.fromModel(GameModel gModel) {
    return GameEntity(
        id: gModel.id,
        name: gModel.name,
        storyline: gModel.storyline,
        imageId: gModel.imageId,
        summary: gModel.summary,
        genres: gModel.genres,
        platforms: gModel.platforms,
        screenshot: gModel.screenshot,
        rating: gModel.rating);
  }
}
