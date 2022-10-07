// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Txt extends StatelessWidget {
  final String txt;
  final Color clr;
  final double size;
  Txt(this.txt, this.clr, this.size);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.poppins(
          fontSize: size, fontWeight: FontWeight.w300, color: clr),
    );
  }
}
