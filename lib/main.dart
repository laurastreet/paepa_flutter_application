import 'dart:html';
import 'dart:ui';
import 'dart:collection';
import 'dart:typed_data';
import 'sourceNode.dart';
import 'destNode.dart';
import 'DjikstraNode.dart';
import 'myEdge.dart';
import 'PriorityList.dart';
import 'fractals.dart';
import 'package:flutter/painting.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'dart:math';


void main() {
 // runApp(MyApp());
 runApp(FractalApp());
}

class MyApp extends StatelessWidget {
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
        title: 'Djikstra\'s Shortest Path',
        theme: ThemeData(
        // primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}


// class MenuItem extends ChangeNotifier{
  
//   int _val0;
//   int _val1; 

//   int getInt0(){
//     return _val0;
//   }
  
//   int getInt1(){
//     return _val1;
//   }

//   void changeMenuItem(int newValue0,  BuildContext context){
//     _val0 = newValue0;
//    // _selectedItem2 = newItem2;
//     Provider.of<MenuItem>(context, listen: true).changeMenuItem(newValue0, context);
//     notifyListeners(); //0 arguments
//   }
// }


class MyHomePage extends StatefulWidget{
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  int _value0 = 0;
  int _value1 = 1;
  
  final DropdownMenuItem item0 = new DropdownMenuItem(child: Text("0"), value: 0);
  final DropdownMenuItem item1 = new DropdownMenuItem(child: Text("1"), value: 1);
  final DropdownMenuItem item2 = new DropdownMenuItem(child: Text("2"), value: 2);
  final DropdownMenuItem item3 = new DropdownMenuItem(child: Text("3"), value: 3);
  final DropdownMenuItem item4 = new DropdownMenuItem(child: Text("4"), value: 4);
  final DropdownMenuItem item5 = new DropdownMenuItem(child: Text("5"), value: 5);

  @override
  Widget build(BuildContext context) {
   // var _value0 = Provider.of<MenuItem>(context).getInt0();
    return Scaffold(
      appBar: AppBar(
        title: Text('Djikstra\'s Shortest Path'),
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
            painter: OpenPainter(_value0, _value1),
        //    painter: OpenPainter(),
          ),
        ),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,  
            children: <Widget>[
              DropdownButton(
                value: _value0,
                items: [
                  item0,
                  item1,
                  item2,
                  item3,
                  item4,
                  item5,
                ],
                style: TextStyle(fontSize: 20),
                onChanged: (newValue){
                  setState((){
                    _value0 = newValue;
                  });
                }),
              // onChanged: (newValue){_changeMenuItem(newValue, context);},
              DropdownButton(
                value: _value1,
                items: [
                  item0,
                  item1,
                  item2,
                  item3,
                  item4,
                  item5,  
                ],
                style: TextStyle(fontSize: 20),
                onChanged: (newValue){
                  setState((){
                    _value1 = newValue;
                  });
                }),
            ]
          ),
        ),
     ]),
    );
  }
}

class OpenPainter extends CustomPainter{

  int _value0, _value1;
  OpenPainter(int sItem0, int sItem1){
    _value0 = sItem0;
    _value1 = sItem1;
  }

