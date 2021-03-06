import 'package:flutter/material.dart';
import 'package:calculation_practice/styles/Styles.dart';

class TemplatePage extends StatefulWidget {
  TemplatePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {

  Widget _buildButton(String operation) {

    Widget buttonIcon = Text('');
    String path;
    switch(operation) {
      case '+':
        path = '/add';
        break;

      case '\u2212':
        path = '/sub';
        break;

      case '\u00d7':
        path = '/mult';
        break;

      case '\u00f7':
        path = '/div';
        break;

      case '\u221a':
        path = '/root';
        break;

      case '^':
        path = '/pow';
        break;

      case 'trig':
        path = '/trig';
        break;

      case 'log':
        path = '/log';
        break;

      case '\u2211':
        path = '/sum';
        break;

      case '!':
        path = '/fac';
        break;

      case 'd/dx':
        path = '/deriv';
        break;

      case '\u222b':
        path = '/int';
        break;

      case 'random':
        path = '/random';
        buttonIcon = Icon(Icons.casino);
        break;

      default:
        path = '/add';
        break;
    }

    if(operation.compareTo('random') != 0) {
      buttonIcon = Text(
        operation,
        style: Styles.templateButtonStyle,
      );
    }

    return Container(
      height: (MediaQuery.of(context).size.width) * 0.1,
      width: (MediaQuery.of(context).size.height) * 0.1,

      child: ElevatedButton(
        child: buttonIcon,
        onPressed: () {
          Navigator.of(context).pushNamed(path);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.brown.shade300,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.width) * 0.2,
          width: (MediaQuery.of(context).size.height) * 0.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: /*OutlinedButton(
                  child: Text('Custom', style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),),
                  onPressed: null,
                ),*/
                Text(''),
              ),
            ],
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.width) * 0.2,
          width: (MediaQuery.of(context).size.height) * 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('+'),
              _buildButton('\u2212'),
              _buildButton('\u00d7'),
              _buildButton('\u00f7'),
            ],
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.width) * 0.2,
          width: (MediaQuery.of(context).size.height) * 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('\u221a'),
              _buildButton('^'),
              _buildButton('trig'),
              _buildButton('log'),
            ],
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.width) * 0.2,
          width: (MediaQuery.of(context).size.height) * 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('\u2211'),
              _buildButton('!'),
              _buildButton('d/dx'),
              _buildButton('\u222b'),
            ],
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.width) * 0.2,
          width: (MediaQuery.of(context).size.height) * 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //_buildButton('random'),
            ],
          ),
        ),
      ],
    );
  }
}
