
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfocus_v_common_2/profileContentChangeNotifier.dart';

class MainListItemWidget extends StatefulWidget {
  const MainListItemWidget({super.key});

  @override
  _MainListItemWidgetState createState() => _MainListItemWidgetState();
}

class _MainListItemWidgetState extends State<MainListItemWidget> {
  static List items = ["All", "Publications", "Articles", "Share"];
  late String currentItem;

  void changeCurrentItem(String item, ProfileContentChangeNotifier notifier) {
    setState(() {
      currentItem = item;
      notifier.currentItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileContentChangeNotifier notifier = Provider.of<ProfileContentChangeNotifier>(context);
    currentItem = notifier.currentItem;
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) =>
          (currentItem == item)
              ? TextButton(
              onPressed: () {
                changeCurrentItem(item, notifier);
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 4)
              ),
              child: Text(
                item,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                ),
              )
          )
              : TextButton(
            onPressed: () {
              changeCurrentItem(item, notifier);
            },
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4)
            ),
            child: Text(
              item,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),
            ),
          )
          ).toList()
      ),
    );
  }
}

class MainListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileContentChangeNotifier>(
        builder: (context, provider, _) => MainListContentWidget(provider.item)
    );
  }
}

class MainListContentWidget extends StatelessWidget {
  static Map<String, Widget> contents = {
    "All": Text("All is displaied here"),
    "Publications": Text("only publication display here"),
    "Articles": Text("Yes you need to see only shared articles"),
    "Share": Text("only share: pub or articles")
  };

  String item;

  MainListContentWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return contents[item]!;
  }
}