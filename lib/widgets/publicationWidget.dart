
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfocus_v_common_2/models/article_model.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';
import 'package:tfocus_v_common_2/services/stringFormater.dart';
import 'package:tfocus_v_common_2/widgets/commentFormWidget.dart';

import '../models/publication.dart';

class PublicationWidget extends StatefulWidget {
  final Publication publication;

  PublicationWidget(this.publication, {super.key});

  @override
  State<PublicationWidget> createState() => _PublicationWidgetState();
}

class _PublicationWidgetState extends State<PublicationWidget> {
  // var random = Random();
  int likeCount = 0;
  bool displayForm = false;
  bool liked = false;
  String imagePath = images[Random().nextInt(4)];

  static List<String> images = [
    "images/ext2.jpg",
    "images/externalisation-de-la-paie.jpg",
    "images/iob.jpg",
    "images/logo-ispm.png",
  ];

  @override
  void initState() {
    likeCount += widget.publication.likeCount;
    super.initState();
  }

  void toggleDisplayForm() {
    setState(() {
      displayForm=!displayForm;
    });
  }

  void likePublication(BuildContext context) async {
    bool likeSend = await ApiService.likePublication(widget.publication.id);
    if(likeSend) {
      if(liked) {
        setState(() {
          liked = false;
          likeCount = likeCount - 1;
        });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("disliked success")));
      }
      else {
        setState(() {
          liked = true;
          likeCount = likeCount + 1;
        });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Publication liked")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // publication owner
          (widget.publication.owner != null)
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(widget.publication.owner!.profilePicUrl != null ? widget.publication.owner!.profilePicUrl! : "images/avatars/old_man.jpg"),
                    ),
                    Text(widget.publication.owner!.firstName, style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),
                  ],
                ),
                // DATE
                (widget.publication.date != null)
                ? Text(
                  widget.publication.date!,
                )
                :Container(),
              ],
            )
            : Container(),
          GestureDetector(
            onTap: () async {
              if(widget.publication.link != null) {
                openBrowser(widget.publication.link!);
              } else {
                context.push("/publication", extra: widget.publication);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // publication title
                (widget.publication.title != null ) ? Text(widget.publication.title!, style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                ),) : Container(),
                // publication image
                // (widget.publication.file != null ) ? Image.network(StringFormater.removeSlash(widget.publication.file!), fit: BoxFit.cover,) : Container(),
                Image.asset(imagePath),
                // publication text content
                (widget.publication.content != null) ? Text(widget.publication.content!) : Container(),
              ],
            ),
          ),
          // LIKE AND COMMENT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => likePublication(context),
                    icon: Icon(liked? Icons.favorite : Icons.favorite_border, color: Colors.blueAccent,),
                  ),
                  likeCount != 0 ? Text(likeCount.toString()) : Container(),
                ],
              ),
              Container(
                child: IconButton(
                  icon: displayForm
                      ? Icon(Icons.cancel_outlined)
                      : Icon(Icons.comment_outlined)
                  ,
                  onPressed: () => toggleDisplayForm(),
                ),
              )
            ],
          ),
          // zone de text de commentaire
          displayForm ? CommentFormWidget(widget.publication) : Container(),
        ],
      ),
    );
  }
}