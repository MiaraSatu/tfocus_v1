import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfocus_v_common_2/helper.dart';

class DiscussionsScreen extends StatelessWidget {
  static double MAR = 30; // medium avatar radius
  static List<Message> messages = [
    Message(userImage: "images/avatars/adult_man.jpg", userName: "Armando Moe", userActive: false, messageText: "Je suis ravi de partager mes connaissances avec vous.", sentAt: "12.01 PM"),
    Message(userImage: "images/avatars/photograph.jpg", userName: "Joel Fandida", userActive: true, messageText: "La conférence aura eu lieu le 03 septembre 2024.", sentAt: "10.15 AM"),
    Message(userImage: "images/avatars/square_woman_1.jpg", userName: "Lilia Onana", userActive: true, messageText: "Je peux vous envoyer un lien pour rejoindre notre communauté", sentAt: "07.03 AM"),
    Message(userImage: "images/avatars/old_man.jpg", userName: "Alina Pepe", userActive: true, messageText: "J'apprecis bien les contenus de tes articles mon gars", sentAt: "07.00 AM"),
    Message(userImage: "images/avatars/adult_man.jpg", userName: "Armando Moe", userActive: false, messageText: "Je suis ravi de partager mes connaissances avec vous.", sentAt: "12.01 PM"),
    Message(userImage: "images/avatars/photograph.jpg", userName: "Joel Fandida", userActive: true, messageText: "La conférence aura eu lieu le 03 septembre 2024.", sentAt: "10.15 AM"),
    Message(userImage: "images/avatars/square_woman_1.jpg", userName: "Lilia Onana", userActive: true, messageText: "Je peux vous envoyer un lien pour rejoindre notre communauté", sentAt: "07.03 AM"),
    Message(userImage: "images/avatars/old_man.jpg", userName: "Alina Pepe", userActive: true, messageText: "J'apprecis bien les contenus de tes articles mon gars", sentAt: "07.00 AM"),
    Message(userImage: "images/avatars/adult_man.jpg", userName: "Armando Moe", userActive: false, messageText: "Je suis ravi de partager mes connaissances avec vous.", sentAt: "12.01 PM"),
    Message(userImage: "images/avatars/photograph.jpg", userName: "Joel Fandida", userActive: true, messageText: "La conférence aura eu lieu le 03 septembre 2024.", sentAt: "10.15 AM"),
    Message(userImage: "images/avatars/square_woman_1.jpg", userName: "Lilia Onana", userActive: true, messageText: "Je peux vous envoyer un lien pour rejoindre notre communauté", sentAt: "07.03 AM"),
    Message(userImage: "images/avatars/old_man.jpg", userName: "Alina Pepe", userActive: true, messageText: "J'apprecis bien les contenus de tes articles mon gars", sentAt: "07.00 AM"),
  ];

  static List<Map<String, String>> friends = [
    {
      "name": "Almando Moe",
      "image": "images/avatars/adult_man.jpg"
    },
    {
      "name": "Alina Pepe",
      "image": "images/avatars/old_man.jpg"
    },
    {
      "name": "Joel Fandida",
      "image": "images/avatars/photograph.jpg"
    },
    {
      "name": "Lilia Onana",
      "image": "images/avatars/square_woman_1.jpg"
    },
    {
      "name": "Almando Moe",
      "image": "images/avatars/adult_man.jpg"
    },
    {
      "name": "Alina Pepe",
      "image": "images/avatars/old_man.jpg"
    },
    {
      "name": "Joel Fandida",
      "image": "images/avatars/photograph.jpg"
    },
    {
      "name": "Lilia Onana",
      "image": "images/avatars/square_woman_1.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background
          Positioned.fill(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.purple.shade900, Colors.purple.shade700, Colors.lightBlueAccent],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft
                    )
                ),
              )
          ),
          ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 120),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [

                    // messagesList
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: messages.map((mess) => GestureDetector(
                          onTap: () {
                            /**
                             * Navigator.pushNamed(context, '/discussion', arguments: {
                                "name": mess.userName,
                                "image": mess.userImage
                                });
                             */
                            context.push('/discussion', extra: {
                              "name": mess.userName,
                              "image": mess.userImage
                            });
                          },
                          child: MessageWidget(mess)
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.purple.shade900, Colors.purple.shade800],
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter
                    )
                ),
                padding: EdgeInsets.only(left: 30, right: 30, top: 40),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade700
                            ),
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)
                        ),
                      ),
                    ),
                    // friendsList
                    SizedBox(
                        height: 2 * MAR,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // add button
                            Container(
                              width: 2 * MAR,
                              height: 2 * MAR,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(MAR),
                                  border: Border.all(
                                      color: Colors.grey.shade200,
                                      width: 2
                                  )
                              ),
                              child: Center(
                                child: Icon(Icons.add, color: Colors.white,),
                              ),
                            )
                            , ...friends.map((friend) => Container(
                              width: 2 * MAR,
                              height: 2 * MAR,
                              padding: EdgeInsets.all(3),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(MAR),
                                  border: Border.all(
                                      color: Colors.grey.shade600,
                                      width: 1
                                  )
                              ),
                              child: CircleAvatar(
                                radius: MAR,
                                backgroundImage: AssetImage(friend["image"]!),
                              ),
                            )).toList()
                          ],
                        )
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(message.userImage),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      message.userName,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      )
                  ),
                  Row(
                    children: [
                      (message.userActive)
                          ? Icon(Icons.circle, color: CupertinoColors.systemGreen, size: 10,)
                          : Icon(Icons.circle_outlined, color: Colors.grey.shade500, size: 10),
                      Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            message.userActive ? "Active" : "Inactive",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12
                            ),
                          )
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                    child: Text(
                        message.messageText,
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              child: Text(
                message.sentAt,
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12
                ),
              )
          )
        ],
      ),
    );
  }
}

class Message {
  String userImage;
  String userName;
  bool userActive;
  String messageText;
  String sentAt;

  Message({required this.userImage, required this.userName, required this.userActive, required this.messageText, required this.sentAt});
}