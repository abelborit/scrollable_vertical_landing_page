import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "Contact View",
              style: GoogleFonts.montserratAlternates(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
