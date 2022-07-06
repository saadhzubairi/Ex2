import 'package:flutter/material.dart';
import 'package:fooderlicht/circle_image.dart';
import 'package:fooderlicht/fooderlicht_theme.dart';

class AuthorCard extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: FooderlichTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  ),
                ],
              )
            ],
          ),
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
            ),
            iconSize: _isFavorited ? 35 : 35,
            color: Colors.red[300],
            onPressed: () {
              if (!_isFavorited) {
                SnackBar snackBar =
                    SnackBar(content: Text("Added to Favourites!"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                const snackBar =
                    SnackBar(content: Text("Removed from Favourites!"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              setState(() {
                _isFavorited = !_isFavorited;
              });
            },
          )
        ],
      ),
    );
  }
}
