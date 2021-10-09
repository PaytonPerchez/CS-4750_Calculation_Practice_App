import 'package:calculation_practice/primary_screens/templates.dart';
import 'package:calculation_practice/primary_screens/settings.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  CalculatorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _constant = 'pi';
  String _variable = 'x';
  double _buttonContainerWidth = 190;
  double _buttonContainerHeight = 400;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        // Expression preview and save button
        Row(
          children: [
            // TODO If the widgets still do not fit well with
            // TODO one another, then use SizedBox
            Expanded(
              //width: 200,
              //height: 100,
              child: Text(
                'This is the calculator page',
              ),
            ),
          ],
        ),

        // Main buttons
        Container(
          //color: Colors.green,
          width: 448,
          height: 400,
          child: Row(
            children: [

              // Operation buttons
              Container(
                width: _buttonContainerWidth,
                // TODO the increase height may be contributing to vertical space between buttons
                height: _buttonContainerHeight,
                child: Column(
                  children: [

                    // +, -, *, /
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('+'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('-'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('*'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('/'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // Root, Pow, !
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('root'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('pow'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('!'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // sin, cos, tan
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('sin'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('cos'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('tan'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // log, ln, sum
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('log'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('ln'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('sum'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // int, deriv
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('int'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('deriv'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // nCr, nPr
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('nCr'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('nPr'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Number buttons
              Container(
                width: _buttonContainerWidth,
                height: _buttonContainerHeight,
                child: Column(
                  children: [

                    // 1, 2, 3
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('1'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('2'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('3'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // 4, 5, 6
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('4'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('5'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('6'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // 7, 8, 9
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('7'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('8'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('9'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // 0, ., (-)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('0'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('.'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('(-)'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // (, ), rand
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('('),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text(')'),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            child: Text('rand'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),

                    // const, vars
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: _constant,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              _constant = newValue!;
                            });
                          },
                          items: <String>['pi', 'e', 'i']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        OutlinedButton(
                          child: Text('vars'),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Left, right, backspace, and equal buttons
        Row(
          children: [
            OutlinedButton(
              child: Text('<-'),
              onPressed: null,
            ),
            OutlinedButton(
              child: Text('->'),
              onPressed: null,
            ),
            OutlinedButton(
              child: Text('backspc'),
              onPressed: null,
            ),
            OutlinedButton(
              child: Text('='),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }
}
