import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/widgets/publicationFormWidget.dart';
import 'package:tfocus_v_common_2/widgets/publicationWidget.dart';

class AddPublicationScreen extends StatelessWidget {
  AddPublicationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Créer une nouvelle publication"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: PublicationFormWidget(),
      ),
    );
  }
}
