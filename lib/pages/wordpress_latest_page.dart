import 'package:api_toolbox_t6/models/wordpress_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/http_service.dart';

class WordPressLatest extends StatefulWidget {
  const WordPressLatest({super.key});

  @override
  State<WordPressLatest> createState() => _WordPressLatestState();
}

class _WordPressLatestState extends State<WordPressLatest> {
  final String siteDomain = "blog.playstation.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(siteDomain.toUpperCase()),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // SECCIÓN LOGO
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset(
              "assets/images/playstation_blog_logo.png",
              height: 80,
              errorBuilder: (context, error, stack) =>
                  Icon(Icons.web, size: 80),
            ),
          ),
          Divider(),
          // LISTA DE NOTICIAS
          Expanded(
            child: FutureBuilder<List<WordpressPost>>(
              future: HttpService().getLatestsPosts(siteDomain),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error al cargar datos"));
                }

                final posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            // El resumen de WP viene con etiquetas HTML (<p>...</p>)
                            // Usamos HtmlWidget para limpiarlas
                            HtmlWidget(post.resumen),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                icon: Icon(Icons.launch),
                                label: Text("VISITAR NOTICIA"),
                                onPressed: () =>
                                    launchUrl(Uri.parse(post.link)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
