import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/schedule/models/add_schedule_command.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ScheduleFirebaseService {
  Future<Either> addSchedule(AddScheduleCommand command);
  Future<Either> getSchedules();
  Future<Either> removeSchedule(String scheduleId);
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

  @override
  Future<Either> getSchedules() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var resp = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .collection("Schedules")
          .orderBy("createdAt")
          .get();

      List<Map> scheduels = [];
      for (var item in resp.docs) {
        var data = item.data();
        data.addAll({"id": item.id});
        scheduels.add(data);
      }
      return Right(scheduels);
    } catch (e) {
      return const Left("다시 시도해주세요.");
    }
  }

  @override
  Future<Either> removeSchedule(String scheduleId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .collection("Schedules")
          .doc(scheduleId)
          .delete();
      return const Right('일정이 삭제되었습니다.');
    } catch (e) {
      return const Left("다시 시도해주세요.");
    }
  }
}
