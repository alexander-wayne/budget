import 'package:flutter/material.dart';

class NoPurchases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                child: Text(
                  "You haven’t saved \nany purchases yet. \n\n\nClick the “+” to start",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
                child: Image.asset("assets/images/arrow.png", width: MediaQuery.of(context).size.width / 2.5, height: MediaQuery.of(context).size.width / 2.5,))
            ],
          ),
        ),
      );
  }
}