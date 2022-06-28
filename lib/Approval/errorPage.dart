import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApprovalError extends StatefulWidget {
  const ApprovalError({Key? key}) : super(key: key);

  @override
  State<ApprovalError> createState() => _ApprovalErrorState();
}

class _ApprovalErrorState extends State<ApprovalError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nodata.jpg',
              ),
              Text(
                'There are no Approvals ',
                style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              Text(
                'Check agaain later or create new one',
                style: GoogleFonts.poppins(color: Colors.black45, fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }
}
