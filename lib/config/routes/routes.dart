import 'package:go_router/go_router.dart';
import 'package:zema/features/game_details/presentation/pages/add_comment_page.dart';
import 'package:zema/features/game_details/presentation/pages/game_details_page.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/presentation/pages/home_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(path: '/details',
    builder: (context, state) {
      final GameEntity game = state.extra as GameEntity;
      return GameDetailsPage(game: game);
    }
  ),
  GoRoute(path: "/addcomment",
  builder: (context, state) {
    final id = state.extra as int;
    return AddCommentPage(gameId: id);
  }
  ),
]);