import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/comment.dart';

class CommentWidget extends StatelessWidget {
  Comment comment;
  CommentWidget(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          // owner
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image.network(comment.owner.profilePicUrl!),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: comment.owner.profilePicUrl != null ?  AssetImage(comment.owner.profilePicUrl!) : AssetImage("images/avatars/adult_man.jpg"),
                    radius: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(comment.owner.firstName)
                  ),
                ],
              ),
              Row(
                children: [
                  // like icon
                  IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up_alt_outlined, size: 15,)),
                  // likecount
                  comment.likeCount != 0 ? Text(comment.likeCount.toString()) : Container()
                ],
              )
            ],
          ),
          // content
          Text(comment.content),
        ],
      ),
    );
  }
}
