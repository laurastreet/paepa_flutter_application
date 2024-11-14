import 'dart:html';

import 'DjikstraNode.dart';

class PriorityList{

    DjikstraNode head;

    PriorityList(DjikstraNode startNode){
      head = startNode;
    } 

    //check list for duplicates
    bool duplicate(DjikstraNode startNode,  DjikstraNode newNode){
      DjikstraNode curr = startNode;

      while(curr!=null){
        if(curr.getIndex()==newNode.getIndex())
          return true;
        curr = curr.next;  
      }

      return false;
    }

    //nodes are added according to distance
    addNode(DjikstraNode newNode){
      DjikstraNode curr = head;
      DjikstraNode prev = head;

      //special case of adding to head of list
      if(head==null || newNode.distance<head.distance){
        newNode.next = head;
        head = newNode;
      }

      //otherwise
      else{
        while(curr!=null && curr.distance<newNode.distance){
          prev = curr;
          curr = curr.next;
        }

        prev.next = newNode;
        newNode.next = curr;
     //   print('prev.next: ' + newNode.toString());
    //    print('else newNode.next: ' + newNode.next.toString());
      }
    }

    DjikstraNode peek(){
      if(head==null)
        return null;
      else  
        return head;  
    }

    DjikstraNode removeHead(){
      DjikstraNode temp = head;
      head = head.next;
      return temp;
    }

    int getLength(){
      DjikstraNode curr = head;
      int length = 0;
      while(curr!=null){
        length++;
        curr=curr.next;
      }
      return length;
    }


  /*  String toString(PriorityList list){
      String str = "";
      for(int i=0; i<list.getLength(); i++)
        str = str  + list.removeHead().getIndex().toString() + " ";
      return str;
    }*/
}