import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfocus_v_common_2/profilMainList.dart';
import 'package:tfocus_v_common_2/profileContentChangeNotifier.dart';

class ProfileScreen extends StatelessWidget {
  static double LAR = 8; // little_avatars_radius
  @override
  Widget build(BuildContext context) {
    Widget profilPicWidget = Container(
      width: 102,
      height: 102,
      margin: EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          gradient: LinearGradient(
              colors: [Colors.purple.shade900, Colors.lightBlueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade800,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipOval(
              child: Image.asset(
                  'images/avatars/smiled_woman.jpg',
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
      ),
    );
    Widget nameWidget = Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        "Erga Traore",
        style: TextStyle(
            color: Colors.white,
            fontSize: 22
        ),
      ),
    );
    Widget mailWidget = Text(
      "ergtrr@example.com",
      style: TextStyle(
          color: Colors.white54,
          fontSize: 16,
          fontWeight: FontWeight.w400
      ),
    );
    Widget followStatusWidget = Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // shared link
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.link, color: Colors.white,),
                  Text(
                    "+90",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                      "Articles",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      )
                  )
              )
            ],
          ),
          // follower(s)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(LAR),
                            border: Border.all(
                              color: Colors.white70,
                            )
                        ),
                        child: CircleAvatar(
                          radius: LAR,
                          backgroundImage: AssetImage(
                              'images/avatars/old_man.jpg'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: LAR),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white70,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: LAR,
                          backgroundImage: AssetImage(
                              'images/avatars/photograph.jpg'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2*LAR),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white70,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: LAR,
                          backgroundImage: AssetImage(
                              'images/avatars/square_woman_1.jpg'
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      "1.4K",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    "Follower(s)",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  )
              )
            ],
          ),
          // follow
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(LAR),
                            border: Border.all(
                              color: Colors.white70,
                            )
                        ),
                        child: CircleAvatar(
                          radius: LAR,
                          backgroundImage: AssetImage(
                              'images/avatars/square_woman_1.jpg'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white70,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: LAR,
                          backgroundImage: AssetImage(
                              'images/avatars/smiled_woman.jpg'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2*LAR),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white70,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: LAR,
                          backgroundImage: AssetImage(
                              'images/avatars/photograph.jpg'
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      "224",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    "Follow",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );
    Widget actionsWidget = Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // follow button
          CElevatedButton(
            text: "Follow",
            textSize: 16,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            radius: BorderRadius.circular(15),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            onPressed: () {},
          ),
          // message button
          CElevatedButton(
              text: "Message",
              textSize: 16,
              radius: BorderRadius.circular(15),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              onPressed: () {
                Navigator.pushNamed(context, '/discussion', arguments: {
                  "name": "Erga Traore",
                  "image": "images/avatars/smiled_woman.jpg"
                });
              }
          ),
        ],
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => ProfileContentChangeNotifier(),
      child: Scaffold(
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
                      end: Alignment.bottomLeft,
                    )
                ),
              ),
            ),
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      profilPicWidget,
                      nameWidget,
                      mailWidget,
                      followStatusWidget,
                      actionsWidget,
                      MainListItemWidget(),
                      MainListWidget()
                    ]
                  ),
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}

class CElevatedButton extends StatelessWidget { // CustomElevetedButton
  final String text;
  final double textSize;
  final BorderRadius radius;
  Color backgroundColor;
  Color foregroundColor;
  EdgeInsets padding;
  Function() onPressed;

  CElevatedButton({super.key, required this.text, required this.textSize, required this.radius, required this.backgroundColor,
    required this.foregroundColor, required this.padding, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize
        ),
      ),
    );
  }
}
