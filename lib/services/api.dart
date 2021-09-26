// import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Api extends GetxService {
  var db = FirebaseFirestore.instance;
  late CollectionReference usersCol;
  late CollectionReference workoutsCol;
  late CollectionReference exercisesCol;
  late CollectionReference dietsCol;
  late CollectionReference foodsCol;

  Api() {
    this.usersCol = db.collection("users");
    this.workoutsCol = db.collection("workouts");
    this.exercisesCol = db.collection("exercises");
    this.dietsCol = db.collection("diets");
    this.foodsCol = db.collection("foods");
  }
  // get
  // Get List of documents(collection)
  Future<List<DocumentSnapshot>> getCollection(
      CollectionReference collectionRef) async {
    final QuerySnapshot<Object?> response = await collectionRef.get();
    return response.docs;
  }

  Future<List> getUsers() async {
    final QuerySnapshot<Object?> response = await usersCol.get();
    return response.docs;
  }

  Future<List> getWorkouts() async {
    final QuerySnapshot<Object?> response = await workoutsCol.get();
    return response.docs;
  }

  Future<List> getExercises() async {
    final QuerySnapshot<Object?> response = await exercisesCol.get();
    return response.docs;
  }

  Future<List> getDiets() async {
    final QuerySnapshot<Object?> response = await dietsCol.get();
    return response.docs;
  }

  Future<List> getFoods() async {
    final QuerySnapshot<Object?> response = await foodsCol.get();
    return response.docs;
  }

  // Get single document by id
  Future<DocumentSnapshot> getDocument(DocumentReference docRef) async {
    final DocumentSnapshot<Object?> response = await docRef.get();
    return response;
  }

  Future<DocumentSnapshot> getAny(String id) async {
    DocumentReference anyDoc = db.doc(id);
    final response = await anyDoc.get();
    return response;
  }

  Future<DocumentSnapshot> getUser(String id) async {
    DocumentReference userDoc = usersCol.doc(id);
    final response = await userDoc.get();
    return response;
  }

  Future<DocumentSnapshot> getWorkout(String id) async {
    DocumentReference workoutDoc = workoutsCol.doc(id);
    final response = await workoutDoc.get();
    return response;
  }

  Future<DocumentSnapshot> getExercise(String id) async {
    DocumentReference exerciseDoc = exercisesCol.doc(id);
    final response = await exerciseDoc.get();
    return response;
  }

  Future<DocumentSnapshot> getDiet(String id) async {
    DocumentReference dietDoc = dietsCol.doc(id);
    final response = await dietDoc.get();
    return response;
  }

  Future<DocumentSnapshot> getFood(String id) async {
    DocumentReference foodDoc = foodsCol.doc(id);
    final response = await foodDoc.get();
    return response;
  }

  // post
  // Create/Replace new document in database
  Future<DocumentReference> postAny(Map data, CollectionReference col) async {
    final response = await col.add(data);
    return response;
  }

  // Future<DocumentReference> postUser(Map user) async {
  //   final response = await usersCol.add(user);
  //   return response;
  // }

  Future<DocumentReference> postWorkout(Map workout) async {
    final response = await workoutsCol.add(workout);
    return response;
  }

  Future<DocumentReference> postExercise(Map exercise) async {
    final response = await exercisesCol.add(exercise);
    return response;
  }

  Future<DocumentReference> postDiet(Map diet) async {
    final response = await dietsCol.add(diet);
    return response;
  }

  Future<DocumentReference> postFood(Map food) async {
    final response = await foodsCol.add(food);
    return response;
  }

  //put
  // Modify document in database if exists, else create new
  Future<void> putUser(String id, Map data) async {
    Future<void> response = usersCol.doc(id).set(data, SetOptions(merge: true));
    return response;
  }

  Future<void> putWorkout(String id, Map data) async {
    Future<void> response =
        workoutsCol.doc(id).set(data, SetOptions(merge: true));
    return response;
  }

  Future<void> putExercise(String id, Map data) async {
    Future<void> response =
        exercisesCol.doc(id).set(data, SetOptions(merge: true));
    return response;
  }

  Future<void> putDiet(String id, Map data) async {
    Future<void> response = dietsCol.doc(id).set(data, SetOptions(merge: true));
    return response;
  }

  Future<void> putFood(String id, Map data) async {
    Future<void> response = foodsCol.doc(id).set(data, SetOptions(merge: true));
    return response;
  }

  //delete
  //Remove a document if it exists
  Future<void> delAny(String id) async {
    DocumentReference anyDoc = db.doc(id);
    final response = await anyDoc.delete();
    return response;
  }

  Future<void> delUser(String id) async {
    DocumentReference userDoc = usersCol.doc(id);
    final response = await userDoc.delete();
    return response;
  }

  Future<void> delWorkout(String id) async {
    DocumentReference workoutDoc = workoutsCol.doc(id);
    final response = await workoutDoc.delete();
    return response;
  }

  Future<void> delExercise(String id) async {
    DocumentReference exerciseDoc = exercisesCol.doc(id);
    final response = await exerciseDoc.delete();
    return response;
  }

  Future<void> delDiet(String id) async {
    DocumentReference dietDoc = dietsCol.doc(id);
    final response = await dietDoc.delete();
    return response;
  }

  Future<void> delFood(String id) async {
    DocumentReference foodDoc = foodsCol.doc(id);
    final response = await foodDoc.delete();
    return response;
  }
}
