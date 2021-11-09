import 'package:budget/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget/colors.dart' as colors;

class PurchaseDetails extends StatelessWidget {
  String title;
  double price;
  DateTime date;
  DateTime timeAdded;
  String id;
  String notes = '';

  PurchaseDetails(
      {@required this.title,
      @required this.price,
      @required this.date,
      @required this.timeAdded,
      @required this.id,
      this.notes});

  @override
  Widget build(BuildContext context) {

    CupertinoAlertDialog deleteDialog = CupertinoAlertDialog(
      title: Text("Delete?"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        CupertinoDialogAction(child: Text("No"), onPressed: (){
          Navigator.pop(context);
        },),
        CupertinoDialogAction(child: Text("Yes"), onPressed: () async {
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
          Navigator.pop(context);
          Navigator.pop(context);
        },),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.green,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.delete),
            onPressed: (){
              showDialog(context: context, builder: (context) => deleteDialog);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      title,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${date.month}/${date.day}/${date.year}",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "\$$price",
                      style: TextStyle(
                        fontSize: 36,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    child: Text(notes != null ? notes : "",
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
              Column(
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   height: 50,
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Colors.red,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(25))),
                  //       child: Text(
                  //         "Delete",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 24),
                  //       ),
                  //       onPressed: () {}),
                  // ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
