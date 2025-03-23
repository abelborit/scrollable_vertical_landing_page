import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppMenu extends StatefulWidget {
  const CustomAppMenu({super.key});

  @override
  State<CustomAppMenu> createState() => _CustomAppMenuState();
}

class _CustomAppMenuState extends State<CustomAppMenu>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  /* el "late" es como decir que "ya eventualmente lo voy a inicializar" es para que no de error porque no puede ser un null porque lo inicializaremos después aún en el initState */
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    /* inicializar el controller con el "AnimationController" y necesita el "vertical sync" que es para sincronizarlo con el widget y el estado y para eso tenemos que colocar el "with SingleTickerProviderStateMixin"  */
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  void _handleToggleMenu() {
    // print("click");

    if (isOpen) {
      controller.reverse();
    } else {
      controller.forward();
    }

    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* "MouseRegion" -> Creates a widget that forwards mouse events to callbacks. Se puede saber cuándo el mouse entra, cuándo sale, cuando se haga hover, hacer configuraciones como cambiar el cursor, etc */
    return MouseRegion(
      /* para colocarle manualmente el ícono del botón (si fuera un botón ya automáticamente le colocaría ese ícono) */
      cursor: SystemMouseCursors.click,
      /* "GestureDetector" -> Creates a widget that detects gestures. */
      child: GestureDetector(
        onTap: _handleToggleMenu,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(100),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              /* el AnimatedContainer es como un Container solo que ahora tiene las propiedades para realizar animación. Se está colocando un espacio animado que aparece al abrir */
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                width: isOpen ? 50 : 0,
              ),
              Text(
                "Menu",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: controller,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    /* El método dispose() en Flutter se utiliza para limpiar y liberar recursos cuando un StatefulWidget deja de estar en uso. Libera la memoria utilizada por el AnimationController. Evita fugas de memoria (memory leaks), lo que es crucial en widgets que usan animaciones o controladores de eventos. */
    /* ¿Qué pasa si no lo usamos? -> Si el AnimationController sigue existiendo después de que el widget se elimina, puede seguir consumiendo recursos innecesariamente. Esto podría llevar a fugas de memoria y afectar el rendimiento de la app. */
    controller.dispose();

    /* Llama al método dispose() de la clase base (State), asegurando que cualquier limpieza adicional en la jerarquía de Flutter se realice correctamente. */
    super.dispose();
  }
}
