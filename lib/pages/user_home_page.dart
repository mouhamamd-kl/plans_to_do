import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mytest/controllers/categoryController.dart';
import 'package:mytest/services/collectionsrefrences.dart';
import 'package:mytest/services/auth_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task/UserTaskCategory_model.dart';
import 'constants.dart';
import 'custom_widget/category_card.dart';

class UserTaskCategoriesScreen extends StatefulWidget {
  const UserTaskCategoriesScreen({Key? key}) : super(key: key);

  @override
  _UserTaskCategoriesScreenState createState() =>
      _UserTaskCategoriesScreenState();
}

class _UserTaskCategoriesScreenState extends State<UserTaskCategoriesScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  TaskCategoryController controller = Get.put(TaskCategoryController());
  void _addCategory() async {
    final String categoryName = _categoryNameController.text;
    late UserTaskCategoryModel CategoryModel;
    CategoryModel = UserTaskCategoryModel(
      idParameter: userTaskCategoryRef.doc().id,
      userIdParameter: firebaseAuth.currentUser!.uid,
      nameParameter: categoryName,
      createdAtParameter: DateTime.now(),
      updatedAtParameter: DateTime.now(),
    );

    try {
      // if (await exist(
      //         reference: userTaskCategoryRef,
      //         field: "userId",
      //         value: firebaseAuth.currentUser!.uid,
      //         field2: "name",
      //         value2: CategoryModel.name) >=
      //     1) {
      //   exception = Exception("cannot add this category");
      //   throw exception;
      // }
      controller.addCategory(CategoryModel);
      _categoryNameController.clear();
    } on Exception catch (e) {
      print("${e.toString()} hello");
      Get.defaultDialog(title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Task Categories'),
        backgroundColor: PColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _categoryNameController,
              decoration: const InputDecoration(
                hintText: 'Enter category name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(PColor)),
              onPressed: _addCategory,
              child: const Text(
                'Add Category',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Categories:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            StreamBuilder<QuerySnapshot>(
              stream: controller
                  .getUserCategoriesStream(firebaseAuth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('An error occurred.');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final UserTaskCategoryModel category =
                          snapshot.data?.docs[index].data()
                              as UserTaskCategoryModel;
                      return UserTaskCategoryCard(
                        category: category,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
