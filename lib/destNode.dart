import 'dart:ui';

class destNode{
   int dx; //x-coor
   int dy; //y-coor
   Offset myOffset;
   int index;

   destNode(offset, idx){
   //  dx = xCoor;
   //  dy = yCoor;
     myOffset = offset;
     index = idx; 
   }

   double getDx(){return myOffset.dx;}

   double getDy(){return myOffset.dy;}

   Offset getOffset(){
     return myOffset;
   }
   
   int getIndex(){return index;}
}
