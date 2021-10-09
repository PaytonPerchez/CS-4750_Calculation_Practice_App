import 'package:flutter/material.dart';

class TemplatePage extends StatefulWidget {
  TemplatePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            OutlinedButton(
              child: Text('Custom'),
              onPressed: null,
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              child: Text('+, -'),
              onPressed: () {
                Navigator.of(context).pushNamed('/addSub');
              },
            ),
            OutlinedButton(
              child: Text('*, /'),
              onPressed: () {
                Navigator.of(context).pushNamed('/multDiv');
              },
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              child: Text('root, ^'),
              onPressed: () {
                Navigator.of(context).pushNamed('/rootPow');
              },
            ),
            OutlinedButton(
              child: Text('trig, log'),
              onPressed: () {
                Navigator.of(context).pushNamed('/trigLog');
              },
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              child: Text('sum, !'),
              onPressed: () {
                Navigator.of(context).pushNamed('/sumFac');
              },
            ),
            OutlinedButton(
              child: Text('deriv, int'),
              onPressed: () {
                Navigator.of(context).pushNamed('/derivInt');
              },
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              child: Text('nCr, nPr'),
              onPressed: null,
            ),
            OutlinedButton(
              child: Text('rand'),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }
}
