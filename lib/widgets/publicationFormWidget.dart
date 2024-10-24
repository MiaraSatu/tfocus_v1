import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';

class PublicationFormWidget extends StatefulWidget {
  const PublicationFormWidget({super.key});

  @override
  State<PublicationFormWidget> createState() => _PublicationState();
}

class _PublicationState extends State<PublicationFormWidget> {
  final TextEditingController _titleCtr = TextEditingController();
  final TextEditingController _contentCtr = TextEditingController();

  void submitPublication(BuildContext content) async {
    bool response = await ApiService.createPublication(1, {
      'title': _titleCtr.text,
      'content': _contentCtr.text,
      'type': "publication"
    });
    if(response) {
      ScaffoldMessenger.of(content).showSnackBar(SnackBar(content: Text("Publication success")));
    }
  }

  void reinitializeForm() {
    setState(() {
      _titleCtr.text = "";
      _contentCtr.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    * Title
    * Image
    * Content
    * Type ("publication", "link")
    * Link
    * */

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleCtr,
          decoration: InputDecoration(
            labelText: "Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _contentCtr,
          decoration: InputDecoration(
              labelText: "Content",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
        ),
        /*Container(
          decoration: BoxDecoration(
            color: Colors.blue
          ),
          child: Text(
            "Publier",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          width: double.infinity,
        ),*/
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () => submitPublication(context),
                child: Text("Publier"),
            ),
            ElevatedButton(
                onPressed: () => reinitializeForm(),
                child: Text("Réinitialiser")
            )
          ],
        )
      ],
    );
  }
}
