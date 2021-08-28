import 'package:flutter/material.dart';

import '../constants.dart';

class SubscribePanel extends StatefulWidget {
  final VoidCallback onclick;

  const SubscribePanel({Key? key, required this.onclick}) : super(key: key);

  @override
  _SubscribePanelState createState() => _SubscribePanelState();
}

class _SubscribePanelState extends State<SubscribePanel> {
  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains))
        return primaryColor;
      return Colors.white;
    }

    return Container(
      width: double.infinity,
      height: 80,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isSubscribed,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  checkColor: Colors.white,
                  activeColor: Colors.white,
                  onChanged: (value){
                    setState(() {
                      isSubscribed = !isSubscribed;
                    });
                  },
                ),
                SizedBox(width: 5,),
                Text(
                  'Subscribe to newsletter',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: widget.onclick,
              child: Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
