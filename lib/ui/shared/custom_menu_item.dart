import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMenuItem extends StatefulWidget {
  /* recibirá las props de text y onPressed desde el componente padre */
  final String text;
  final Function onPressed;

  /* se colocan en el constructor las props que vienen desde el componente padre */
  const CustomMenuItem({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<CustomMenuItem> createState() => _CustomMenuItemState();
}

class _CustomMenuItemState extends State<CustomMenuItem> {
  /* estado interno para manejar el hover del item */
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter:
          (event) => setState(() {
            isHover = true;
          }),
      onExit:
          (event) => setState(() {
            isHover = false;
          }),
      child: GestureDetector(
        /* colocando "widget.onPressed()" es para hacer referencia a la función que se está recibiendo del padre */
        onTap: () => widget.onPressed(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 150,
          height: 50,
          color: isHover ? Colors.blueAccent : Colors.black,
          child: Center(
            child: Text(
              widget.text,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
