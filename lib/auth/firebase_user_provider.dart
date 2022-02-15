import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FilligarFirebaseUser {
  FilligarFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FilligarFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FilligarFirebaseUser> filligarFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FilligarFirebaseUser>(
            (user) => currentUser = FilligarFirebaseUser(user));
