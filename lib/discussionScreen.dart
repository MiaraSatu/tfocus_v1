import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiscussionScreen extends StatefulWidget {
  Map<String, String> user;
  DiscussionScreen({required this.user});
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState(user: user);
}
class _DiscussionScreenState extends State<DiscussionScreen> {

  List<MessageItem> discussions = [
    MessageItem("Bonjour! Je suis ravi que tu as rejoint notre communauté.", false),
    MessageItem("Espérons le meilleur pour nous tous dans cette communauté. Tout le monde pouraient échanger des idées librement", false),
    MessageItem("Profitons!!", false),
    MessageItem("Merci pour l'accuiel", true),
    MessageItem("N'osez pas de recommander notre communauté à d'autres personnes", false),
    MessageItem("D'accord!", true),
    MessageItem("Bonjour! Je suis ravi que tu as rejoint notre communauté.", false),
    MessageItem("Espérons le meilleur pour nous tous dans cette communauté. Tout le monde pouraient échanger des idées librement", false),
    MessageItem("Profitons!!", true),
  ];

  late Map<String, String> user;
  ScrollController _controller = ScrollController();

  _DiscussionScreenState({required this.user});

  void _scrollToBottom() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/user');
                context.push('/profil');
              },
              child: Container(
                margin: EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundImage: AssetImage(user["image"]!,),
                  radius: 20,
                ),
              ),
            ),
            Text(
              user["name"]!,
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
        backgroundColor: Colors.purple.shade800,
      ),
      extendBodyBehindAppBar: true,
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
                ),
                //image: DecorationImage(
                //  image: AssetImage("images/avatars/photograph.jpg"),
                //  fit: BoxFit.cover
                //)
              ),
            )
          ),
          // content
          ListView(
            controller: _controller,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 75),
                child: Column(
                  children: discussions.map((disc) =>
                    MessageItemWidget(message: disc, user: user,)
                  ).toList(),// MessagesBlocks
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MessageForm(),
          )
        ],
      ),
    );
  }
}

class MessageForm extends StatefulWidget {
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm>{
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 20, right: 20,
        bottom: _isFocused ? MediaQuery.of(context).viewInsets.bottom : 20
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "You message",
                border: InputBorder.none,
              ),
            )
          ),
          // send button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send)
          )
        ],
      ),
    );
  }
}

class MessageItemWidget extends StatelessWidget {
  final MessageItem message;
  final Map<String, String> user;
  MessageItemWidget({required this.message, required this.user});
  @override
  Widget build(BuildContext context) {
    if ((message.content.length > 30)) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: (message.isWe) ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (!message.isWe)
            ? CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(user["image"]!),
              )
            // void container
            : Container(),
            Container(
              width: 250,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: (!message.isWe) ? Colors.white60 : Colors.blue,
                borderRadius: (!message.isWe)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)
                    )
                  : BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16)
                  )
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: (!message.isWe) ? Colors.black : Colors.white,
                  fontSize: 16
                )
              ),
            )
          ]
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
            mainAxisAlignment: (message.isWe) ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              (!message.isWe)
              ? CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(user["image"]!),
              )
              // void container
              : Container(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    color: (!message.isWe) ? Colors.white60 : Colors.blue,
                    borderRadius: (!message.isWe)
                        ? BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16)
                    )
                        : BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16)
                    )
                ),
                child: Text(
                    message.content,
                    style: TextStyle(
                      color: (!message.isWe) ? Colors.black : Colors.white,
                      fontSize: 16
                    )
                ),
              )
            ]
        ),
      );
    }
  }
}

class MessageItem{
  String content;
  bool isWe;
  MessageItem(this.content, this.isWe);
}