  @override
  void paint(Canvas canvas, Size size){
    var paint1 = Paint()
      ..color = Colors.green
      ..strokeWidth = 10;
    var paint3 = Paint()  
      ..color = Color(0x888888ff)   
      ..strokeWidth = 1;
    var paint4 = Paint()
      ..color = Colors.cyan[400].withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    print('_value0: ' +_value0.toString());
    print('_value1: ' + _value1.toString());

    List<Offset> myOffsets = new List<Offset>();
    myOffsets.add(new Offset(size.width*.125,size.height*.75)); //.125, .375
    myOffsets.add(new Offset(size.width*.25,size.height*.5)); //.25, .25
    myOffsets.add(new Offset(size.width*.25,size.height*.875)); //.25, .5
    myOffsets.add(new Offset(size.width*.5, size.height*.25)); //.375, .125
    myOffsets.add(new Offset(size.width*.75, size.height*.5)); //.5, .25
    myOffsets.add(new Offset(size.width*.75, size.height*.875)); //.5, .5*/

    List<sourceNode> createSourceNodes(List<Offset> myOffsets){
      List<sourceNode> arrayOfLists = new List<sourceNode>.empty(growable: true); 
      for(int i=0; i<6; i++){
        List<destNode> dNodes = new List<destNode>.empty(growable: true);
        String ipAddress = "" + i.toString();
        sourceNode sNode = new sourceNode(myOffsets[i], i, dNodes, ipAddress);
        arrayOfLists.add(sNode);  
      }
      return arrayOfLists;
    }

    //add bidirectional edges
    List<myEdge> createEdges(){
      List<myEdge> edgeList = new List<myEdge>.empty(growable: true); 
      myEdge e0 = new myEdge(0,1);
      myEdge e1 = new myEdge(0,4);
      myEdge e2 = new myEdge(0,5);
      myEdge e3 = new myEdge(1,2);
      myEdge e4 = new myEdge(2,3);
      myEdge e5 = new myEdge(2,4);
      myEdge e6 = new myEdge(3,5);
      myEdge e7 = new myEdge(4,5);
      myEdge e8 = new myEdge(1,0);
      myEdge e9 = new myEdge(4,0);
      myEdge e10 = new myEdge(5,0);
      myEdge e11 = new myEdge(2,1);
      myEdge e12 = new myEdge(3,2);
      myEdge e13 = new myEdge(4,2);
      myEdge e14 = new myEdge(5,3);
      myEdge e15 = new myEdge(5,4);
      edgeList.add(e0);
      edgeList.add(e1);
      edgeList.add(e2);
      edgeList.add(e3);
      edgeList.add(e4);
      edgeList.add(e5);
      edgeList.add(e6);
      edgeList.add(e7);
      edgeList.add(e8);
      edgeList.add(e9);
      edgeList.add(e10);
      edgeList.add(e11);
      edgeList.add(e12);
      edgeList.add(e13);
      edgeList.add(e14);
      edgeList.add(e15);
      return edgeList;
    }

    void addDestNodesToSNodes(List<sourceNode> arrayOfLists, List<myEdge> edgeList){
      for(int i=edgeList.length; i>0; i--){
        myEdge e = edgeList.removeLast(); //pops last element from  list
        int destNodeIndex = e.getDIndex();
  
        //create a new destNode with the information from the sourceNode with the corresponding index
        sourceNode dNode = arrayOfLists[e.getDIndex()];
        destNode newNode = new destNode(dNode.getOffset(), destNodeIndex);
        sourceNode listHead = arrayOfLists[e.getSNIndex()]; //returns the sourceNode from the Edge pair
        List<destNode> destNodes = listHead.getList();

        //no duplicates
        bool hasIndex = false;
        for(int i=0; i<destNodes.length; i++){
          if(destNodes[i].getIndex()==newNode.getIndex())
            hasIndex = true;  
        }
        if(!hasIndex)
          destNodes.add(newNode); //add newly created destNode to sourceNode's list
      }    
    }

    void printArrayOfLists(List<sourceNode> arrayOfLists){
        //print each source node and list of destNodes
      for(int i=0;i<arrayOfLists.length;i++){
        print(arrayOfLists[i].getIndex().toString() + ": " + 
          arrayOfLists[i].getOffset().toString() + "\n");
        List<destNode> destNodes = arrayOfLists[i].getList();
       // print('length: ' + destNodes.length.toString());
        for(int i=0; i<destNodes.length; i++)
          print('destNodeIndex: ' + destNodes[i].getIndex().toString());
        
      }
    }
     
    //generate 6 sourceNodes and add to arrayOfLists
    List <sourceNode> arrayOfLists = createSourceNodes(myOffsets);
    //generate 15 new edges and add to edgeList (no self-loops)
    List<myEdge> edgeList = createEdges();
    
    //add edges from edgeList to sourceNodes
    addDestNodesToSNodes(arrayOfLists, edgeList);
 //   printArrayOfLists(arrayOfLists);  //check to see that graph created correctly

    //create points out of sourceNode Offsets 
    List<Offset> points = new List<Offset>();
    for(int i=0; i<arrayOfLists.length; i++){
      Offset a = arrayOfLists[i].getOffset();
      points.add(a);
    }  

    //draw graph (vertices and edges)
    canvas.drawPoints(PointMode.points, points, paint1);
    for(int i=0; i<6; i++){
      List<destNode> destNodes = arrayOfLists[i].getList();  
      for(int j=0; j<destNodes.length; j++){
        canvas.drawLine(arrayOfLists[i].getOffset(), destNodes[j].getOffset(), paint3);
      }
    }
  
    //add Edge labels (only for 1st eight edges)
    List<myEdge> edges = createEdges();
    int start, end;
    sourceNode startNd, endNd;
    double startX, startY, endX, endY, distance, xDiff, yDiff, xMidTR, yMidTR;
    Offset transformedStartPoint,  transformedEndPoint;
    Matrix2 rotationMatrix;
    Matrix4 m;
    for(int i=0; i<8; i++){
      canvas.save();
      start = edges[i].getSNIndex();
      end = edges[i].getDIndex();
    //  print('start: '  + start.toString() + ', end: '  + end.toString());
      startNd = arrayOfLists[start];
      endNd = arrayOfLists[end];
      startX = startNd.getDx();
      startY = startNd.getDy(); 
      endX  = endNd.getDx();
      endY = endNd.getDy();
      xDiff = endX - startX;
      yDiff = endY-startY;
      
        //after rotation, start Offset doesn't change but end Offset does
      canvas.rotate(atan(yDiff/xDiff));
    //  print('rotation: ' + atan(yDiff/xDiff).toString());
      rotationMatrix = Matrix2(cos(atan(yDiff/xDiff)), -sin(atan(yDiff/xDiff)),
        sin(atan(yDiff/xDiff)), cos(atan(yDiff/xDiff)));  
      m = Matrix4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
      m.setUpper2x2(rotationMatrix);
      transformedStartPoint = MatrixUtils.transformPoint(m, startNd.getOffset());
      transformedEndPoint = MatrixUtils.transformPoint(m, endNd.getOffset());

      xMidTR = (transformedStartPoint.dx + transformedEndPoint.dx)/2.0;
      yMidTR = (transformedStartPoint.dy + transformedEndPoint.dy)/2.0;
      print('xMidTR: ' + xMidTR.toString() + ', yMidTR: ' + yMidTR.toString());
      distance = (endNd.getOffset() - startNd.getOffset()).distance;
      
      TextPainter tp = new TextPainter(
          text: TextSpan(
            text: distance.toInt().toString(), //edge weight
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout(minWidth: 0, maxWidth: size.width);

       // tp.paint(canvas, Offset(transformedStartPoint.dx, transformedStartPoint.dy));
       // tp.paint(canvas, Offset(transformedEndPoint.dx, transformedEndPoint.dy));
        tp.paint(canvas, Offset(xMidTR, yMidTR));
        canvas.restore();
    }
     
    //add vertex labels
    for(int i=0; i<arrayOfLists.length; i++){
      TextPainter tp = new TextPainter(
          text: TextSpan(
            text: arrayOfLists[i].getIP(), //IP address
            style: TextStyle(color: Color(0xffa500ff), fontSize: 25, fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
        );
      tp.layout(minWidth: 0, maxWidth: size.width);  
      tp.paint(canvas, Offset(arrayOfLists[i].getDx()-20,arrayOfLists[i].getDy()-3));
    }
    
    canvas.drawCircle(arrayOfLists[_value0].getOffset(), 5, paint4);
    String path = runDjikstras(_value0, _value1, arrayOfLists);
    List<String> arr = path.split(" ");
    List<int> lint = arr.map(int.parse).toList();
    print(lint);

    Path myPath = Path();
    for(int i=0; i<lint.length-1; i++){
      myPath.moveTo(arrayOfLists[lint[i]].getOffset().dx,arrayOfLists[lint[i]].getOffset().dy);
      myPath.lineTo(arrayOfLists[lint[i+1]].getOffset().dx,arrayOfLists[lint[i+1]].getOffset().dy);
      canvas.drawPath(myPath, paint4);
    }
    canvas.drawCircle(arrayOfLists[_value1].getOffset(), 5, paint4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
 /* bool shouldRepaint(OpenPainter oldDelegate) => oldDelegate._value0 != _value0 || 
    oldDelegate._value1 != _value1;*/
 
  String runDjikstras(int startIndex, int endIndex, List<sourceNode> arrayOfLists){
    List<DjikstraNode> djikstraNodes = List<DjikstraNode>(arrayOfLists.length);
   // print('run Djikstras with startNode: ' + startIndex.toString());
  //  print('run Djikstras with endNode: ' + endIndex.toString());

    //wrap initial node into DjikstraNode 
    DjikstraNode startNode = DjikstraNode(arrayOfLists[startIndex], null);
    startNode.distance = 0; //set distance of startNode to zero
    startNode.known = true; //set nodeIsKnown to true
    djikstraNodes[startIndex] = startNode;
    print('startNode.getIndex(): ' + startNode.getIndex().toString());

    //wrap remaining nodes into DjikstraNodes 
    for(int i=0; i<arrayOfLists.length; i++){
      if(i!=startIndex){
        DjikstraNode newNode = DjikstraNode(arrayOfLists[i], null);
        djikstraNodes[i] = newNode; //assign new DjikstraNode to appropriate position in array
      }
    }

    double findDistance(DjikstraNode startNode, DjikstraNode target){
      if(startNode.compareTo(target)==0)
        return 0;
      print('startNode.getIndex():  ' + startNode.getIndex().toString() 
        + ', target.getIndex(): ' + target.getIndex().toString() 
        + ', target.tempParent.getIndex(): ' + target.tempParent.getIndex().toString());
    
      Offset o2 = target.tempParent.getOffset(); 
      Offset o1 = target.getOffset();
      return (o1-o2).distance + findDistance(startNode, target.tempParent);    
    }

    DjikstraNode currMin  = startNode;
    DjikstraNode nextNode, neighbor;
    List<destNode> neighbors;
    double newDistance = 0;
    PriorityList list = new PriorityList(startNode);

    void printList(PriorityList list){
      DjikstraNode curr = list.head;
      while(curr!=null){
        print('list index: ' + curr.getIndex().toString() + ' distance: ' +
          curr.distance.toString());
        curr = curr.next;
      }
    }

    //a node is updated as known once it is determined that it has the lowest cost
    //(and you are looking at its neighbors)
    for(int i=0; i<arrayOfLists.length; i++){
      print('currMin.index: ' + currMin.getIndex().toString());
      neighbors = currMin.getNeighbors();
      print('neighbors.length: ' + neighbors.length.toString());
      for(int k=0; k<neighbors.length; k++){ //initial nextNode is the first unknown neighbor
        neighbor = djikstraNodes[neighbors[k].getIndex()];
        if(!neighbor.known){ 
          neighbor.tempParent = currMin;
          newDistance = findDistance(startNode, neighbor);
          print('neighbor[' + neighbor.getIndex().toString() + '].distance: ' 
            + neighbor.distance.toString() 
            + ', recursiveDistance: ' + newDistance.toString());
          if(newDistance < neighbor.distance){  //compare distances and update if less
            neighbor.distance = newDistance;
            neighbor.parent = currMin; //update parent if updating distance
            print('neighbor[' + neighbor.getIndex().toString() + '].newParent: ' 
            + neighbor.parent.getIndex().toString());
          }
          //check for duplicates first
          if(!list.duplicate(list.peek(), neighbor))
            list.addNode(neighbor); //add unknown, non-duplicate nodes to PriorityList 
        }
      }
        //update distance to include distance from currMin to nextNode
      list.removeHead();
      nextNode = list.peek(); //get i.d. of new head of PriorityList  
      if(nextNode!=null){
        currMin = nextNode; //set next currMin
        currMin.known = true;
        currMin.tempParent = currMin.parent;
      }   
      printList(list);
    }

    DjikstraNode start, end;
    String getPath(start, end){
      if(start.compareTo(end)==0)
        return start.getIndex().toString();
      return getPath(start,end.parent) + " " + end.getIndex().toString();    
    }
    
    //final path from startNode to targetNode
    String path = getPath(djikstraNodes[startIndex], djikstraNodes[endIndex]);
   // print('path: ' + path);

    return path;
  }
}


