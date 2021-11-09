import 'package:budget/purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:budget/colors.dart' as colors;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:budget/main.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController titleController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController(
      decimalSeparator: ".", thousandSeparator: ",", leftSymbol: "\$");
  DateTime date;
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.green,
        title: Text("Add Purchase"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusNode().unfocus();
        },
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 200, 200, 200)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: titleController,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: "Title",
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.of(context).size.width / 2 - 25,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 1),
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 200, 200, 200)),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: priceController,
                            showCursor: false,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Price",
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: new DateTime(2010, 1, 1),
                                    lastDate: new DateTime(2030, 1, 1),
                                    initialDate: DateTime.now(),
                                    )
                                .then((selectedDate) {
                              setState(() {
                                if (selectedDate != null) {
                                  date = selectedDate;
                                }
                              });
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            width: MediaQuery.of(context).size.width / 2 - 25,
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(255, 200, 200, 200)),
                            child: Center(
                              child: Text(
                                date == null
                                    ? "Date"
                                    : "${date.month}/${date.day}/${date.year}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 200, 200, 200)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: notesController,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: "Notes (optional)",
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 75,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      onPressed: (titleController.text != "" &&
                              priceController.text != "" &&
                              date != null)
                          ? () {
                              if (notesController.text == "") {
                                FirebaseFirestore.instance
                                    .collection("purchases")
                                    .add({
                                  "title": titleController.text,
                                  "price": double.parse(
                                      priceController.text.substring(1)),
                                  "date": date,
                                  "timeAdded": DateTime.now()
                                });
                              } else {
                                FirebaseFirestore.instance
                                    .collection("purchases")
                                    .add({
                                  "title": titleController.text,
                                  "price": double.parse(
                                      priceController.text.substring(1)),
                                  "date": date,
                                  "notes": notesController.text,
                                  "timeAdded": DateTime.now()
                                });
                                // purchases.add({
                                //   "title" : titleController.text,
                                //   "price" : double.parse(priceController.text.substring(1)),
                                //   "date" : date,
                                //   "notes" : notesController.text,
                                //   "timeAdded" : DateTime.now()
                                // });
                              }

                              Navigator.pop(context);
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
