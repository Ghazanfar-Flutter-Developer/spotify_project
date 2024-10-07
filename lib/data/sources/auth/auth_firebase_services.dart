import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/core/constant/app_url.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/data/models/auth/user_model.dart';
import 'package:spotify_project/domain/entities/auth/user_entity.dart';

abstract class AuthFirebaseServices {
  Future<Either<String, String>> signin(SignUserReq signinuserReq);
  Future<Either<String, String>> signup(CreateUserReq createuserReq);
  Future<Either> getUser();
}

class AuthFirebaseServicesImpl extends AuthFirebaseServices {
  @override
  Future<Either<String, String>> signin(SignUserReq signinuserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinuserReq.email.trim(),
        password: signinuserReq.password,
      );
      return const Right('SignIn was Successful');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'auth-credential':
          message = 'Password is Incorrect.';
          break;
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-credential':
          message =
              'The supplied authentication credentials are incorrect or have expired.';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try again later.';
          break;
        case 'operation-not-allowed':
          message = 'Operation not allowed. Please contact support.';
          break;
        default:
          message = 'An unexpected error occurred. Please try again.';
      }
      return Left(message);
    } catch (e) {
      return const Left('An error occurred. Please try again.');
    }
  }

  @override
  Future<Either<String, String>> signup(CreateUserReq createuserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createuserReq.email.trim(),
        password: createuserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createuserReq.fullName,
        'email': data.user?.email,
      });
      return const Right('SignUp was Successful');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The provided password is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists with this email.';
          break;
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        default:
          message = 'An unexpected error occurred. Please try again.';
      }
      return Left(message);
    } catch (e) {
      return const Left('An error occurred. Please try again.');
    }
  }

  @override
  Future<Either<String, String>> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(
            firebaseAuth.currentUser!.uid,
          )
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl =
          firebaseAuth.currentUser?.photoURL ?? AppUrl.defaultImg;
      UserEntity userEntity = userModel.toEntity();
      return right(userEntity.toString());
    } catch (e) {
      return left('An error has been Occurred');
    }
  }
}
