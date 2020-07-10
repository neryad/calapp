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
  Color bgColor = Color(0xffb9fbec3);
  Color bgColor1 = Color(0xffb0e5c68);
  Color bgColor2 = Color(0xffbf9fbfb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor ,
      //appBar: AppBar(title: Text('asdasdasd')),
      body: Column(
        
        children: <Widget>[
          Expanded(
            
             child: Divider( color: bgColor,),
          ),
            Container(
            
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationSize, color: bgColor1),
            ),
          ),
             Container(
            
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultSize,color: bgColor1, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 420,

            color: bgColor2,
            child: Row(
            
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: bgColor2,
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(children: [
                    TableRow(children: [
                      _buildBtn("C", 1, bgColor, bgColor2),
                      _buildBtn("⌫", 1,bgColor, bgColor2),
                      _buildBtn("%", 1, bgColor, bgColor2),
                    ]),
                    TableRow(children: [
                      _buildBtn("7", 1, bgColor2, bgColor1),
                      _buildBtn("8", 1, bgColor2, bgColor1),
                      _buildBtn("9", 1, bgColor2, bgColor1),
                    ]),
                    TableRow(children: [
                      _buildBtn("4", 1, bgColor2, bgColor1),
                      _buildBtn("5", 1, bgColor2, bgColor1),
                      _buildBtn("6", 1, bgColor2, bgColor1),
                    ]),
                    TableRow(children: [
                      _buildBtn("1", 1, bgColor2, bgColor1),
                      _buildBtn("2", 1, bgColor2, bgColor1),
                      _buildBtn("3", 1, bgColor2, bgColor1),
                    ]),
                    TableRow(children: [
                      _buildBtn(".", 1, bgColor2,bgColor1),
                      _buildBtn("0", 1, bgColor2,bgColor1),
                      _buildBtn("00", 1, bgColor2,bgColor1),
                    ]),
                  ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Table(
                    children: [
                      
                      TableRow(children: [_buildBtn('/', 1, bgColor,bgColor2)]),
                      TableRow(children: [_buildBtn('×', 1, bgColor,bgColor2)]),
                      TableRow(children: [_buildBtn('-', 1, bgColor,bgColor2)]),
                      TableRow(children: [_buildBtn('+', 1, bgColor,bgColor2)]),
                      TableRow(children: [_buildBtn('=', 1, bgColor1, bgColor2)]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(String btnText, double btnHeight, Color bntColor, Color btnCText) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
        padding: EdgeInsets.all(10),
        
        child: FlatButton(
          color: bntColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color:bntColor, width: 1, style: BorderStyle.solid)
                  ),
          child: Text(btnText,
              style: TextStyle(fontSize: 30.0, color: btnCText)),
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
