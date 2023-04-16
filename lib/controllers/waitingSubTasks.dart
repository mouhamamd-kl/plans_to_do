import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytest/controllers/topController.dart';
import 'package:mytest/models/team/waitingSubTasksModel.dart';
import 'package:mytest/services/collectionsrefrences.dart';

import '../constants/constants.dart';

class WatingSubTasksController extends TopController {
  Future<void> addWatingSubTask(
      {required WaitingSubTaskModel waitingSubTaskModel}) async {
    await addDoc(reference: watingSubTasksRef, model: waitingSubTaskModel);
  }

  Future<List<WaitingSubTaskModel>> getWatingSubTasksForMember(
      {required String memberId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: watingSubTasksRef,
        field: "subTask.$assignedToK",
        value: memberId);
    return list!.cast<WaitingSubTaskModel>();
  }

  Stream<QuerySnapshot<WaitingSubTaskModel>> getWatingSubTasksForMemberStream(
      {required String memberId}) {
    return queryWhereStream(
            reference: watingSubTasksRef,
            value: memberId,
            field: "subTask.$assignedToK")
        .cast<QuerySnapshot<WaitingSubTaskModel>>();
  }

  Future<List<WaitingSubTaskModel>> getWatingSubTasksForMainTask(
      {required String mainTaskId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: watingSubTasksRef,
        field: "subTask.$mainTaskIdK",
        value: mainTaskId);
    return list!.cast<WaitingSubTaskModel>();
  }

  Future<List<WaitingSubTaskModel>> getWatingSubTasksForProject(
      {required String projectId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: watingSubTasksRef,
        field: "subTask.$projectIdK",
        value: projectId);
    return list!.cast<WaitingSubTaskModel>();
  }

  Stream<QuerySnapshot<WaitingSubTaskModel>> getWatingSubTasksForProjectStream(
      {required String projectId}) {
    return queryWhereStream(
            reference: watingSubTasksRef,
            field: "subTask.$projectIdK",
            value: projectId)
        .cast<QuerySnapshot<WaitingSubTaskModel>>();
  }

  Stream<QuerySnapshot<WaitingSubTaskModel>>
      getWatingSubTasksFormainTasksStream({required String mainTaskId}) {
    return queryWhereStream(
            reference: watingSubTasksRef,
            value: mainTaskId,
            field: "subTask.$mainTaskIdK")
        .cast<QuerySnapshot<WaitingSubTaskModel>>();
  }

  Future<List<WaitingSubTaskModel>> getAllwatingSubtaksforMamber(
      {required memberId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: projectSubTasksRef,
        field: assignedToK,
        value: memberId);
    return list!.cast<WaitingSubTaskModel>();
  }

  Future<WaitingSubTaskModel> getWatingSubTaskById({required String id}) async {
    return (await getDocById(reference: watingSubTasksRef, id: id)).data()
        as WaitingSubTaskModel;
  }

  Stream<DocumentSnapshot<WaitingSubTaskModel>> getWatingSubTaskByIdStream(
      {required String id}) {
    return getDocByIdStream(reference: watingSubTasksRef, id: id)
        .cast<DocumentSnapshot<WaitingSubTaskModel>>();
  }

  Future<void> deleteWatingSubTask({required String id}) async {
    WriteBatch batch = fireStore.batch();
    deleteDocUsingBatch(
        documentSnapshot: await watingSubTasksRef.doc(id).get(),
        refbatch: batch);
  }
}
