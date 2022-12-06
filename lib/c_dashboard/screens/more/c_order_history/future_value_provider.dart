// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ekart/c_dashboard/screens/more/c_order_history/testdb_model.dart';

// class DatabaseService {
//   final _db = FirebaseFirestore.instance;

 
//   /// Query a subcollection
//   Stream<List<TestDB>> streamWeapons() {
//     var ref = _db.collection('testDb').doc('testDoc').snapshots();

//     return ref.map((list) =>
//         list.map((doc) => TestDB.fromFirestore(doc)).toList());
    
//   }


// }