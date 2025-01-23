import 'package:zema/core/usecases/usecase.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/domain/repositories/game_repository.dart';

class SearchGamesUseCase implements UseCase<List<GameEntity>, String> {
  final GameRepository _gameRepository;

  SearchGamesUseCase(this._gameRepository);

  @override
  Future<List<GameEntity>> call(String query) async {
    return await _gameRepository.searchGames(query);
  }
}
