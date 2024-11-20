import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slad_app/models/telescope.dart';

import '../models/brand_model.dart';
import '../utils/constants.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins'; //this is the collection name from firestore db
  static const String collectionTelescope = 'Telescopes'; //this is the collection name from firestore db

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get(); //accessing the document inside collection Admins.
    return snapshot.exists;
  }

  static Future<void> addBrand(Brand brand){
    final doc = _db.collection(collectionBrand).doc();
    brand.id = doc.id;
    return doc.set(brand.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() => _db.collection(collectionBrand).snapshots();

 static  Future<void> addTelescope(Telescope telescope) {
    final doc = _db.collection(collectionTelescope).doc();
    telescope.id = doc.id;
    return doc.set(telescope.toJson());
  }
}
