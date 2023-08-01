// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_go_router/common.dart';
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
    const MyApp()
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
      theme: Platform.isAndroid ? ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android : CupertinoPageTransitionsBuilder()
          }
        )
      ) : ThemeData(),
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
class HomeScreen extends StatefulWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    log('iniHome');
  }

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
    return BoronganScaffold(
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
      appBar: AppBar(title: const Text('More More Screen'), backgroundColor: Colors.red),
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                // if (widget.isRoute) return context.go('/details');
                context.go('/');
              },
              child: const Text('Go Home'),
            )
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // if (widget.isRoute) return context.go('/details');
                context.goNamed('transaksi');
              },
              child: const Text('Go Trans'),
            )
          ),
        ],
      ),
    );
  }
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   quitApp();
  // }

  // quitApp() {
  //   return SystemNavigator.pop();
  // }

  @override
  Widget build(BuildContext context) {
    return BoronganScaffold(
      appBar: AppBar(title: Text('Ini beda dunia')),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ini halaman transaksi')
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
                                            // pas bnget 300

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_go_router/pages.dart';

// class CustomData{
//   final String title;
//   final String body;

//   CustomData({required this.title, required this.body});
// }

// // class AppState with ChangeNotifier{
// //   List<Page> pages = [];

// //   CupertinoPage createPage() {
// //     return CupertinoPage(
// //       key: ValueKey(value),
// //       child: child
// //     );
// //   }
// // }

// void main () {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Page> _pages = [];

//   @override
//   void initState() {
//     super.initState();
//     _pages = [_homePage()];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Navigator(
//         pages: _pages,
//         onPopPage: (route, result) {
//           if (route.didPop(result)) {
//             _pages.removeLast();
//             return true;
//           }
//           return false;
//         },
//       )
//     );
//   }

//   Page _homePage () {
//     return CupertinoPage(
//       key: ValueKey('HomeScreen'),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Home Screen'),
//           backgroundColor: Colors.green,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _pages.add(_eventPage(CustomData(title: 'Produk', body: 'Detail')));
//                     _pages = _pages.toList();
//                   });
//                 }, 
//                 child: Text('Pindah')
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Page _eventPage (CustomData data) {
//     return CupertinoPage(
//       allowSnapshotting: false,
//       key: ValueKey('EventScreen'),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Event Screen'),
//           backgroundColor: Colors.green,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Passed data : ${data.title} & ${data.body}'),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   _pages.removeLast();
//                   _pages = _pages.toList();
//                   setState(() {});
//                 }, 
//                 child: Text('Balik')
//               ),
//             )
//           ],
//         ),
//       )
//     );
//   }
// }

// // class Event extends StatefulWidget {
// //   final String data;
  
// //   const Event({super.key, required this.data});

// //   @override
// //   State<Event> createState() => _EventState();
// // }

// // class _EventState extends State<Event> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Event Screen'),
// //         backgroundColor: Colors.green,
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text('Passed data : ${widget.data}'),
// //           Center(
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 _pages.removeLast();
// //                 _pages = _pages.toList();
// //                 setState(() {});
// //               }, 
// //               child: Text('Balik')
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {}, 
//               child: Text('Pindah')
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class EventScreen extends StatelessWidget {
//   const EventScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Screen'),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {}, 
//               child: Text('Pindah')
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }