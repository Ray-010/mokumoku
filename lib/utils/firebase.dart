import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_with_us_test/model/user.dart';
import 'package:study_with_us_test/model/user_room/room_model.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class Firestore {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final userRef = _firestoreInstance.collection('users');
  static final roomRef = _firestoreInstance.collection('rooms');
  

  // SignUp
  static Future signUp(String email, uid) async {
    try {
      _firestoreInstance.collection('users').doc(uid).set({
        'name': 'ゲスト',
        'imagePath': 'https://www.silhouette-illust.com/wp-content/uploads/2017/10/jinbutsu_male_40219-300x300.jpg',
        'email': email,
        'favorite': 0,
        'createdAt': Timestamp.now(),
      });
      await SharedPrefs.setUid(uid); // 端末保存

    } catch(e) {
      print('アカウント作成に失敗しました --- $e');
    }
  }

  // ユーザ情報取得
  static Future<UserProfileModel> getProfile(String uid) async {
    final profile = await userRef.doc(uid).get();
    UserProfileModel myProfile = UserProfileModel(
      name: profile.data()?['name'], 
      imagePath: profile.data()?['imagePath'],
      favorite: profile.data()!['favorite'],
      uid: uid,
    );
    return myProfile;
  }
  
  // roomに入った時、roomのfinishedtimeを取得
  static Future getRestTime(roomId) async{
    final roomDetail = await roomRef.doc(roomId).get();
    final finishedTime = roomDetail.data()!['finishedTime'].toDate();
    final DateTime nowTime = DateTime.now();
    final restTime = finishedTime.difference(nowTime).inSeconds;
    
    return restTime;
  }
  
  // rooms > 部屋のドキュメント > 値・usersのコレクション, 部屋のユーザについての処理
  // 部屋に入るときにroomsのusersにuserを追加
  static Future<void> addUsers(roomId, userDocumentId) async {
    return roomRef
      .doc(roomId)
      .collection('users')
      .doc(userDocumentId)
      .set({'inTime': Timestamp.now(), 'inRoom': true, 'favorite': 0})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
  }
  
  // ローカルで溜めて、最後で追加する処理に後で変える
  // static Future<void> updateGood(userDocumentId, goodCount){
  //   return roomRef
  //       .doc(userDocumentId)
  //       .collection('users')
  //       .doc(userDocumentId)
  //       .update({'good': (goodCount+1).toString()})
  //       .then((value) => print("Good Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }
    // studytopPageの部屋の人数を更新する
  // Future<void> updatePlusMembers(int before) {
  //   return rooms
  //       .doc(widget.documentId)
  //       .update({'members': (before+1).toString()})
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  // 退出→user情報更新
  static Future<void> getOutRoom(roomDocumentId, userDocumentId) {
    // final getOutTime = Timestamp.now();
    // final userStudyResult = roomRef.doc(roomDocumentId).collection('users').doc(userDocumentId);
    // final userProfile = getProfile(userDocumentId);
    return roomRef
        .doc(roomDocumentId)
        .collection('users')
        .doc(userDocumentId)
        .update({'inRoom': false});
    // return updateUserstudyResult(getOutTime, userStudyResult, userProfile);
  }
  // // 退出時ユーザ情報、勉強時間、いいねを更新
  // static Future<void> updateUserstudyResult(getOutTime, userStudyResult, favorite) {
  //   return _firestoreInstance.doc(userProfile.uid).update(
  //     favorite: 
  //   );
  // }

  // 部屋にはいれるかどうか 入れなくなったらモデルのroomInをfalseに変更
  static Future<void> updateRoomIn(documentId, roomIn) {
    return roomRef
        .doc(documentId)
        .update({'roomIn': roomIn })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // 部屋に入っているユーザ取得
  static Future<List> getUsers(String roomId, String myUid, List inRoomUserList) async {
    final getRoomUsers = roomRef.doc(roomId).collection('users');
    final snapshot = await getRoomUsers.get();
    // if(inRoomUserList.length == 0) {
    List roomUsersList = [];
    await Future.forEach(snapshot.docs, (QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
      var user = await getRoomUsers.doc(doc.id).get();
      bool userInRoom = user.data()!['inRoom'];
      if(doc.id != myUid && userInRoom) {
        UserProfileModel user = await getProfile(doc.id);
        RoomUser userProfile = RoomUser(
          name: user.name,
          favorite: user.favorite,
          imagePath: user.imagePath,
        );
        // roomUsersList.add(doc.id);
        roomUsersList.add(userProfile);
      }
    });
    return roomUsersList;
    // } else {
    //   await Future.forEach(snapshot.docs, (QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    //     var user = await getRoomUsers.doc(doc.id).get();
    //     var number = 0;
    //     bool userInRoom = user.data()!['inRoom'];
    //     // inRoomUserListはuserProfileのリスト, uidのみで構成されたリストを作り、それに含まれるかどうかを判定する
    //     if(doc.id != myUid && snapshot.docs.toList().contains(doc.id) && userInRoom) { // inRoomUserListに追加処理
    //       UserProfileModel user = await getProfile(doc.id);
    //       RoomUser userProfile = RoomUser(
    //         name: user.name,
    //         favorite: user.favorite,
    //         imagePath: user.imagePath,
    //       );
    //       inRoomUserList.add(userProfile);
    //     } else if(doc.id != myUid && !userInRoom) { // 退出者の処理
    //       // inRoomUserList.remove(doc.id);
    //     }
    //   });
    //   return inRoomUserList;
    // }
  }
}