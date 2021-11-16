import 'package:calculation_practice/primary_screens/templates.dart';
import 'package:calculation_practice/primary_screens/calculator.dart';
import 'package:calculation_practice/primary_screens/settings.dart';
import 'package:calculation_practice/template_screens/root.dart';
import 'package:calculation_practice/template_screens/pow.dart';
import 'package:calculation_practice/template_screens/add.dart';
import 'package:calculation_practice/template_screens/sub.dart';
import 'package:calculation_practice/template_screens/mult.dart';
import 'package:calculation_practice/template_screens/div.dart';
import 'package:calculation_practice/template_screens/trig.dart';
import 'package:calculation_practice/template_screens/logs.dart';
import 'package:calculation_practice/template_screens/sums.dart';
import 'package:calculation_practice/template_screens/fac.dart';
import 'package:calculation_practice/template_screens/derivs.dart';
import 'package:calculation_practice/template_screens/int.dart';
import 'package:calculation_practice/template_screens/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

/*
Raised Button = Elevated Button
FlatButton = TextButton
Outline Button = Outlined Button
 */
enum operations {operation1, operation2}

operations? _selectedOperation = operations.operation1;
void main() {
  runApp(CalculatorPractice());
}

class CalculatorPractice extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculation Practice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculator'),
      routes: <String, WidgetBuilder>{
        '/add': (BuildContext context) => new AddPage(title: 'Add'),
        '/sub': (BuildContext context) => new SubPage(title: 'Sub'),
        '/mult': (BuildContext context) => new MultPage(title: 'Mult'),
        '/div': (BuildContext context) => new DivPage(title: 'Div'),
        '/root': (BuildContext context) => new RootPage(title: 'Root'),
        '/pow': (BuildContext context) => new PowPage(title: 'Pow'),
        '/trig': (BuildContext context) => new TrigPage(title: 'Trig'),
        '/log': (BuildContext context) => new LogPage(title: 'Log'),
        '/sum': (BuildContext context) => new SumPage(title: 'Sum'),
        '/fac': (BuildContext context) => new FacPage(title: 'Fac'),
        '/deriv': (BuildContext context) => new DerivPage(title: 'Deriv'),
        '/int': (BuildContext context) => new IntPage(title: 'Int'),
        '/random': (BuildContext context) => new RandomPage(/*title: 'Random'*/)
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

  int _selectedIndex = 0; // used for indexed stack
  String _appBarTitle = 'Calculator';

  /// Switches between the Calculator, Templates, and Settings screens.
  /// * index: The screen being switched to.
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
      ///*
      SafeArea(
        top: false,
        child: IndexedStack(
          index: _selectedIndex,
          alignment: Alignment(0.0, 0.0),
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
      ),//*/
    );
  }

  @override
  void initState() {
    _appBarTitle = widget.title;
    super.initState();
  }
}
