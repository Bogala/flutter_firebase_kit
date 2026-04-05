// coverage:ignore-file

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../core/core_module.dart';
import 'go_router_refresh_stream.dart';
import 'home/home_page.dart';

@singleton
class AppRouter {
  GoRouter? _goRouter;
  late final ValueNotifier<RoutingConfig> _routingConfiguration;
  late final GoRouterRefreshStream _refreshStream;
  final FirebaseAuth _firebaseAuth;
  final String _fragment = Uri.base.fragment;
  Map<String, String> _params =
      Map.fromEntries(Uri.base.queryParameters.entries);

  Map<String, String> get queryParameters =>
      _params.isNotEmpty ? _params : _toMap(_fragment);

  set queryParameters(Map<String, String> params) {
    _params = params;
  }

  AppRouter(AuthModule authModule) : _firebaseAuth = authModule.firebaseAuth {
    _refreshStream = GoRouterRefreshStream(_firebaseAuth.authStateChanges());
    _routingConfiguration = ValueNotifier<RoutingConfig>(
      RoutingConfig(
        redirect: _redirect,
        routes: <RouteBase>[
          ShellRoute(
            builder: (context, state, child) {
              return child;
            },
            routes: [
              transitionGoRoute(
                path: '/',
                builder: (context, state) => const HomePage(),
              )
            ],
          )
        ],
      ),
    );

    Uri.base.removeFragment();
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = _firebaseAuth.currentUser != null;
    final isOnLogin = state.matchedLocation.startsWith('/login');

    if (!isAuthenticated && !isOnLogin) {
      return '/login';
    }
    if (isAuthenticated && isOnLogin) {
      return '/';
    }
    return null;
  }

  GoRouter initWithRoute(String route) {
    _goRouter = GoRouter.routingConfig(
      routingConfig: _routingConfiguration,
      initialLocation: route,
      refreshListenable: _refreshStream,
    );
    return _goRouter!;
  }

  GoRouter get goRouter {
    _goRouter ??= GoRouter.routingConfig(
      routingConfig: _routingConfiguration,
      refreshListenable: _refreshStream,
    );
    return _goRouter!;
  }

  void addRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) {
    _routingConfiguration.value.routes[0].routes.add(
      transitionGoRoute(
        path: path,
        builder: builder,
      ),
    );
  }

  void go(String path) {
    goRouter.go(path);
  }

  Map<String, String> _toMap(String fragment) {
    var data = fragment
        .split('&')
        .map((e) => e.split('='))
        .map((e) => MapEntry(e.first, e.last));
    return Map.fromEntries(data);
  }

  @disposeMethod
  void dispose() {
    goRouter.dispose();
    _routingConfiguration.dispose();
    _refreshStream.dispose();
  }
}

GoRoute transitionGoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage(
      child: builder(context, state),
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeIn).animate(animation),
          child: child,
        );
      },
    ),
  );
}
