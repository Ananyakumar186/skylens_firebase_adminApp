import 'package:flutter/material.dart';
import 'package:slad_app/db/db_helper.dart';

import '../models/brand_model.dart';

class TelescopeProvider with ChangeNotifier{
  List<Brand> brandList = [];

  Future<void> addBrand(String name){
    final brand = Brand(name: name);
    return DbHelper.addBrand(brand);
  }

  getAllBrands(){
    DbHelper.getAllBrands().listen((snapshot) {
      brandList = List.generate(snapshot.docs.length, (index) => Brand.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}