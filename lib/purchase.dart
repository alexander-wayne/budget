import 'package:flutter/foundation.dart';

class Purchase{
  String title;
  double price;
  DateTime date;
  String notes;

  Purchase({@required this.title, @required this.price, @required this.date, this.notes});
}