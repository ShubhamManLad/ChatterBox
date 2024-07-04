import 'dart:convert';
import 'dart:typed_data';

import 'package:chatterbox/constants/colors.dart';
import 'package:chatterbox/screens/image_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  String senderId;
  String receiverId;
  String msgId;
  String msg;
  bool isChecked;
  bool isMe;

  String image = '';
  Uint8List bytes = new Uint8List(64);
  ChatItem({super.key,required this.msgId, required this.msg, required this.isChecked,required this.isMe, required this.senderId, required this.receiverId});

  Future<void> getImage() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("images/$msgId");

    // Get the data once
    DatabaseEvent event = await ref.once();

  // Print the data of the snapshot
    image = (event.snapshot.value.toString());

    print(image);
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()async {
        if(msg=='#Photo'){
          await getImage();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageScreen(img: image,)));
        }
        else{
          DatabaseReference ref = FirebaseDatabase.instance.ref("chats/${senderId+receiverId}/$msgId");
          await ref.update({
            "checked": !isChecked,
          });
          ref = FirebaseDatabase.instance.ref("chats/${receiverId+senderId}/$msgId");
          await ref.update({
            "checked": !isChecked,
          });
        }
      },
      onLongPress: ()async{

        if(isMe) {
          DatabaseReference ref = FirebaseDatabase.instance.ref("chats/${senderId+receiverId}/$msgId");
          await ref.remove();
          ref = FirebaseDatabase.instance.ref(
              "chats/${receiverId + senderId}/$msgId");
          await ref.remove();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: (isMe)?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: (isMe)?BorderRadius.only(topLeft: Radius.circular(24),bottomLeft: Radius.circular(24),topRight: Radius.circular(24)):
                BorderRadius.only(topRight: Radius.circular(24),bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24)),
                border: Border.all(color: (!isMe)?primaryColor : Colors.black),
                color: isChecked? secondaryColor : (isMe)?primaryColor : Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(msg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
