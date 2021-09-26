import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'api.dart';

class Session extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User firebaseUser = FirebaseAuth.instance.currentUser!;
  // SharedPreferences prefs = SharedPreferences.getInstance();
  RxBool isLoggedIn = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late DocumentReference userRef;
  late DocumentSnapshot userData;
  // DocumentReference currWorkoutRef;
  // DocumentSnapshot workoutData;
  // DocumentSnapshot dietData;
  Api api = Get.find<Api>();
  RxBool isLoading = false.obs;
  void initState() {
    isSignedIn();
  }

  void isSignedIn() async {
    isLoading.value = true;
    isLoggedIn.value = await _googleSignIn.isSignedIn();
    if (isLoggedIn.value) {
      bool existsUser = await initializeUser();
      if (existsUser) {
        Get.offAllNamed('/home');
      } else {
        Get.toNamed('/setup');
      }
    }

    isLoading.value = false;
  }

  Future<Null> handleSignIn() async {
    isLoading.value = true;
    bool existsUser = await initializeUser();
    Get.snackbar("Success", "Sign in success");
    isLoading.value = false;
    if (existsUser) {
      print("unga bunga");
      // Navigator.pushNamed(context, "Setup");
      Get.offAllNamed('/home');
    } else {
      print("not unga bunga");
      Get.toNamed('/setup');
    }
  }

  Future<void> fetchUser() async {
    print("fetchUser");
    userRef = db.collection("users").doc(firebaseUser.uid);
    userData = await api.getUser(firebaseUser.uid);
  }

  Future<bool> initializeUser() async {
    print("initializeUser");
    await signIn();
    await fetchUser();
    if (userData.exists) {
      print("UserData present on firestore");
      return true;
    } else {
      print("UserData not present on firestore");
      return false;
    }
    // print(userData.data());
    // Save Default Data to local preferences
    // await prefs.setString('id', firebaseUser.uid);
    // await prefs.setString('nickname', firebaseUser.displayName);
    // await prefs.setString('photoUrl', firebaseUser.photoURL);
    // print(UserData.data());
    // Load Data from Cloud to local preferences
    // await prefs.setString('id', UserData.get('id'));
    // await prefs.setString('nickname', UserData["nickname"]);
    // await prefs.setString('photoUrl', UserData[0].data()['photoUrl']);
    // await prefs.setString('aboutMe', UserData[0].data()['aboutMe']);
    // return existsUser;
  }

  Future<void> signIn() async {
    print("signIn");
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final AuthCredential _credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("GoogleAuth Credentials done");
    firebaseUser =
        (await FirebaseAuth.instance.signInWithCredential(_credential)).user!;
  }

  Future<void> signOut() async {
    // await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }

  //Create new user data using firebase uid
  Future<void> createUser(Map userData) async {
    await api.putUser(firebaseUser.uid, userData);
    return;
  }

// Future<void> getCurrWorkout() async {
//   String id = userData.get("currWorkout");
//   print(id);
//   workoutData = await api.getWorkout(id);
//   return workoutData;
// }
//
// Future<void> getCurrDiet() async {
//   String id = userData.get("currDiet");
//   print(id);
//   dietData = await api.getDiet(id);
//   return dietData;
// }
}

class StateData {
  StateData._privateConstructor();

  Api api = Api();

  static final StateData _instance = StateData._privateConstructor();

  factory StateData() {
    return _instance;
  }
}
