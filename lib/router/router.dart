import 'package:go_router/go_router.dart';
import 'package:skillwave/feature/course/screens/dashboard_screen.dart';
import 'package:skillwave/feature/profile/profile.dart';
import 'package:skillwave/feature/profile/update_profile/update_profile.dart';
import 'package:skillwave/router/domain/model_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: SkillWaveRouter.initial,
    routes: [
      GoRoute(
        path: SkillWaveRouter.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: SkillWaveRouter.profile,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: SkillWaveRouter.update_profile,
        builder: (context, state) => const UpdateProfileScreen(),
      ),
    ],
  );
}
