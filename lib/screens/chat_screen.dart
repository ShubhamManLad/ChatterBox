import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatterbox/components/chat_item.dart';
import 'package:chatterbox/constants/colors.dart';
import 'package:chatterbox/constants/styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  String userId;
  String chatRoomId;
  String name;
  String receiverId;
  String bg;
  ChatScreen({super.key, required this.userId, required this.chatRoomId, required this.name, required this.receiverId, required this.bg});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId = '';
  String chatRoomId = '';
  String name = '';
  String receiverId = '';

  String status = 'Offline';
  bool typing = false;


  String msg = '';
  var img = null;
  List chats = [];

  String bg = '';
  

  TextEditingController textEditingController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = widget.userId;
    chatRoomId = widget.chatRoomId;
    name = widget.name;
    receiverId = widget.receiverId;
    bg = widget.bg;

    setUserStatus('Online');

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Disposed");
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("Deactivated");
    setUserStatus("Offline");
  }

  Stream getChats() {
    print(chatRoomId);
    Query ref = FirebaseDatabase.instance.ref("chats/$chatRoomId").orderByChild("messageId");

    Stream<DatabaseEvent> stream = ref.onValue;

    return stream;
  }

  Stream getTyping(){
    print(chatRoomId);
    DatabaseReference ref = FirebaseDatabase.instance.ref("chats/$chatRoomId/stat");

    Stream<DatabaseEvent> stream = ref.onValue;

    return stream;
  }

  void setUserStatus(String stat) async{
    print("stat");
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
    await ref.update({
      "Status": stat,
    });

    FirebaseDatabase.instance
        .ref("chats/${receiverId + userId}/stat")
        .set(stat);
  }

  void handleClick(int item) async{
    switch (item) {
      case 0:
        ImagePicker imagePicker = ImagePicker();
        XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
        print('${file?.path}');

        if (file == null) return;
        //Import dart:core
        String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString();

        /*Step 2: Upload to Firebase storage*/
        //Install firebase_storage
        //Import the library

        //Get a reference to storage root
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages =
        referenceRoot.child('backgrounds');

        //Create a reference for the image to be stored
        Reference referenceImageToUpload =
        referenceDirImages.child(chatRoomId);

        //Handle errors/success
        try {
          //Store the file
          await referenceImageToUpload.putFile(File(file!.path));
          //Success: get the download URL
          String imageUrl = await referenceImageToUpload.getDownloadURL();
          print(imageUrl);
        } catch (error) {
          //Some error occurred
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: StreamBuilder(
            stream: getChats(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done && snapshot.data!=null) {
                var data = jsonDecode(jsonEncode(snapshot.data.snapshot.value));
                String stat;
                try{
                  stat = (data['stat']!=null)?data['stat']:'';

                }on NoSuchMethodError catch(e){
                  stat = '';
                };
                // print(chats);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: TextStyle(color: Colors.white),),
                        (stat=='Typing')?Text('Typing...', style: TextStyle(color: Colors.white70, fontSize: 12),):SizedBox(),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: (stat=='Online' || stat=='Typing')? Colors.green : secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      width: 10,
                      height: 10,
                    )
                  ],
                );
                return (data['stat']=='Typing')?Text('Typing...', style: TextStyle(color: Colors.white70, fontSize: 12),):SizedBox();
              }

              else{
                return SizedBox();
              }
            },

          ),


          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Background Image')),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: (bg!='')? BoxDecoration(
                    image: DecorationImage(image: NetworkImage(bg, scale: 0.1))
                  ): BoxDecoration(),
                  child: StreamBuilder(
                    stream: getChats(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done && snapshot.data!=null) {
                        var data = jsonDecode(jsonEncode(snapshot.data.snapshot.value));
                        chats.clear();
                        try{
                          data.keys.forEach((key){if(key!='stat') chats.add(data[key]);});

                        }on NoSuchMethodError catch(e){

                        };

                        chats.sort((a,b) => b['messageId'].compareTo(a['messageId']));
                        // print(chats);
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return ChatItem(
                              msgId: chats[index]['messageId'],
                              msg: chats[index]['message'],
                              isMe: chats[index]['senderId']==userId,
                              senderId: chats[index]['senderId'],
                              receiverId: chats[index]['receiverId'],
                              isChecked: chats[index]['checked'],
                            );
                          },
                        );
                      }
                      else{
                        return Center(child: (Text("Loading...",)));
                      }
                    },
                  
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          var temp = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if(temp!=null) {
                            setState((){
                              img = File(temp.path);
                              textEditingController.text = '#Photo';
                              msg = '#Photo';
                            });
                          }
                        },
                        style: roundButtonStyle,
                        icon: Icon(Icons.photo, color: Colors.white, size: 28,)),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        textCapitalization: TextCapitalization.sentences,
                        controller: textEditingController,
                        onChanged: (value) {
                          msg = value;
                          if(value==''){
                            FirebaseDatabase.instance
                                .ref("chats/${receiverId + userId}/stat")
                                .set('Online');
                          }
                          else{
                            FirebaseDatabase.instance
                                .ref("chats/${receiverId + userId}/stat")
                                .set('Typing');
                          }
                        },

                        style: TextStyle(
                          color: Colors.white,
                        ),

                        cursorColor: Colors.orangeAccent,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {

                          if(msg!=''){
                            String timestamp =
                                '${DateTime.now().millisecondsSinceEpoch}';
                            String msgId = timestamp + userId;
                            Map<String, dynamic> data = {
                              'senderId': userId,
                              'receiverId': receiverId,
                              'message': msg,
                              'messageId': timestamp + userId,
                              'checked': false
                            };
                            if(msg=='#Photo'){
                              String frame = base64Encode(File(img.path).readAsBytesSync() as List<int>);
                              FirebaseDatabase.instance
                                  .ref("images/$msgId")
                                  .set(frame);
                              img = null;
                            }

                            FirebaseDatabase.instance
                                .ref("chats/$chatRoomId/$msgId")
                                .set(data);
                            FirebaseDatabase.instance
                                .ref("chats/${receiverId + userId}/$msgId")
                                .set(data);

                            FirebaseDatabase.instance
                                .ref("chats/${receiverId + userId}/stat")
                                .set('Online');

                            // SystemChannels.textInput.invokeMethod('TextInput.hide');
                            textEditingController.clear();
                          }
                        },
                        style: roundButtonStyle,
                        icon: Icon(Icons.send, color: Colors.white, size: 24,)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
