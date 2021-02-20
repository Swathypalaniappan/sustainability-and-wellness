import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference records =
      FirebaseFirestore.instance.collection('Records');

  Future<void> createUser(String name, String email) async {
    String uid = _auth.currentUser.uid.toString();
    users.doc(uid).set({'uid': uid, 'Name': name, 'email': email});
    return;
  }

  Future<void> initializeRecords() async {
    String uid = _auth.currentUser.uid.toString();
    records.doc(uid).set({
      'Steps': 0,
      'HeartRate': 0,
      'Respiration': 0,
      'BloodPressure': 0,
      'Glucose': 0,
      'OxygenSaturation': 0,
      'Cholestrol': 0,
      'BodyTemperature': 0,
    });
    return;
  }

  Future<void> updateRecords(
      String name,
      int step,
      int rate,
      int respiration,
      int pressure,
      int glucose,
      int oxygen,
      int cholestrol,
      double temp) async {
    String uid = _auth.currentUser.uid.toString();
    records.doc(uid).update({
      'Name': name,
      'Steps': step,
      'HeartRate': rate,
      'Respiration': respiration,
      'BloodPressure': pressure,
      'Glucose': glucose,
      'OxygenSaturation': oxygen,
      'Cholestrol': cholestrol,
      'BodyTemperature': temp,
    });
    return;
  }
}
//  heartRate,respiration,pressure,glucose,saturation,cholestrol,steps;
// var temperature;
// CollectionReference users = FirebaseFirestore.instance.collection('Users');
//   FirebaseAuth _auth = FirebaseAuth.instance;
// Future<void> createUser(String name,String email) async{
// String uid = _auth.currentUser.uid.toString();
//   users.add({
//     'uid' : uid,
//     'Name' : name,
//     'email' : email
//   });
// return;
// }
