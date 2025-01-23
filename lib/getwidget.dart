import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Getwidgetscreen extends StatefulWidget {
  @override
  _getwidgetscreenState createState() => _getwidgetscreenState();
}

class _getwidgetscreenState extends State<Getwidgetscreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFButton(
            onPressed: () {},
            text: "WOI",
            size: GFSize.LARGE,
          ),
          GFButtonBadge(
            onPressed: () {},
            icon: GFBadge(
              child: Text("12"),
            ),
            text: 'primary',
          ),
          GFIconBadge(
            child: GFIconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
            counterChild: GFBadge(
              child: Text(""),
            ),
          ),
          GFButton(
            onPressed: () {},
            text: "primary",
            icon: Icon(Icons.share),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {},
            text: "primary",
            icon: Icon(Icons.facebook),
            size: GFSize.MEDIUM,
          ),
        ],
      ),
    );
  }
}
