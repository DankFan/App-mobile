import 'dart:convert';
import 'package:flutter/services.dart';

class ReadData {
  Future<List<Map<String, String>>> loadData() async {
    var data = await rootBundle.loadString('assets/file/countries.json');
    var dataJson = jsonDecode(data);
    
    return (dataJson['countries'] as List)
        .map((e) => {
              'code': e['code'] as String,
              'name': e['name'] as String,
            })
        .toList();
  }
}