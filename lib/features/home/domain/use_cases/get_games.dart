import 'package:zema/core/usecases/usecase.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/domain/repositories/game_repository.dart';

class GetGamesUseCase implements UseCase<List<GameEntity>, void> {
  final GameRepository _gameRepository;

  GetGamesUseCase(this._gameRepository);

  @override
  Future<List<GameEntity>> call(void params) async {
    return await _gameRepository.getGames();
  }
}