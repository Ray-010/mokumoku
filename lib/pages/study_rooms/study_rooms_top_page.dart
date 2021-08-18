import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/study_rooms/add_study_room.dart';

class StudyRooms extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddStudyRoomPage(),
                fullscreenDialog: true,
              ));
              },
            ),
          ),
        ],
        title: Text(
          '勉強部屋',
        ),
        elevation: 0.0,
      ),
      body: Center(child: Text("勉強部屋") // <- (※3)
      ),
    );
  }
}