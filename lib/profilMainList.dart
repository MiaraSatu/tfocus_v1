
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/profileContentChangeNotifier.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';
import 'package:tfocus_v_common_2/widgets/publicationWidget.dart';
import 'package:tfocus_v_common_2/widgets/publicationFormWidget.dart';

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
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) =>
          (currentItem == item)
              ? TextButton(
              onPressed: () {
                changeCurrentItem(item, notifier);
              },
              style: TextButton.styleFrom(
                  // backgroundColor: Colors.white,
                  backgroundColor: Colors.grey.shade300,
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
                  // color: Colors.white,
                  color: Colors.black,
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
    "All": UserPublicationsWidget(),
    "Publications": UserPublicationsWidget(),
    "Articles": UserPublicationsWidget(),
    "Share": UserPublicationsWidget()
  };

  String item;

  MainListContentWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: contents[item]!
    );
  }
}

class UserPublicationsWidget extends StatefulWidget {
  String filter = "all";
  UserPublicationsWidget({super.key});
  @override
  State<UserPublicationsWidget> createState() => _UserPublicationsWidgetState();
}

class _UserPublicationsWidgetState extends State<UserPublicationsWidget> {
  List<Publication> publicationsOfUser = [];

  void fetchUserPublications() async {
    List<Publication> fetched = await ApiService.fetchPublicationsByUser(1);
    setState(() {
      publicationsOfUser = fetched;
    });
  }

  @override
  void initState() {
    fetchUserPublications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PublicationListWidget(publicationsOfUser);
  }
}

class PublicationListWidget extends StatelessWidget {
  List<Publication> publications;
  PublicationListWidget(this.publications, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: publications.map((pub) =>PublicationWidget(pub)).toList()
    );
  }
}