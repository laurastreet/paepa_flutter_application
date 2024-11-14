import 'dart:ui';
import 'destNode.dart';

class sourceNode{
   int dx; //x-coor
   int dy; //y-coor
   //double direction;
   //double distance;
   Offset myOffset;
   int index;
   List<destNode> dNodes = new List<destNode>.empty(growable: true); //list
    //of destination nodes
   String ipAddress; 

   sourceNode(offset, idx, destNodes, iP){
     myOffset = offset;
   //  direction = dxn;
   //  distance = dist;  
     index = idx;
     dNodes = destNodes;
     ipAddress = iP;
   }

  /* double getDxn(){
     return direction;
   }

   double getDist(){
     return distance;
   }*/
   double getDx(){return myOffset.dx;}

   double getDy(){return myOffset.dy;}

   Offset getOffset(){
     return myOffset;
   }

   int getIndex(){return index;}

   List<destNode> getList(){return dNodes;}

   String getIP(){return ipAddress;}
} 