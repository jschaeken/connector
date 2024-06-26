import 'package:firebase_auth/firebase_auth.dart';

class ConnectorUser {
  String uid;
  String? email;
  String? displayName;
  String? photoURL;
  String? storeName;

  ConnectorUser({
    required this.uid,
    this.email,
    this.displayName,
    this.storeName,
    this.photoURL,
  });

  factory ConnectorUser.fromFirebaseUser(User user) {
    return ConnectorUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
      storeName: '',
    );
  }
}
