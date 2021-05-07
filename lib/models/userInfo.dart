import 'package:firebase_database/firebase_database.dart';

class UserInfo {
   String fullname;
   String phone;
   String email;
   String id;

  UserInfo({
    this.id,
    this.email,
    this.fullname,
    this.phone,
  });

  UserInfo.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullname = snapshot.value['fullname'];
  }
}
