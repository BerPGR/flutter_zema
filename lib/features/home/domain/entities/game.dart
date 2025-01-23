import 'package:zema/features/home/data/model/game.dart';

class GameEntity {
  final int? id;
  final String? name;
  final String? storyline;
  final String? imageId;
  
  const GameEntity({
    required this.id,
    required this.name,
    required this.storyline,
    required this.imageId,
  });

  factory GameEntity.fromModel(GameModel gModel) {
    return GameEntity(id: gModel.id, name: gModel.name, storyline: gModel.storyline, imageId: gModel.imageId);
  }
}