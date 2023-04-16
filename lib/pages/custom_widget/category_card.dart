import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytest/controllers/categoryController.dart';


import '../../models/task/UserTaskCategory_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../taskscreen.dart';

class UserTaskCategoryCard extends StatelessWidget {
  final UserTaskCategoryModel category;
  TaskCategoryController controller = Get.put(TaskCategoryController());

  UserTaskCategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              controller.deleteCategory(category.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
          onTap: () {
            Get.to(Streamo(
              usercategory: category,
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 0, right: 20, top: 5, bottom: 5),
            width: 180,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromARGB(150, 123, 0, 245)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 123, 0, 245),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    Text(
                      category.name,
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  '${category.createdAt}',
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          )),
    );
  }
}
