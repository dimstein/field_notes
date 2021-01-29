import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {

  final TextEditingController titleTEC;
  final TextEditingController authorTEC;
  final TextEditingController clientTEC;
  final TextEditingController locationTEC;
  final TextEditingController referenceTEC;

  const TitleCard({Key key, this.titleTEC, this.authorTEC,
    this.clientTEC, this.locationTEC,
    this.referenceTEC}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Reference'),
            controller: referenceTEC,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleTEC,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'client'),
            controller: clientTEC,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'author'),
            controller: authorTEC,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Location'),
            controller: locationTEC,
          ),
        ],
      ),
    );
  }
}
