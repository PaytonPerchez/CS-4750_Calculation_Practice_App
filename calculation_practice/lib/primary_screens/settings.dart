import 'package:calculation_practice/primary_screens/templates.dart';
import 'package:calculation_practice/primary_screens/calculator.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        // Precision
        Container(
          child: Column(
            children: [
              Text('Precision'),
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
        ),

        // Text size
        Container(
          child: Column(
            children: [
              Text('Text Size'),
              Text('Aa'),
            ],
          ),
        ),

        // Statistics
        Container(
          child: Column(
            children: [
              Text('Statistics'),
              Text('# of problems generated'),
            ],
          ),
        ),

        // About
        Container(
          child: Column(
            children: [
              Text('About'),
              Text('This is the settings page'),
            ],
          ),
        ),
      ],
    );
  }
}
