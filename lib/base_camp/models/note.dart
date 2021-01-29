
import 'dart:ui';

class Note {
  final String reference;
  final String title;
  final String client;
  final String author;
  final String location;
  final String note;
  final List pictures;
  final String urk; //unique reference key
  final List zearch;

  Note({this.reference,this.title, this.client, this.author, this.location,
    this.note, this.pictures, this.urk, this.zearch});


  factory Note.fromMap(Map<String, dynamic> data){
    if (data == null) {
      return null;
    }
    final String reference = data['reference'];
    final String title = data['title'];
    final String client = data['client'];
    final String author = data['author'];
    final String location = data['location'];
    final String note = data['notes'];
    final List pictures = data['pictures'];
    final String urk = data['urk'];
    final List zearch = data['zearch'];
    return Note(
        reference: reference,
        title: title,
        client: client,
        author: author,
        location: location,
        note: note,
        pictures: pictures,
        urk: urk,
        zearch: zearch
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'title': title,
      'client': client,
      'author': author,
      'location': location,
      'note': note,
      'pictures': pictures,
      'urk': urk,
      'zearch': zearch
    };
  }


  @override
  int get hashCode => hashValues(reference,title, client, author, location, note,
      pictures, urk, zearch);

  @override
  bool operator == (other){
    if(identical(this, other)) return true;
    if(runtimeType != other.runtimeType) return false;
    final Note otherNote = other;
    return reference == otherNote.reference &&
        title == otherNote.title &&
      client == otherNote.client &&
        author == otherNote.author &&
        location == otherNote.location &&
        note == otherNote.note &&
        pictures == otherNote.pictures &&
        urk == otherNote.urk &&
        zearch == otherNote.zearch;
  }

  @override
  String toString()=>
      'reference: $reference, title: $title, client: $client, author: $author, '
      'location: $location, note: $note, pictures: $pictures, urk: $urk, zearch: $zearch';
}