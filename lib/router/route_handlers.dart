import 'package:fluro/fluro.dart';
import 'package:scrollable_vertical_landing_page/ui/pages/home_page.dart';

final homeHandler = Handler(
  handlerFunc: (buildContext, params) {
    return HomePage();
  },
);
