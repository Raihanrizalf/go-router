import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          name: 'detil',
          builder: (BuildContext context, GoRouterState state) {
            print(state.pathParameters);
            if (state.extra != null) {
              return DetailsScreen(
                text: state.extra as Data,
                isRoute: false,
              );
            } 
            return const DetailsScreen(
              isRoute: false,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'more-detailed/:code',
              name: 'more-detailed',
              builder: (BuildContext context, GoRouterState state) {
                String? productCode = state.pathParameters['code'];
                print(productCode);
                return MoreDetailedScreen(
                  isRoute: true,
                  productCode: productCode,
                );
              } 
            )
          ]
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true
);