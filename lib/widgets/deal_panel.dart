import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../constants.dart';

class DealPanel extends StatefulWidget {
  final String dealText;
  final int endTime;
  final VoidCallback seeAll;

  const DealPanel({Key? key, required this.dealText, required this.endTime, required this.seeAll}) : super(key: key);

  @override
  _DealPanelState createState() => _DealPanelState();
}

class _DealPanelState extends State<DealPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dealText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                TextButton(
                  onPressed: widget.seeAll,
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            CountdownTimer(
              endTime: widget.endTime,
              textStyle: TextStyle(
                  color: Colors.white
              ),
              endWidget: Text(
                'Deal ends',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
