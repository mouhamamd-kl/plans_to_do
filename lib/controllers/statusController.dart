import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytest/constants/constants.dart';
import 'package:mytest/controllers/topController.dart';
import 'package:mytest/models/statusmodel.dart';
import 'package:mytest/services/collectionsrefrences.dart';

class StatusController extends TopController {
  Future<List<StatusModel>> getAllStatuses() async {
    List<Object?>? list = await getAllListDataForRef(refrence: statusesRef);
    return list!.cast<StatusModel>();
  }

  Future<void> addStatus(StatusModel statusModel) async {
    Exception exception;
    bool exist = await existByOne(
        collectionReference: statusesRef,
        //!
        value: statusModel.name,
        field: nameK);
    if (exist) {
      throw exception = Exception("status already Exist");
    }
    await addDoc(model: statusModel, reference: statusesRef);
  }

  Future<void> deleteStatus(String id) async {
    DocumentSnapshot documentSnapshot =
        await getDocById(reference: statusesRef, id: id);
    WriteBatch batch = fireStore.batch();
    deleteDocUsingBatch(documentSnapshot: documentSnapshot, refbatch: batch);
    batch.commit();
  }

  Future<void> updateStatus(StatusModel statusModel) async {
    Exception exception;
    DocumentSnapshot? snapshot = await getDocSnapShotWhereAndNotWhere(
      collectionReference: statusesRef,
      field: nameK,
      value: statusModel.name,
      notField: idK,
      notValue: statusModel.id,
    );
    if (snapshot == null) {
      await addDoc(model: statusModel, reference: statusesRef);
      return;
    } else {
      exception = Exception("status name is already defined");
      throw exception;
    }
  }
}
