import 'package:budget/main.dart';
import 'package:budget/purchase.dart';
import 'package:budget/purchaseDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PurchaseTile extends StatelessWidget {

  String title;
  double price;
  DateTime date;
  DateTime timeAdded;
  String notes = '';
  String id;

  PurchaseTile({@required this.title, @required this.price, @required this.date, @required this.timeAdded, @required this.id, this.notes});

  @override
  Widget build(BuildContext context) {
    if(title == null) {
      return Container();
    }
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 1/5,
      actions: [
        IconSlideAction(
          icon: Icons.delete,
          caption: "Delete",
          color: Colors.red,
          onTap: () async {
            // DELETE ON FIREBASE VIA ID
            print(id);
            await FirebaseFirestore.instance.collection("purchases").doc(id).delete();

            //DELETE ON FIREBASE VIA TIMEADDED
            // FirebaseFirestore.instance.collection("purchases").where('timeAdded', isEqualTo: timeAdded).get().then((snapshot){
            //   for (QueryDocumentSnapshot doc in snapshot.docs) {
            //     FirebaseFirestore.instance.collection("purchases").doc(doc.id).delete();
            //   }
            // });

            // DELETE VIA LOCAL LIST
            // purchases.removeWhere((purchase) => purchase['timeAdded'] == timeAdded);
          },
        )
      ],
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseDetails(title: title, price: price, date: date, timeAdded: timeAdded, id: id, notes: notes,)));
        },
              child: Container(
          color: Color.fromARGB(255, 220, 220, 220),
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "\$" + price.toStringAsFixed(2),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
