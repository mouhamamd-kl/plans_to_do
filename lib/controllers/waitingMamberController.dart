import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytest/controllers/team_member_controller.dart';
import 'package:mytest/controllers/topController.dart';
import 'package:mytest/models/team/waitingMamber.dart';
import 'package:mytest/services/collectionsrefrences.dart';

import '../constants/constants.dart';

class WaitingMamberController extends TopController {
  //جبلي هل الشخص يلي لسع مو قبلان دعوة الانضمام
  Future<WaitingMemberModel> getWaitingMemberById(
      {required String watingmemberId}) async {
    DocumentSnapshot doc =
        await getDocById(reference: watingMamberRef, id: watingmemberId);
    return doc.data() as WaitingMemberModel;
  }

//عرض جميع الأشخاص يلي بعتلن دعوة للانضمام لهل الفريق وماقبلوها لسع
  Future<List<WaitingMemberModel>> getWaitingMembersInTeamId(
      {required String teamId}) async {
    List<Object?>? list = await getListDataWhere(
        collectionReference: teamMembersRef, field: teamIdK, value: teamId);
    List<WaitingMemberModel> listOfMembers = list!.cast<WaitingMemberModel>();
    return listOfMembers;
  }

//عرض  الشخص يلي بعتلو دعوة للانضمام لهل الفريق وماقبلهاا لسع
  Future<WaitingMemberModel> getWaitingMemberByTeamIdAndUserId(
      {required String teamId, required String userId}) async {
    DocumentSnapshot doc = await getDocSnapShotWhereAndWhere(
        collectionReference: teamMembersRef,
        firstField: teamIdK,
        firstValue: teamId,
        secondField: userIdK,
        secondValue: userId);
    return doc.data() as WaitingMemberModel;
  }

//عرض  الشخص يلي بعتلو دعوة للانضمام لهل الفريق وماقبلهاا لسع
  Stream<DocumentSnapshot<WaitingMemberModel>>
      getWaitingMemberByTeamIdAndUserIdStream(
          {required String teamId, required String userId}) {
    Stream<DocumentSnapshot> stream = getDocWhereAndWhereStream(
        collectionReference: teamMembersRef,
        firstField: teamIdK,
        firstValue: teamId,
        secondField: userIdK,
        secondValue: userId);
    return stream.cast<DocumentSnapshot<WaitingMemberModel>>();
  }

//عرض جميع الأشخاص يلي بعتلن دعوة للانضمام لهل الفريق وماقبلوها لسع
  Stream<QuerySnapshot<WaitingMemberModel>> getWaitingMembersInTeamIdStream(
      {required String teamId}) {
    Stream<QuerySnapshot> stream = queryWhereStream(
        reference: teamMembersRef, field: teamIdK, value: teamId);
    return stream.cast<QuerySnapshot<WaitingMemberModel>>();
  }

  Future<DocumentSnapshot> getWaitingMemberDoc(
      {required String waitingmemberId}) async {
    return await getDocById(reference: watingMamberRef, id: waitingmemberId);
  }

  Future<void> addWaitingMamber(
      {required WaitingMemberModel waitingMemberModel}) async {
    Exception exception;
    if (await existInTowPlaces(
        firstCollectionReference: usersRef,
        firstFiled: idK,
        firstvalue: waitingMemberModel.userId,
        secondCollectionReference: teamsRef,
        secondFiled: idK,
        secondValue: waitingMemberModel.teamId)) {
      addDoc(reference: teamMembersRef, model: waitingMemberModel);
    } else {
      exception = Exception("Sorry but Team Or user of this member not found");
      throw exception;
    }
  }

//حذفو بعد الرفض او القبول والانضمام
  Future<void> deleteWaitingMamberDoc({required String waitingmemberId}) async {
    WriteBatch batch = fireStore.batch();
    deleteDocUsingBatch(
        documentSnapshot: await watingMamberRef.doc(waitingmemberId).get(),
        refbatch: batch);
    batch.commit();
  }
}
