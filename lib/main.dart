// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This sample app shows an app with two screens.
///
/// The first route '/' is mapped to [HomeScreen], and the second route
/// '/details' is mapped to [DetailsScreen].
///
/// The buttons use context.go() to navigate to each destination. On mobile
/// devices, each destination is deep-linkable and on the web, can be navigated
/// to using the address bar.
void main() => runApp(const MyApp());

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => 
      FadeTransition(opacity: animation, child: child),
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
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
            Data text = state.extra as Data;
            return DetailsScreen(
              text: text,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'more-detailed',
              name: 'more-detailed',
              builder: (BuildContext context, GoRouterState state) {
                return const MoreDetailedScreen();
              } 
            )
          ]
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android : CupertinoPageTransitionsBuilder()
          }
        )
      ),
    );
  }
}

class Data{
  final String title;
  final String body;

  Data({required this.title, required this.body});

  // Data.fromJson(Map<String, dynamic> json)
  //   : title = json['title'],
  //     body = json['body'];

  // Map<String, dynamic> toJson() => {
  //   'title': title,
  //   'body': body
  // };
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
  Data test = Data(title: 'judul', body: 'Body');
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            return context.go(Uri(path: 'details').toString(), extra: test);
            // return context.go(Uri(path: '/details', queryParameters: {'text': 'halaman details'}).toString());
            // context.goNamed('detil', pathParameters: {'text': 'halaman details'});
          } ,
          child: const Text('Go to the Details screen'),
        ),
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  final Data text;
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async {
        context.go('/');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Details Screen'), backgroundColor: Colors.green),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title : ${text.title}'),
            Text('Body : ${text.body}'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  return context.go('details', extra: text);
                } ,
                child: const Text('Go back to the Home screen'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  return context.goNamed('more-detailed', extra: text);
                } ,
                child: const Text('Go to more detailed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreDetailedScreen extends StatelessWidget {
  const MoreDetailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More Detailed Screen'), backgroundColor: Colors.yellow),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            return context.go('details');
          },
          child: const Text('Go back to the Home screen'),
        )
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print(ModalRoute.of(context)?.settings.name);
            return context.go('/');
          } ,
          child: const Text('Home screen'),
        ),
      ),
    );
  }
}