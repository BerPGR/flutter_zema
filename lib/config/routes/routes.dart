import 'package:go_router/go_router.dart';
import 'package:zema/features/home/presentation/pages/home_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/',
    builder: (context, state) => HomePage(),
  ),
]);