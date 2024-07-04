import 'dart:convert';
import 'package:chatterbox/components/user_item.dart';
import 'package:chatterbox/constants/colors.dart';
import 'package:chatterbox/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  String id;
  HomeScreen({super.key, required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String id = '';
  List users = [];

  Stream getUsers() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");

    // Get the Stream
    Stream<DatabaseEvent> stream = ref.onValue;
    return stream;
  }

  void getUserList() async{

    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    DatabaseEvent event = await ref.once();

    // Print the data of the snapshot
    var data = jsonDecode(jsonEncode(event.snapshot.value));
    data.keys.forEach((key){users.add(data[key]);});
    print(users);

  }

  Future<void> getUserId() async {
    id =await FirebaseAuth.instance.currentUser!.uid;
    print(id);
    setUserStatus('Offline');
  }

  void setUserStatus(String stat) async{
    print("stat");
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$id");
    await ref.update({
      "Status": stat,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    // setUserStatus("Online");
    // getUserList();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          shape: CircleBorder(),
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
          },
          child: Icon(
            Icons.logout
          ),
        ),
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: getUsers(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done && snapshot.data!=null) {
                    var data = jsonDecode(jsonEncode(snapshot.data.snapshot.value));
                    users.clear();
                    data.keys.forEach((key){if(id!=data[key]['userId'])users.add(data[key]);});
                    print(users);
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserItem(
                          userId: id,
                          receiverId: users[index]['userId'],
                          chatRoomId:id+users[index]['userId'],
                          email: users[index]['email'],
                          name: users[index]['name'],
                          status: users[index]['Status'],
                        );
                      },
                    );
                  }
                  else{
                    return Center(child: (Text("Loading...",)));
                  }
                },

              ),
            )
          ],
        ),
      ),
    );
  }
}
