import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/brand_model.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins'; //this is the collection name from firestore db

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get(); //accessing the document inside collection Admins.
    return snapshot.exists;
  }

  static Future<void> addBrand(Brand brand){
    final doc = _db.collection(collectionBrand).doc();
    brand.id = doc.id;
    return doc.set(brand.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() => _db.collection(collectionBrand).snapshots();
}
