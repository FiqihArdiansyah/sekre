import 'package:belajar2/models/inventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Future<void> addInventory(Inventory inventory) async {
    await FirebaseFirestore.instance
        .collection('inventories')
        .add(inventory.toJson());
  }
}
