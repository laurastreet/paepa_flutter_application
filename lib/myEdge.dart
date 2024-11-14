class myEdge{
   int sourceNodeIndex;
   int destNodeIndex;

   myEdge(sNI, dNI){
     sourceNodeIndex = sNI;
     destNodeIndex = dNI;
   }

   int getSNIndex(){return sourceNodeIndex;}

   int getDIndex(){return destNodeIndex;}
}