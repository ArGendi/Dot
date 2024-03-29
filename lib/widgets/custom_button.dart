import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onclick;
  final bool isLoading;

  const CustomButton({Key? key, required this.text, required this.onclick, this.isLoading = false}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onclick,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Center(
                child: widget.isLoading ? CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white),
                ) : Text(
                  widget.text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
