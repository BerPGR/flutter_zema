import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zema/features/home/data/data_source/remote_game_data_source.dart';
import 'package:zema/features/home/data/repositories/game_repository_impl.dart';
import 'package:zema/features/home/domain/repositories/game_repository.dart';
import 'package:zema/features/home/domain/use_cases/get_games.dart';
import 'package:zema/features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<RemoteGameDataSource>(RemoteGameDataSource(sl()));
  sl.registerSingleton<GameRepository>(GameRepositoryImpl(sl()));
  sl.registerSingleton<GetGamesUseCase>(GetGamesUseCase(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
}