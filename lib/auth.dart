import 'package:brew_crew/database.dart';
import 'package:brew_crew/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on FirebaseUser
   _userFromFirebaseUser(User user){
    return user != null ? TheUser(uid: user.uid) : null;
  }
  //auth change user stream
  Stream <TheUser> get user{
    return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(user));
    }
  //sign in anonymously
Future signInAnon() async {
  try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}
  //sign in with email & pwd
  Future signInWithEmailAndPassword(String email,String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //register with email & pwd
  Future registerWithEmailAndPassword(String email,String password) async{
     try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData('0','new',100);
      return _userFromFirebaseUser(user);
     }catch(e){
       print (e.toString());
       return null;
     }

  }

  //sign out
 Future signOut() async {
     try{
        return await _auth.signOut();
     }catch(e){
       print (e.toString());
       return null;

     }
 }
}