import 'package:flutter/material.dart';

class PicturesCard extends StatelessWidget {

  final TextEditingController picturesTEC;

  const PicturesCard({Key key, this.picturesTEC}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        controller: picturesTEC,
        decoration: InputDecoration(labelText: 'Pictures'),
      ),
    );
  }
}
