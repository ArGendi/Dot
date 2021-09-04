import 'package:flutter/material.dart';

import '../constants.dart';

class GoogleFbButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final bool isFb;
  final bool isFBLoading;
  final bool isGoogleLoading;

  const GoogleFbButton({Key? key, required this.text, required this.onClick, required this.isFb, required this.isFBLoading, required this.isGoogleLoading}) : super(key: key);

  @override
  _GoogleFbButtonState createState() => _GoogleFbButtonState();
}

class _GoogleFbButtonState extends State<GoogleFbButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primaryColor)
        ),
        child: Center(
          child: (widget.isFBLoading && widget.isFb) || (widget.isGoogleLoading && !widget.isFb)? CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
                primaryColor),
          ) : Text(
            widget.text,
            style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
