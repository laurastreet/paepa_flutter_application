import 'dart:ui';
import 'sourceNode.dart';
import 'destNode.dart';
import 'dart:math';

class DjikstraNode implements Comparable<DjikstraNode>{
   sourceNode sNode;
   DjikstraNode parent, tempParent,  next;
   double distance;
   int index;
   bool known;
   Offset offset;

   DjikstraNode(sourceNode, parentNode){
     sNode = sourceNode;
     parent = parentNode;
     tempParent = null;
     distance = double.maxFinite;
     known = false;
     next = null;
   }

   DjikstraNode getParent(){
     return parent;
   }

   sourceNode getSourceNode(){
     return sNode;
   }
   
   List<destNode> getNeighbors(){
     return sNode.getList();
   }

   int getIndex(){
     return sNode.getIndex();
   }

   Offset getOffset(){
     return sNode.getOffset();
   }

   @override
   int compareTo(DjikstraNode other){
     if(this.distance==other.distance)
      return 0;
     return (this.distance - other.distance).toInt(); 
   }
} 