import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {

  wp.Post post;

  DetailsPage(this.post);

  _getPostImage() {
    if (post.featuredMedia == null) {
      return SizedBox(height: 10,);
    } else {
      return Image.network(post.featuredMedia.sourceUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Events'),
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
      body: Container(
          color: const Color(0xff2c2f33),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Text(
                  post.title.rendered.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                _getPostImage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(post.date.replaceAll('T', ' '), style: TextStyle(color: Colors.white)),
                    Text(post.author.name.toString(), style: TextStyle(color: Colors.white))
                  ],
                ),
                Html(
                  data: post.content.rendered,
                  defaultTextStyle: TextStyle(color: Colors.white),
                  onLinkTap: (String url) {
                    _launchUrl(url);
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}

_launchUrl(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Cannot launch $link';
  }
}