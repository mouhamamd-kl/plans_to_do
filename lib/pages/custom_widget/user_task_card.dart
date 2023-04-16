import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/User/User_task_Model.dart';

class UserTaskWidget extends StatefulWidget {
  final UserTaskModel task;

  const UserTaskWidget({super.key, required this.task});

  @override
  UserTaskWidgetState createState() => UserTaskWidgetState();
}

class UserTaskWidgetState extends State<UserTaskWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.grey[200])
        .animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) => Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: _colorAnimation.value,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.task.description ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      'Due ${widget.task.endDate}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                // Row(
                //   children: [
                //     Icon(Icons.person_outline, color: Colors.grey[600]),
                //     SizedBox(width: 5),
                //     Text(
                //       'Assigned to: ${widget.task.assignedTo}',
                //       style: TextStyle(
                //         fontSize: 16,
                //         color: Colors.grey[600],
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.priority_high, color: Colors.red),
                    const SizedBox(width: 5),
                    Text(
                      'Importance: ${widget.task.importance}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
