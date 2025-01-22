import 'package:zema/features/home/data/model/game.dart';

class GameEntity {
  final String id;
  final String name;
  final String storyline;
  final String cover;
  
  const GameEntity({
    required this.id,
    required this.name,
    required this.storyline,
    required this.cover,
  });

  factory GameEntity.fromModel(GameModel gModel) {
    return GameEntity(id: gModel.id, name: gModel.name, storyline: gModel.storyline, cover: gModel.cover);
  }
}