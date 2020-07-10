import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(calApp());
}

class calApp extends StatelessWidget {
  //const calApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sdf',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCal(),
    );
  }
}

class SimpleCal extends StatefulWidget {
  @override
  _SimpleCalState createState() => _SimpleCalState();
}

class _SimpleCalState extends State<SimpleCal> {
  String equation = "0";
  String result = "0";
  String expresion = "";
  double equationSize = 38.0;
  double resultSize = 48.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('asdasdasd')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(children: [
                  TableRow(children: [
                    _buildBtn("C", 1, Colors.redAccent),
                    _buildBtn("⌫", 1, Colors.blue),
                    _buildBtn("/", 1, Colors.blue),
                  ]),
                  TableRow(children: [
                    _buildBtn("7", 1, Colors.black54),
                    _buildBtn("8", 1, Colors.black54),
                    _buildBtn("9", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    _buildBtn("4", 1, Colors.black54),
                    _buildBtn("5", 1, Colors.black54),
                    _buildBtn("6", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    _buildBtn("1", 1, Colors.black54),
                    _buildBtn("2", 1, Colors.black54),
                    _buildBtn("3", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    _buildBtn(".", 1, Colors.black54),
                    _buildBtn("0", 1, Colors.black54),
                    _buildBtn("00", 1, Colors.black54),
                  ]),
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [_buildBtn('×', 1, Colors.blue)]),
                    TableRow(children: [_buildBtn('-', 1, Colors.blue)]),
                    TableRow(children: [_buildBtn('+', 1, Colors.blue)]),
                    TableRow(children: [_buildBtn('=', 2, Colors.redAccent)]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(String btnText, double btnHeight, Color bntColor) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
        color: bntColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          child: Text(btnText,
              style: TextStyle(fontSize: 30.0, color: Colors.white)),
          onPressed: () => btnPres(btnText),
        ));
  }

  btnPres(String btnText) {
    setState(() {
      if (btnText == "C") {
        equation = "0";
        result = "0";
      } else if (btnText == "⌫") {
        equation = equation.substring(0, equation.length - 1);

        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
            expresion = equation;
            expresion = equation.replaceAll('x', '*');
            expresion = equation.replaceAll('/', '/');
           
        try {
      
          Parser p = Parser();
          Expression exp = p.parse(expresion);

          ContextModel cm = ContextModel();

          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
        equation = "0";
      } else {
        if (equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }
}
