import 'package:zema/features/home/data/data_source/remote_game_data_source.dart';
import 'package:zema/features/home/data/model/game.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final RemoteGameDataSource _gameDataSource;

  GameRepositoryImpl(this._gameDataSource);

  @override
  Future<List<GameEntity>> getGames() async {
    try {
      final List<GameModel> games = await _gameDataSource.fetchGames();
      return games.map((game) => GameEntity.fromModel(game)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<GameEntity>> searchGames(String query) async {
    try {
      final List<GameModel> games = await _gameDataSource.searchGames(query);
      return games.map((game) => GameEntity.fromModel(game)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<GameEntity>> topReviews() async {
    try {
      final List<GameModel> games = await _gameDataSource.topReviewGames();
      return games.map((game) => GameEntity.fromModel(game)).toList();
    } catch (e) {
      return [];
    }
  }
}
