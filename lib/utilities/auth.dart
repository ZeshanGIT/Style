import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
DatabaseReference databaseReference;
FirebaseUser user;
SharedPreferences prefs;

Future<FirebaseUser> handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  databaseReference = FirebaseDatabase.instance.reference();

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  user = await _auth.signInWithCredential(credential);
  // print("signed in " + user.displayName);

  prefs = await SharedPreferences.getInstance();
  prefs.setString("uid", user.uid);

  Function checkUser = (DataSnapshot d) {
    // print("Checking user.....");
    // print("Value : " + d.value.toString() + "Key : " + d.key);

    if (d.value.toString() == "null") {
      handleNewUser();
    } else {
      handleOldUser();
    }
  };

  await databaseReference
      .child("users/${user.uid}/email/")
      .once()
      .then(checkUser);

  return user;
}

handleSignOut() async {
  _googleSignIn.signOut().then((gacc) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
    print("Signed out");
  });
}

void handleNewUser() {
  Map<String, dynamic> map = {
    "email": user.email,
    "username": user.displayName,
    "photourl": user.photoUrl
  };

  databaseReference.child("users/${user.uid}/").update(map);
  print("new user");
}

void handleOldUser() {
  print("Old user");
}
