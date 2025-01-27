import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zema/features/game_details/data/datasources/remote_comment_data_source.dart';
import 'package:zema/features/game_details/data/repositories/comment_repository_impl.dart';
import 'package:zema/features/game_details/domain/respositories/comment_repository.dart';
import 'package:zema/features/game_details/domain/usecases/add_comment.dart';
import 'package:zema/features/game_details/domain/usecases/load_comments.dart';
import 'package:zema/features/game_details/presentation/bloc/details_bloc.dart';
import 'package:zema/features/home/data/data_source/remote_game_data_source.dart';
import 'package:zema/features/home/data/repositories/game_repository_impl.dart';
import 'package:zema/features/home/domain/repositories/game_repository.dart';
import 'package:zema/features/home/domain/use_cases/get_games.dart';
import 'package:zema/features/home/domain/use_cases/search_games.dart';
import 'package:zema/features/home/domain/use_cases/top_reviews.dart';
import 'package:zema/features/home/presentation/bloc/home_bloc.dart';
import 'package:zema/features/profile/data/data_source/remote_user_comments_ds.dart';
import 'package:zema/features/profile/data/repositories/user_comments_repository_impl.dart';
import 'package:zema/features/profile/domain/repositories/user_comments_repository.dart';
import 'package:zema/features/profile/domain/use_cases/get_user_comments.dart';
import 'package:zema/features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  // Home Injection
  sl.registerSingleton<RemoteGameDataSource>(RemoteGameDataSource(sl()));
  sl.registerSingleton<GameRepository>(GameRepositoryImpl(sl()));
  sl.registerSingleton<SearchGamesUseCase>(SearchGamesUseCase(sl()));
  sl.registerSingleton<TopReviewsUseCase>(TopReviewsUseCase(sl()));
  sl.registerSingleton<GetGamesUseCase>(GetGamesUseCase(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl(), sl()));



  // Details Injection
  sl.registerSingleton<RemoteCommentDataSource>(RemoteCommentDataSource(sl()));
  sl.registerSingleton<CommentRepository>(CommentRepositoryImpl(sl()));
  sl.registerSingleton<LoadCommentsUseCase>(LoadCommentsUseCase(sl()));
  sl.registerSingleton<AddCommentUseCase>(AddCommentUseCase(sl()));
  sl.registerFactory<DetailsBloc>(() => DetailsBloc(sl(), sl()));

  //Profile Injection
  sl.registerSingleton<RemoteUserCommentsDataSource>(RemoteUserCommentsDataSource(sl()));
  sl.registerSingleton<UserCommentsRepository>(UserCommentsRepositoryImpl(sl()));
  sl.registerSingleton<GetUserCommentsUseCase>(GetUserCommentsUseCase(sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
}