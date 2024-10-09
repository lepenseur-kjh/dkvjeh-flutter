import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/auth/models/update_fcm_command.dart';
import 'package:dkejvh/data/auth/models/user_sign_in_request.dart';
import 'package:dkejvh/data/auth/models/user_sign_up_command.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthFirebaseService {
  Future<bool> isLoggedIn();
  Future<Either> signUp(UserSignUpCommand command);
  Future<Either> signIn(UserSignInRequest request);
  Future<Either> getUser();
  Future<Either> updateFcmToken(UpdateFcmCommand command);
  Future<Either> logout();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> signUp(UserSignUpCommand command) async {
    try {
      var resp = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: command.email,
        password: command.password,
      );
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(resp.user!.uid)
          .set({
        'email': command.email,
        'socialType': command.socialType,
        'username': command.username,
        'birthDate': command.birthDate,
        'gender': command.gender,
        'createdAt': command.createdAt,
        'userId': resp.user!.uid,
      });
      return const Right("회원가입 성공");
    } on FirebaseAuthException catch (e) {
      String msg = "회원가입 실패";
      if (e.code == "invalid-email") {
        msg = "올바르지 않은 이메일 형식입니다.";
      } else if (e.code == "weak-password") {
        msg = "비밀번호가 취약합니다.";
      } else if (e.code == "email-already-in-use") {
        msg = "이미 가입된 이메일입니다.";
      } else {
        msg = e.code;
      }
      return Left(msg);
    }
  }

  @override
  Future<Either> signIn(UserSignInRequest request) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return const Right("로그인 성공");
    } on FirebaseAuthException catch (e) {
      String msg = "로그인 실패";
      if (e.code == "invalid-email") {
        msg = "가입되지 않은 이메일입니다.";
      } else if (e.code == "invalid-credential") {
        msg = "회원가입을 진행해주세요.";
      } else {
        msg = e.code;
      }
      return Left(msg);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var userData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser?.uid)
          .get()
          .then((e) => e.data());
      return Right(userData);
    } catch (e) {
      return const Left("다시 시도해주세요.");
    }
  }

  @override
  Future<Either> updateFcmToken(UpdateFcmCommand command) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser?.uid)
          .update({
        "fcmToken": command.fcmToken,
        "mobileOS": command.mobileOS,
      });
      return const Right("fcm token 업데이트 성공");
    } catch (e) {
      return const Left("다시 시도해주세요.");
    }
  }

  @override
  Future<Either> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right("로그아웃 성공");
    } catch (e) {
      return const Left("다시 시도해주세요.");
    }
  }
}
