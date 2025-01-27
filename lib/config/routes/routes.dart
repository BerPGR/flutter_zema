import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zema/core/service/firebase.dart';
import 'package:zema/features/game_details/presentation/pages/add_comment_page.dart';
import 'package:zema/features/game_details/presentation/pages/game_details_page.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/presentation/pages/home_page.dart';
import 'package:zema/features/login/presentation/pages/login_page.dart';
import 'package:zema/features/login/presentation/pages/onboarding.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final firebaseService = AuthService();
    final user = firebaseService.currentUser;
    final isLoggedIn = user != null;
    final firstTimeLogin = prefs.getBool("first_time_login");
    final isGoingToLogin = state.uri.toString() == '/login';
    final isGoingToOnboarding = state.uri.toString() == '/onboarding';

    final needsOnboarding = isLoggedIn && (firstTimeLogin != null && firstTimeLogin);

    if (!isLoggedIn && !isGoingToLogin) {
      return '/login';
    } else if (isLoggedIn && !needsOnboarding && isGoingToOnboarding) {
      return '/';
    } else if (needsOnboarding && isGoingToOnboarding) {
      return '/onboarding';
    }

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