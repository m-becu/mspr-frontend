import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_html/flutter_html.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:mspr1/details_page.dart';

class ProgrammeConcerts extends StatefulWidget {
  const ProgrammeConcerts ({ Key key }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProgrammeConcerts();
  }
}

class _ProgrammeConcerts extends State<ProgrammeConcerts> {
  @override
  void initState() {
    super.initState();
  }

  wp.WordPress wordPress = wp.WordPress(
    baseUrl: 'https://mspr.lewebicien.fr',
  );

  _fetchPosts() {
    Future<List<wp.Post>> posts = wordPress.fetchPosts(
        postParams: wp.ParamsPostList(
            context: wp.WordPressContext.view,
            postStatus: wp.PostPageStatus.publish,
            orderBy: wp.PostOrderBy.date,
            order: wp.Order.desc,
            includeCategories: [3]
        ),
        fetchAuthor: true,
        fetchFeaturedMedia: false,
        fetchComments: false
    );

    return posts;
  }

  _getPostImage(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(post.featuredMedia.sourceUrl);
  }

  _launchUrl(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Cannot launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Catégorie 2: Messages urgents
     * Catégorie 3: Programmes
     * Catégorie 4: Messages généraux
     * */
    var bgColor = Color(0xff99aab5);
    var category = 4;

    return Material(
        child: FutureBuilder(
          future: _fetchPosts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<wp.Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Scaffold(
              backgroundColor: Color(0xff),
              appBar: AppBar(
                title: Text('Live Events - Programmation'),
                centerTitle: true,
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff2c2f33),
                bottom: PreferredSize(
                    child: Container(
                      color: Color(0xff23272a),
                      height: 2.0,
                    ),
                    preferredSize: Size.fromHeight(2.0)),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    wp.Post post = snapshot.data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(post)
                            )
                        );
                      },
                      child: Container(
                        color: bgColor,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Html(
                              data: post.excerpt.rendered.toString(),
                              defaultTextStyle: TextStyle(color: Colors.white),
                              onLinkTap: (String link) {
                                _launchUrl(link);
                              },
                            )
                        ),
                      ),
                    );
                  }
              ),
            );
          },
        )
    );
  }
}