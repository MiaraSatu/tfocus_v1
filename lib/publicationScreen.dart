import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/widgets/publicationWidget.dart';

class PublicationScreen extends StatefulWidget {
  Publication publication;
  PublicationScreen(this.publication,{super.key});

  @override
  State<PublicationScreen> createState() => _PublicationScreenState();
}

class _PublicationScreenState extends State<PublicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail de la publication"),
      ),
      body: PublicationWidget(widget.publication),
    );
  }
}
