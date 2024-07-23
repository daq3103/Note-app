import 'dart:math';
import 'dart:convert';
import 'package:intl/intl.dart';

class Note {
  
  Note({
    int? idNote,
    required this.title,
    required this.content,
    this.image,
    this.link,
    String? time,
   this.additionalContents, 
  })  : idNote = idNote ?? Random().nextInt(1000000), 
        time = time ?? DateFormat('dd/MM/yyyy').format(DateTime.now());

  int idNote;
  final String title;
  final String content;
  String? image;
  String? link;
  final String time;
   List<dynamic>? additionalContents; 
// function update information Note
updateNote({
    String? title,
    String? content,
    String? image,
    String? link,
    List<String>? additionalContents,
  }) {
    return Note(
      idNote: idNote,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      link: link ?? this.link,
      time: time,
      additionalContents: additionalContents ?? this.additionalContents,
    );
  }
//Note => Map
  Map<String, dynamic> toMap() {
    return {
      'id': idNote,
      'title': title,
      'content': content,
      'image': image,
      'link': link,
      'time': time,
      'additionalContents': jsonEncode(additionalContents),
    };
  }
}
