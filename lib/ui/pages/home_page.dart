import 'package:flutter/material.dart';
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
            _HomeBody(),

            Positioned(
              right: 20,
              top: 20,
              child: Container(width: 180, height: 50, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  /* para crear un gradiente en el fondo */
  BoxDecoration customBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.pink, Colors.redAccent],

      /* dónde empieza y dónde termina el gradiente */
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,

      /* puntos de quiebre del gradiente, es decir, qué tanto espacio ocupa de la pantalla, colocando "[0.5, 0.5]" veremos que estarán como colores sólidos y es el efecto que queríamos conseguir para dar la ilusión de que se estira la pantalla tanto en la parte superior como en al parte inferior */
      stops: [0.5, 0.5],
    ),
  );
}

/* este "_HomeBody" estará como privado porque no queremos que se pueda usar fuera de este archivo, solo estamos separando la lógica para dividir responsabilidades y mejorar la legibilidad */
class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        HomeView(),
        AboutView(),
        PricingView(),
        ContactView(),
        LocationView(),
      ],
    );
  }
}
