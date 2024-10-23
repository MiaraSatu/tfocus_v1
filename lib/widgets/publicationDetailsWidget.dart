import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfocus_v_common_2/models/comment.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';
import 'package:tfocus_v_common_2/widgets/commentFormWidget.dart';
import 'package:tfocus_v_common_2/widgets/commentWidget.dart';
import 'package:tfocus_v_common_2/widgets/publicationWidget.dart';


class PublicationDetailsWidget extends StatefulWidget {
  final Publication publication;

  PublicationDetailsWidget(this.publication, {super.key});

  @override
  State<PublicationDetailsWidget> createState() => _PublicationDetailsWidgetState();
}

class _PublicationDetailsWidgetState extends State<PublicationDetailsWidget> {
  int likeCount = 0;
  bool displayForm = false;

  @override
  void initState() {
    likeCount = widget.publication.likeCount;
    super.initState();
  }

  void toggleDisplayForm() {
    setState(() {
      displayForm=!displayForm;
    });
  }

  void likePublication(BuildContext context) async {
    bool likeSend = await ApiService.likePublication(52);
    if(likeSend) {
      setState(() {
        likeCount = likeCount + 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Publication liked")));
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
                    backgroundImage: AssetImage(widget.publication.owner!.profilePicUrl != null ? widget.publication.owner!.profilePicUrl! : "images/avatars/old_man.jpg"),
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
            onTap: () {
              context.push("/publication", extra: widget.publication);
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
                (widget.publication.file != null ) ? Image.asset(widget.publication.file!, fit: BoxFit.cover,) : Container(),
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
                    icon: Icon(Icons.thumb_up_alt_outlined),
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
          // lites des commentaires
          FutureBuilder(
            future: ApiService.fetchComments(widget.publication.id),
            builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
              if(snapshot.hasData) {
                List<Comment> comments = snapshot.data!;
                return Column(
                  children: comments.map(
                      (comment) => CommentWidget(comment)
                  ).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          )
        ],
      ),
    );
  }
}
