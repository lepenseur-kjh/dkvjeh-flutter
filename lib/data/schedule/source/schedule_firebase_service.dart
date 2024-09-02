import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ScheduleFirebaseService {
  Future<Either> addSchedule(AddScheduleCommand command);
}

class ScheduleFirebaseServiceImpl extends ScheduleFirebaseService {
  @override
  Future<Either> addSchedule(AddScheduleCommand command) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .collection("Schedules")
          .add(command.toMap());
      return const Right("일정이 등록되었습니다.");
    } catch (e) {
      return const Left("다시 시도해주세요.");
    }
  }
}
