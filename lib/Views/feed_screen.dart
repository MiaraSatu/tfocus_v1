import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/services/api_service.dart';
import 'package:tfocus_v_common_2/widgets/publicationWidget.dart';
import '../models/article_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tfocus_v_common_2/helper.dart';
import 'search.dart';
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Publication>> articles;
  List<bool> favoriteStates = [];

  // final handler = DBHelper();
  @override
  void initState() {
    super.initState();
    articles = ApiService.fetchPublications();
    favoriteStates = false_values(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TOPIC FOCUS',
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(165, 33, 149, 243),
                          Color.fromARGB(129, 155, 39, 176)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Recherche...',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onTap: (){             context.go('/explore');}
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list, color: Colors.white),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),Expanded(
                  child: ListView(
                    children: [
                      FutureBuilder<List<Publication>>(
                        future: ApiService.fetchPublications(),
                        builder: (context, AsyncSnapshot<List<Publication>> snapshot) {
                          if(snapshot.hasData) {
                            List<Publication> publications = snapshot.data!;
                            return Column(
                              children: publications.map((pub) => PublicationWidget(pub)).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
                /*
                Expanded(
                  flex: 10,
                  child: FutureBuilder<List<Publication>>(
                      future: articles,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No articles found'));
                        } else {
                          final articles = snapshot.data!;
                          return MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return mansorCard(articles[index], index);
                            });
                        }
                      }),
                )*/
              ],
            ),
    );
  }

  Widget mansorCard(Publication article, index) {
    return GestureDetector(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.file!,
              height: 130,
            ),
            ListTile(
              title: Text(
                article.title.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(article.date == '1'
                  ? "il y a ${article.date} jour"
                  : "il y a ${article.date} jours"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      favoriteStates[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteStates[index] ? Colors.purple : null,
                    ),
                    onPressed: () {
                      setState(() {
                        favoriteStates[index] = !favoriteStates[index];
                      });
                    },
                  ),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.watch_later), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print("To browser!");
        openBrowser(article.link!);
      },
    );
  }

}

