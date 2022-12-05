import 'package:cloud_firestore/cloud_firestore.dart';

class TestDB {
  final String name;
  final int age;
  final String sex;
  final bool isDev;

  TestDB({
    required this.name,
    required this.age,
    required this.sex,
    required this.isDev,
  });
  factory TestDB.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return TestDB(
      name: data["name"] ?? '',
      age: data["age"] ?? 0,
      sex: data["sex"] ?? '',
      isDev: data["isDev"] ?? false,
    );
  }
}
