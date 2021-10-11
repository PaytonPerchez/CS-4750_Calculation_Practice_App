import 'package:calculation_practice/primary_screens/templates.dart';
import 'package:calculation_practice/primary_screens/calculator.dart';
import 'package:calculation_practice/primary_screens/settings.dart';
import 'package:calculation_practice/template_screens/root_and_pow.dart';
import 'package:calculation_practice/template_screens/add_and_sub.dart';
import 'package:calculation_practice/template_screens/mult_and_div.dart';
import 'package:calculation_practice/template_screens/trig_and_logs.dart';
import 'package:calculation_practice/template_screens/sums_and_facts.dart';
import 'package:calculation_practice/template_screens/derivs_and_ints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

/*
Raised Button = Elevated Button
FlatButton = TextButton
Outline Button = Outlined Button
 */

void main() {
  runApp(CalculatorPractice());
}

class CalculatorPractice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Current Home Page'),
      routes: <String, WidgetBuilder>{
        '/addSub': (BuildContext context) => new AddSubPage(title: 'AddSub'),
        '/multDiv': (BuildContext context) => new MultDivPage(title: 'MultDiv'),
        '/rootPow': (BuildContext context) => new RootPowPage(title: 'RootPow'),
        '/trigLog': (BuildContext context) => new TrigLogPage(title: 'TrigLog'),
        '/sumFac': (BuildContext context) => new SumFacPage(title: 'SumFac'),
        '/derivInt': (BuildContext context) => new DerivIntPage(title: 'DerivInt'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  String _appBarTitle = 'Calculator';

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
      switch(index) {
        case 0:
          _appBarTitle = 'Calculator';
          break;

        case 1:
          _appBarTitle = 'Templates';
          break;

        case 2:
          _appBarTitle = 'Settings';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body:
        /*//x = {-b \pm \sqrt{b^2-4ac} \over 2a}.
        TeXView(
          child: TeXViewDocument(r"""$$\int$$<br> """),
        ),*/
      SafeArea(
        top: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            CalculatorPage(title: 'Calculator'),
            TemplatePage(title: 'Templates'),
            SettingsPage(title: 'Settings'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          _onItemTapped(index);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _appBarTitle = widget.title;
  }
}
