import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/core/service/firebase.dart';
import 'package:zema/features/game_details/presentation/pages/add_comment_page.dart';
import 'package:zema/features/game_details/presentation/pages/game_details_page.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/presentation/pages/home_page.dart';
import 'package:zema/features/login/presentation/pages/login_page.dart';
import 'package:zema/features/login/presentation/pages/onboarding.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final firebaseService = AuthService();
    final user = firebaseService.currentUser;
    final isLoggedIn = user != null;
    final isGoingToLogin = state.uri.toString() == '/login';
    final isGoingToOnboarding = state.uri.toString() == '/onboarding';

    // Verifica se o usuário precisa passar pelo onboarding
    final needsOnboarding = isLoggedIn && user.metadata.creationTime!.second < user.metadata.lastSignInTime!.second;

    if (!isLoggedIn && !isGoingToLogin) {
      // Redireciona para a tela de login se não estiver autenticado
      return '/login';
    } else if (isLoggedIn && !needsOnboarding && isGoingToOnboarding) {
      // Evita o onboarding para usuários já registrados
      return '/';
    } else if (needsOnboarding && !isGoingToOnboarding) {
      // Redireciona para a página de onboarding se for um novo usuário
      return '/onboarding';
    }

    // Mantém a rota atual
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final GameEntity game = state.extra as GameEntity;
        return GameDetailsPage(game: game);
      },
    ),
    GoRoute(
      path: '/addcomment',
      builder: (context, state) {
        final id = state.extra as int;
        return AddCommentPage(gameId: id);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingPage(),
    ),
  ],
);