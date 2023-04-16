import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

Color PColor = Color.fromARGB(255, 123, 0, 245);
Future<int> exist({
  CollectionReference? reference,
  dynamic value,
  String? field,
  dynamic value2,
  String? field2,
}) async {
  Query query = reference!;
  AggregateQuerySnapshot querySnapshot = await query
      .where(field!, isEqualTo: value)
      .where(field2!, isEqualTo: value2)
      .count()
      .get();
  return querySnapshot.count;
}
