import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({Key? key, required this.message, required this.sender}) : super(key: key);

  final message, sender;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff383737),
      padding: const EdgeInsets.only(left: 5.0, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( padding: const EdgeInsets.only(right: 4),
          child: CircleAvatar(
              backgroundColor: sender=="Kullanıcı"?Colors.green:Colors.red,
              child: Text(sender[0],
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(sender, style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.white24), ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(message, style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.white),),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
