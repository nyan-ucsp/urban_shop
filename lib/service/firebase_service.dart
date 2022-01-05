import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreService {
  static CollectionReference userCollection = _firestore.collection('users');
}

class FirestoreDoc<T> {
  late String id;
  late T data;

  FirestoreDoc({
    required this.id,
    required this.data,
  });
}
