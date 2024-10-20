import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/Views/list_article_by_category.dart';
import 'package:tfocus_v_common_2/models/article_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tfocus_v_common_2/helper.dart';
import 'search.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

final List<String> explores = [
  "Design UI UX",
  "football",
  "C#",
  "Biologie de synthèse",
  "Réalité augmentée",
  "Mode été 2024",
  "Cerveau social",
  "Psychologie positive",
];

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Article>> populararticles;

  final handler = DBHelper();
  @override
  void initState() {
    super.initState();
    populararticles = handler.getArticles();
  }

  _search(String q) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => SearchScreen(query: q)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController q = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Explorer',
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("images/logo-ispm.png"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                        controller: q,
                        decoration: const InputDecoration(
                          hintText: 'Recherche...',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onSubmitted: _search,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const ListTile(
              title: Text(
                "Populaire",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 230,
              child: FutureBuilder<List<Article>>(
                future: populararticles.then((value) => value.take(5).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No articles found'));
                  } else {
                    final articles = snapshot.data!;
                    return ListView.builder(
                      itemCount: articles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final Article article = articles[index];
                        // return CardHorizontal(article);
                        return PopularCard(article);
                      },
                    );
                  }
                },
              ),
            ),
            const ListTile(
              title: Text("Explorer",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: explores.length,
                  itemBuilder: (context, index) {
                    return CardExplorer(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget CardExplorer(int index) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: AssetImage('assets/images/a ($index).jpg'),
              fit: BoxFit.cover
            ),
          ),
          height: 100,
          child: Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(113, 23, 53, 85),
            child: Text(
              explores[index].toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)
            ),
          )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => SearchScreen(query: explores[index])),
          ),
        );
      },
    );
  }

  Widget PopularCard(article) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Image.network(
              article.image,
              //width: double.infinity,
              //height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(0),
                  color: Colors.white24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(article.title.toString(),
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black,
                                      offset: Offset(2.0, 2.0))
                                ])),
                        subtitle: Text(
                          "il y a ${article.date} jours.",
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      onTap: () => openBrowser(article.url),
    );
  }
}
