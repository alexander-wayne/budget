import 'package:budget/main.dart';
import 'package:budget/purchaseTile.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class PurchasesList extends StatefulWidget {
  @override
  _PurchasesListState createState() => _PurchasesListState();
}

class _PurchasesListState extends State<PurchasesList> {
  @override
  Widget build(BuildContext context) {
    print("PURCHASES: $purchases");
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: GroupedListView(
          elements: purchases,
          groupBy: (element) => element['date'],
          groupSeparatorBuilder: (groupBy){
            if(groupBy is DateTime){
              print("HI");
              DateTime date = groupBy;

              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "${date.month}/${date.day}/${date.year}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              );
            } 
            return Container();
          },
          itemBuilder: (context, dynamic element) => PurchaseTile(title: element['title'], price: element['price'], date: element['date'], timeAdded: element['timeAdded'], id: element['id'], notes: element['notes']),
          itemComparator: (item1, item2) {
            print(item1['date']);
             return item1['date'].compareTo(item2['date']);
          }, 
          useStickyGroupSeparators: false,
          floatingHeader: true,
          order: GroupedListOrder.DESC,
        )
      ),
    );
  }
}