import 'package:fluro/fluro.dart';
import 'package:scrollable_vertical_landing_page/router/route_handlers.dart';

class RouterWithFluro {
  /* no es necesario colocar "new FluroRouter()" sino solo "FluroRouter()" */
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    /* Routes */
    router.define(
      "/:page",
      handler: homeHandler,
      transitionType: TransitionType.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
    );

    /* 404 - Page Not Found */
    router.notFoundHandler = homeHandler;
  }
}
