
import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';
import 'package:tfocus_v_common_2/widgets/commentFormWidget.dart';

import '../models/publication.dart';

class PublicationWidget extends StatelessWidget {
  final Publication publication;

  PublicationWidget(this.publication, {super.key});

  void likePublication(BuildContext context) async {
    bool likeSend = await ApiService.likePublication(52);
    if(likeSend) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Publication liked")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // publication owner
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(publication.owner!.profilePicUrl != null ? publication.owner!.profilePicUrl! : "images/avatars/old_man.jpg"),
                  ),
                  Text(publication.owner!.firstName, style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),),
                ],
              ),
              Text(
                publication.date!,
              ),
            ],
          ),
          */
          // publication title
          (publication.title != null ) ? Text(publication.title!, style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),) : Container(),
          // publication image
          (publication.file != null ) ? Image.asset(publication.file!, fit: BoxFit.cover,) : Container(),
          // publication text content
          (publication.content != null) ? Text(publication.content!) : Container(),
          // zone de text de commentaire
          CommentFormWidget(publication),
          // LIKE
          Row(
            children: [
              IconButton(
                onPressed: () => likePublication(context),
                icon: Icon(Icons.thumb_up_alt_outlined),
              ),
              Text(publication.likeCount.toString()),
            ],
          )
        ],
      ),
    );
  }
}