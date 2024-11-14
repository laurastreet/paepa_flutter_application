import 'dart:core';
import 'dart:html';
import 'dart:ui';
import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/painting.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'dart:math';

class FractalApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MenuItem(),
        )
      ],
      child: MaterialApp(
        title: 'Fractals',
        theme: ThemeData(
        // primarySwatch: Colors.blue,
        ),
        home: FractalPage(),
      ),
    );
  }
}
class FractalPage extends StatefulWidget{
  _FractalPageState createState() => _FractalPageState();
}

class _FractalPageState extends State<FractalPage>{
  @override
  Widget build(BuildContext context) {
   // var _value0 = Provider.of<MenuItem>(context).getInt0();
    return Scaffold(
      appBar: AppBar(
        title: Text('Fractals'),
        backgroundColor: Color(0xFF444444),
      ),
   //   body: ListView(children: <Widget>[
     body: Wrap(
       spacing: 1.0,
       children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.65,
          child: CustomPaint(
            painter: TrianglePainter(4, 150,50,50,200,250,200),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.65,
          child: CustomPaint(
       //     painter: TreePainter(_value0, _value1),
        //    painter: OpenPainter(),
          ),  
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.65,
          child: CustomPaint(
       //     painter: SnowflakePainter(_value0, _value1),
        //    painter: OpenPainter(),
          ),  
        ),
       ]),
    );
  }
}

class MenuItem extends ChangeNotifier{
  //ListItem _selectedItem1 = new ListItem(0,'192.168.1.0');
  //ListItem _selectedItem2 = new ListItem(1,'192.168.1.1');

  int _order;
  double _aX, _aY, _bX, _bY, _cX, _cY; 

  int getOrder(){
    return _order;
  }
  
  double getAX(){
    return _aX;
  }

  double getAY(){
    return _aY;
  }

  double getBX(){
    return _aX;
  }

  double getBY(){
    return _bX;
  }

  double getCX(){
    return _cX;
  }

  double getCY(){
    return _cY;
  }

  void changeMenuItem(int newValue0,  BuildContext context){
   // _val0 = newValue0;
   // _selectedItem2 = newItem2;
    Provider.of<MenuItem>(context, listen: true).changeMenuItem(newValue0, context);
    notifyListeners(); //0 arguments
  }
}

class TrianglePainter extends CustomPainter{

 // int _value0, _value1;
 int _order; 
 double _aX, _aY, _bX, _bY, _cX, _cY;
  TrianglePainter(int order, double aX, double aY, double bX, double bY, double cX, double cY){
    _order = order;
    _aX = aX;
    _aY = aY;
    _bX = bX;
    _bY = bY;
    _cX = cX;
    _cY = cY;
  }

  @override
  void paint(Canvas canvas, Size size){
    var paint4 = Paint()
      ..color = Colors.cyan[400].withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    drawTriangle(canvas, paint4,_order, _aX, _aY, _bX, _bY, _cX, _cY);
  }

  void drawTriangle(Canvas canvas, Paint paint4, int order, double aX, 
    double aY, double bX, double bY, double cX, double cY){
      /*base case*/
    if(order==1){
      print('base case: ' + order.toString());
      Path myPath = Path();
      myPath.moveTo(aX, aY);
      myPath.lineTo(bX, bY);
      canvas.drawPath(myPath, paint4);
      myPath.moveTo(bX, bY);
      myPath.lineTo(cX, cY);
      canvas.drawPath(myPath, paint4);
      myPath.moveTo(cX, cY);
      myPath.lineTo(aX, aY);
      canvas.drawPath(myPath, paint4);
     // canvas.stroke();
    }

    /*recursive case*/
    else{
      print('recursive case,  order: ' + order.toString());
      double midPtAB_X = (aX+bX)/2;
      double midPtAB_Y = (aY+bY)/2;

      double midPtBC_X = (bX+cX)/2;
      double midPtBC_Y = (bY+cY)/2;

      double midPtCA_X = (cX+aX)/2;
      double midPtCA_Y = (cY+aY)/2;

      drawTriangle(canvas, paint4, order-1, aX, aY, midPtAB_X, midPtAB_Y, midPtCA_X, midPtCA_Y);
      drawTriangle(canvas, paint4, order-1, bX, bY, midPtAB_X, midPtAB_Y, midPtBC_X, midPtBC_Y);
      drawTriangle(canvas, paint4, order-1, cX, cY, midPtBC_X, midPtBC_Y, midPtCA_X, midPtCA_Y);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TreePainter extends CustomPainter{

  int _startX, _startY, _len;
  double _angle;

  TreePainter(int startX, int startY, int len){
    _startX = startX;
    _startY = startY;
    _len = len;
  }

  @override
  void paint(Canvas canvas, Size size){
    var paint3 = Paint()
      ..color = Colors.cyan[400].withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    drawTree(canvas, paint3, _startX, _startY, _len, _angle);
  }

  void drawTree(Canvas canvas, Paint paint, int startX, int startY, int len, 
    double angle){
      // 	ctx.beginPath();
// 	ctx.save();

// 	canvas.translate(startX, startY);
// 	canvas.rotate(angle*Math.PI/180);
// 	canvas.moveTo(0,0);
// 	canvas.lineTo(0, -len);
// 	canvas.stroke();

// 	if(len<10){
// 		canvas.restore();
// 		return;
// 	}

// 	drawTree(0, -len, len*0.8, -15);
// 	drawTree(0, -len, len*0.8, 15);

// 	canvas.restore();
// }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  
}

class SnowflakePainter extends CustomPainter{

  int _value0, _value1;
  SnowflakePainter(int sItem0, int sItem1){
    _value0 = sItem0;
    _value1 = sItem1;
  }

  @override
  void paint(Canvas canvas, Size size){

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  
}


// function kSnowflake(order, LEFTX, LEFTY, TOPX, TOPY, RIGHTX, RIGHTY){
// 	drawSnowflake(order, TOPX, TOPY, LEFTX, LEFTY);
// 	drawSnowflake(order, LEFTX, LEFTY, RIGHTX, RIGHTY);
// 	drawSnowflake(order, RIGHTX, RIGHTY, TOPX, TOPY);
// }

// function drawSnowflake(order, x1, y1, x5, y5){
// 	var myCanvas = document.getElementById("snowFlakeCanvas");
// 	var ctx = myCanvas.getContext("2d");

// 	/*base case*/
// 	if(order==1){
// 		ctx.beginPath();
// 		ctx.moveTo(x1, y1);
// 		ctx.lineTo(x5, y5);
// 		ctx.stroke();
// 	}

// 	/*recursive case*/
// 	else{
// 		var SQ = Math.sqrt(3.0)/6;
// 		var deltaX = x5-x1;
// 		var deltaY = y5-y1;

// 		var x2 = x1+(1/3)*deltaX;
// 		var y2 = y1+(1/3)*deltaY;

// 		var x3 = (x1+x5)/2 + SQ*(y1-y5);
// 		var y3 = (y1+y5)/2 + SQ*(x5-x1);

// 		var x4 = x1 + deltaX*2/3;
// 		var y4 = y1 + deltaY*2/3;

// 		drawSnowflake(order-1, x1, y1, x2, y2);
// 		drawSnowflake(order-1, x2, y2, x3, y3);
// 		drawSnowflake(order-1, x3, y3, x4, y4);
// 		drawSnowflake(order-1, x4, y4, x5, y5);
// 	}
//}