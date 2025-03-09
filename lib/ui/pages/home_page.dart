import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:scrollable_vertical_landing_page/ui/views/about_view.dart';
import 'package:scrollable_vertical_landing_page/ui/views/contact_view.dart';
import 'package:scrollable_vertical_landing_page/ui/views/home_view.dart';
import 'package:scrollable_vertical_landing_page/ui/views/location_view.dart';
import 'package:scrollable_vertical_landing_page/ui/views/pricing_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: customBoxDecoration(),
        /* el Widget "Stack" para colocar elementos superpuestos, en este caso un menú en la esquina superior derecha */
        child: Stack(
          children: [
            /* NOTA: tener en consideración el orden de los Widget, porque por ejemplo, en este caso se está colocando primero el "_HomeBody" y luego el "Positioned", entonces estará como por encima de ese componente, porque si se colocara al revés entonces el "_HomeBody" estaría por encima de todo */
            /* Se usa el custom widget que implementa el scroll suave */
            const SmoothScrollBody(),

            /* Ejemplo de un widget superpuesto (por ejemplo, menú) */
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                width: 180,
                height: 50,
                color: Colors.black,
                child: const Center(
                  child: Text("Menú", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* para crear una decoración que tenga gradiente en el fondo */
  BoxDecoration customBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.pink, Colors.redAccent],

      /* dónde empieza y dónde termina el gradiente */
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,

      /* puntos de quiebre del gradiente, es decir, qué tanto espacio ocupa de la pantalla, colocando "[0.5, 0.5]" veremos que estarán como colores sólidos y es el efecto que queríamos conseguir para dar la ilusión de que se estira la pantalla tanto en la parte superior como en al parte inferior */
      stops: const [0.5, 0.5],
    ),
  );
}

/* este "SmoothScrollBody" es un custom Widget que implementa scroll suave utilizando SingleChildScrollView y Listener */
class SmoothScrollBody extends StatefulWidget {
  const SmoothScrollBody({super.key});

  @override
  SmoothScrollBodyState createState() => SmoothScrollBodyState();
}

class SmoothScrollBodyState extends State<SmoothScrollBody> {
  final ScrollController _scrollController = ScrollController();
  bool _isAnimating = false;

  /* Función que detecta y maneja el evento de scroll del mouse/trackpad */
  void _onScroll(PointerSignalEvent event) {
    if (_isAnimating) return; // Evita lanzar múltiples animaciones a la vez

    if (event is PointerScrollEvent) {
      _isAnimating = true;
      /* Se multiplica el delta para ajustar la sensibilidad del scroll */
      double newOffset = _scrollController.offset + (event.scrollDelta.dy * 3);
      /* Se asegura que el nuevo offset no se salga del rango permitido */
      newOffset = newOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      _scrollController
          .animateTo(
            newOffset,
            duration: const Duration(milliseconds: 600),
            curve: Curves.decelerate,
          )
          .then((_) {
            _isAnimating =
                false; // Se vuelve a habilitar el scroll una vez terminada la animación
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    /* Se obtiene la altura de la pantalla para que cada vista ocupe una pantalla completa */
    final screenHeight = MediaQuery.of(context).size.height;

    return Listener(
      onPointerSignal: _onScroll,
      child: SingleChildScrollView(
        controller: _scrollController,
        // physics: const ClampingScrollPhysics(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: screenHeight, child: HomeView()),
            SizedBox(height: screenHeight, child: AboutView()),
            SizedBox(height: screenHeight, child: PricingView()),
            SizedBox(height: screenHeight, child: ContactView()),
            SizedBox(height: screenHeight, child: LocationView()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
