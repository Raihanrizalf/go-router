import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ScaffoldType{
  android,
  ios
}

class BoronganScaffold extends StatelessWidget {
  final Future<bool> Function()? onWillPop;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  
  const BoronganScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.onWillPop
  }) : assert(primary != null),
       assert(extendBody != null),
       assert(extendBodyBehindAppBar != null),
       assert(drawerDragStartBehavior != null);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return WillPopScope(
        onWillPop: onWillPop ?? () async {
          if (!ModalRoute.of(context)!.isFirst) {
            return true;
          }
          SystemNavigator.pop();
          return false;
          // Navigator.pop(context);
          // return false;
        },
        child: Scaffold(
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          drawer: drawer,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          drawerScrimColor: drawerScrimColor,
          endDrawer: endDrawer,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          floatingActionButtonLocation: floatingActionButtonLocation,
          key: key,
          onDrawerChanged: onDrawerChanged,
          onEndDrawerChanged: onEndDrawerChanged,
          persistentFooterAlignment: persistentFooterAlignment,
          persistentFooterButtons: persistentFooterButtons,
          primary: primary,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          restorationId: restorationId,  
        )
      );
    } else {
      if (onWillPop != null) {
        return WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            appBar: appBar,
            backgroundColor: backgroundColor,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
            bottomSheet: bottomSheet,
            drawer: drawer,
            drawerDragStartBehavior: drawerDragStartBehavior,
            drawerEdgeDragWidth: drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
            drawerScrimColor: drawerScrimColor,
            endDrawer: endDrawer,
            endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            floatingActionButtonLocation: floatingActionButtonLocation,
            key: key,
            onDrawerChanged: onDrawerChanged,
            onEndDrawerChanged: onEndDrawerChanged,
            persistentFooterAlignment: persistentFooterAlignment,
            persistentFooterButtons: persistentFooterButtons,
            primary: primary,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            restorationId: restorationId,
          ),
        );
      } else {
        return Scaffold(
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          drawer: drawer,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          drawerScrimColor: drawerScrimColor,
          endDrawer: endDrawer,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          floatingActionButtonLocation: floatingActionButtonLocation,
          key: key,
          onDrawerChanged: onDrawerChanged,
          onEndDrawerChanged: onEndDrawerChanged,
          persistentFooterAlignment: persistentFooterAlignment,
          persistentFooterButtons: persistentFooterButtons,
          primary: primary,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          restorationId: restorationId,
        );
      }
    }

    // switch (type) {
    //   case ScaffoldType.android:
    //     return WillPopScope(
    //       onWillPop: () async {
    //         Navigator.pop(context);
    //         return false;
    //       },
    //       child: Scaffold(body: body)
    //     );
    //   case ScaffoldType.ios:
    //     return Scaffold(
    //       body: body
    //     );
    // }
  }
}