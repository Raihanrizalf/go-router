// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_router/product_provider.dart';
import 'package:flutter_go_router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

/// This sample app shows an app with two screens.
///
/// The first route '/' is mapped to [HomeScreen], and the second route
/// '/details' is mapped to [DetailsScreen].
///
/// The buttons use context.go() to navigate to each destination. On mobile
/// devices, each destination is deep-linkable and on the web, can be navigated
/// to using the address bar.
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Product())
      ],
      child: const MyApp(),
    )
  );
  initUiLinks();
} 

void initUiLinks() {
  uriLinkStream.listen((event) 
    {
      print(event);
      
    }
  );
}


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

/// The main app.
class MyApp extends StatefulWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                return context.go(Uri(path: '/details').toString(), extra: test);
                // return context.go(Uri(path: '/details', queryParameters: {'text': 'halaman details'}).toString());
                // context.goNamed('detil', pathParameters: {'text': 'halaman details'});
              } ,
              child: const Text('Go to the Details screen'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // return context.go(Uri(path: '/details').toString(), extra: test);
                // return context.go(Uri(path: '/details', queryParameters: {'text': 'halaman details'}).toString());
                // context.goNamed('detil', pathParameters: {'text': 'halaman details'});
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                    return DetailsScreen(isRoute: false);
                  },));
              } ,
              child: const Text('Go to details using Navigator'),
            ),
          ),
        ],
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  final bool isRoute;
  final Data? text;
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key, this.text, required this.isRoute});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async {
        Navigator.pop(context);
        // if (isRoute) {
        //   context.go('/');
        // } else {
        //   Navigator.pop(context);
        // }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Details Screen'), backgroundColor: Colors.green),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title : ${text?.title}'),
            Text('Body : ${text?.body}'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  return context.go('/', extra: text);
                } ,
                child: const Text('Go back to the Home screen'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // return context.goNamed('more-detailed', extra: text);
                  return context.go('/details/more-detailed/null', extra: text);
                } ,
                child: const Text('Go to more detailed'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // return context.goNamed('more-detailed', extra: text);
                  // return context.go('/details/more-detailed/null', extra: text);
                  Navigator.push(context, CupertinoPageRoute(builder: (context) {
                    return MoreDetailedScreen(isRoute: false);
                  },));
                } ,
                child: const Text('Go Navigator'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreDetailedScreen extends StatefulWidget {
  final String? productCode;
  final bool isRoute;

  const MoreDetailedScreen({super.key, this.productCode, required this.isRoute});

  @override
  State<MoreDetailedScreen> createState() => _MoreDetailedScreenState();
}

class _MoreDetailedScreenState extends State<MoreDetailedScreen> {
  String? productCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productCode = widget.productCode;
    if (productCode == null) {
      getProductCode();
    }
    setState(() {});
  }

  getProductCode() {
    var product = context.read<Product>();
    productCode = product.productCode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More Detailed Screen'), backgroundColor: Colors.amber),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Product Code : $productCode'),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (widget.isRoute) return context.go('/details');
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            )
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return MoreMorePage();
                },));
              },
              child: const Text('More More'),
            )
          ),
        ],
      ),
    );
  }
}

class MoreMorePage extends StatelessWidget {
  const MoreMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More Detailed Screen'), backgroundColor: Colors.red),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('More More Page'),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // if (widget.isRoute) return context.go('/details');
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            )
          ),
        ],
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