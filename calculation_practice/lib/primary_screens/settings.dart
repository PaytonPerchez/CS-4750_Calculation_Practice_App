import 'package:flutter/material.dart';
import 'package:calculation_practice/styles/Styles.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  TextStyle _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /*// Precision
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: Text('Precision'),

                ),
                Text('22/7 = 3.141285714'),
              ],
            ),
          ),

          // Color scheme
          Container(
            child: Column(
              children: [
                Text('Color Scheme'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      child: Icon(Icons.crop_square),
                      onPressed: null,
                    ),
                    OutlinedButton(
                      child: Icon(Icons.crop_square),
                      onPressed: null,
                    ),
                  ],
                ),
              ],
            ),
          ),*/

          // Text size
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'Text Size',
                  style: Styles.headerStyles,
                ),
                Text(
                  'Aa',
                  style: Styles.bodyStyle,
                ),
              ],
            ),
          ),

          Expanded(flex: 1, child: Text('')),

          // About
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'About',
                  style: Styles.headerStyles,
                ),
                Text(
                  'This is the settings page',
                  style: Styles.bodyStyle,
                ),
              ],
            ),
          ),
          Expanded(flex: 8, child: Text('')),
        ],
      ),
    );
  }
}
