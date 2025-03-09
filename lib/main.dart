
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scrollable_vertical_landing_page/router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /* esta es otra configuración al usar el sistema de rutas teniendo un "StatefulWidget" que es colocando en el "initState". Es un poco diferente a la configuración de cuando se usa un "StatelessWidget" en el proyecto de "flutter_web_bases" */
  @override
  void initState() {
    super.initState();
    RouterWithFluro.configureRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Scrollable Vertical Landing Page App',
      initialRoute: "/home",

      /* FORMA 1: usando Fluro */
      // onGenerateRoute: (routeSettings) => RouterWithFluro.router.generator(routeSettings),
      onGenerateRoute: RouterWithFluro.router.generator,
    );
  }
}

/* Para que se pueda hacer Scroll en Flutter Web con PageView: https://stackoverflow.com/questions/69424933/flutter-pageview-not-swipeable-on-web-desktop-mode */
/*  */
class _AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}
