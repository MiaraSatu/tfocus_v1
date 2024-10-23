import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/comment.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';

class CommentFormWidget extends StatefulWidget {
  Publication publication;
  CommentFormWidget(this.publication, {super.key});

  @override
  State<CommentFormWidget> createState() => _CommentFormWidgetState();
}

class _CommentFormWidgetState extends State<CommentFormWidget> {
  bool displayForm = false;
  final TextEditingController _commentCtr = TextEditingController();

  void toggleDisplayForm() {
    setState(() {
      displayForm=!displayForm;
    });
  }

  void submitComment() async {
    bool isSuccess  = await ApiService.commentPublication(widget.publication.id, _commentCtr.text);
    if(isSuccess) {
      toggleDisplayForm();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Publication${widget.publication.id} commenté avec succèss")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      (displayForm)
      ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _commentCtr,
                decoration: const InputDecoration(
                  labelText: "Your comment",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                submitComment();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                child: Text(
                  "Commenter",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue
                ),
              ),
            ),
          ],)
      : Container(
        child: IconButton(
          icon: Icon(Icons.comment_outlined),
          onPressed: () => toggleDisplayForm(),
        ),
      );
  }
}
