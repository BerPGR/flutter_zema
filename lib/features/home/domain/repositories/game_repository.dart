import 'package:zema/features/home/domain/entities/game.dart';

abstract class GameRepository {

  Future<List<GameEntity>> getGames();
  Future<List<GameEntity>> searchGames(String query);
  Future<List<GameEntity>> topReviews();
}