import 'package:intl/intl.dart';

class Note {
  Note({
    int? idNote,
    required this.title,
    required this.content,
    this.image,
    this.link,
    String? time,
   this.additionalContents, // lấy nội dung của new line
  })  : 
        time = time ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

  int? idNote;
  final String title;
  final String content;
  String? image;
  String? link;
  final String time;
   List<String>? additionalContents; // lấy nội dung của new line

  Note updateNote({
    String? title,
    String? content,
    String? image,
    String? link,
  }) {
    return Note(
      idNote: idNote,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': idNote,
      'title': title,
      'content': content,
      'image': image,
      'link': link,
      'time': time,
    };
  }
}
