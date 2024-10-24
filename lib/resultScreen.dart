import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/profilMainList.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';

class ResultScreen extends StatefulWidget {
  String q; // queryText
  ResultScreen(this.q, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Publication> publications = [];

  @override
  void initState() {
    Future<List<Publication>> publications = ApiService.searchPublications(widget.q);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultat de ${widget.q}"),
      ),
      body: PublicationListWidget(publications)
    );
  }
}
