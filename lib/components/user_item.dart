import 'package:chatterbox/constants/colors.dart';
import 'package:chatterbox/screens/chat_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  String userId;
  String chatRoomId;
  String name;
  String email;
  String status;
  String receiverId;
  UserItem({super.key, required this.userId, required this.chatRoomId, required this.name, required this.email, required this.status, required this.receiverId});

  Future<String> getImage(String chatRoomId) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("images/$chatRoomId");
    // Get the data once
    DatabaseEvent event = await ref.once();
    // Print the data of the snapshot
    return event.snapshot.value.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: GestureDetector(
        onTap: () async{
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages =
          referenceRoot.child('backgrounds');

          //Create a reference for the image to be stored
          Reference referenceImageToUpload =
          referenceDirImages.child(chatRoomId);
          String imageUrl;
          try {
            imageUrl = await referenceImageToUpload.getDownloadURL();
          } on FirebaseException catch (e) {
            // Caught an exception from Firebase.
            imageUrl = '';
          }

          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(userId: userId, chatRoomId: chatRoomId, name: name, receiverId: receiverId, bg: imageUrl)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: primaryColor)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(color: Colors.white),),
                    Text(email, style: TextStyle(color: Colors.white),),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: (status=='Online')? Colors.green : secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  width: 10,
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

