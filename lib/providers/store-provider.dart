import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/Items.dart';
import 'package:flutter_2dv50e/models/item.dart';

class Store with ChangeNotifier {
  List<Item> _listItems = [];
  List<Item> get listItems => _listItems;

  getListItems() async {
    _listItems = await fetchItem();
    print('In store');
    print(_listItems);
    notifyListeners();
  }
}
