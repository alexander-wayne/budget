import 'dart:async';

import 'package:budget/add.dart';
import 'package:budget/noPurchases.dart';
import 'package:budget/purchase.dart';
import 'package:budget/purchasesList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget/colors.dart' as colors;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

List purchases = [{}];

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Scaffold(backgroundColor: Colors.red, body: Center(child: Text("ERROR",)),);
        } 
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Budget',
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColor: colors.green,
              primarySwatch: colors.greenSwatch
            ),
            home: MyHomePage(title: 'Expense Tracker'),
          );
        }

        return Scaffold(body: Center(child: CupertinoActivityIndicator(),),);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title, 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        backgroundColor: colors.green,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("purchases").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(child: Text("ERROR", style: TextStyle(fontSize: 26, color: Colors.red),),);
          } 
          if(snapshot.hasData){
            purchases = [];
      
            for (QueryDocumentSnapshot doc in (snapshot.data as QuerySnapshot).docs) {

              // Map<String, dynamic> temp = doc.data();

              if(doc.data()["notes"] != null){
                purchases.add({
                  "title" : doc.data()["title"],
                  "price" : doc.data()["price"],
                  "date" : (doc.data()["date"] as Timestamp).toDate(),
                  "timeAdded" : (doc.data()["timeAdded"] as Timestamp).toDate(),
                  "notes" : doc.data()["notes"],
                  "id" : doc.id
                });
              } else {
                purchases.add({
                  "title" : doc.data()["title"],
                  "price" : doc.data()["price"],
                  "date" : (doc.data()["date"] as Timestamp).toDate(),
                  "timeAdded" : (doc.data()["timeAdded"] as Timestamp).toDate(),
                  "id" : doc.id
                });
              }
            }
            if(purchases.length == 0){
              return NoPurchases();
            } else{
              return PurchasesList();
            }
          } 
          return Center(child: CupertinoActivityIndicator(),);
        },
      ),
      // body: FutureBuilder(
      //   future: getPurchases(),
      //   builder: (context, snapshot){

      //     if(snapshot.hasError){
      //       return Center(child: Text("ERROR", style: TextStyle(fontSize: 26, color: Colors.red),),);
      //     } 
      //     if(snapshot.hasData){
      //       purchases = [];
      
      //       for (QueryDocumentSnapshot doc in (snapshot.data as QuerySnapshot).docs) {

      //         // Map<String, dynamic> temp = doc.data();

      //         if(doc.data()["notes"] != null){
      //           purchases.add({
      //             "title" : doc.data()["title"],
      //             "price" : doc.data()["price"],
      //             "date" : (doc.data()["date"] as Timestamp).toDate(),
      //             "timeAdded" : (doc.data()["timeAdded"] as Timestamp).toDate(),
      //             "notes" : doc.data()["notes"]
      //           });
      //         } else {
      //           purchases.add({
      //             "title" : doc.data()["title"],
      //             "price" : doc.data()["price"],
      //             "date" : (doc.data()["date"] as Timestamp).toDate(),
      //             "timeAdded" : (doc.data()["timeAdded"] as Timestamp).toDate(),
      //           });
      //         }
      //       }
      //       if(purchases.length == 0){
      //         return NoPurchases();
      //       } else{
      //         return PurchasesList();
      //       }
      //     } 
      //     return Center(child: CupertinoActivityIndicator(),);
      //   },
      // ),
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: colors.green,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Add())).then((_){
                // setState(() {
                  
                // });
              });
            },
          ),
        ),
      ),
    );
  }
}
