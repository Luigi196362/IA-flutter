import 'dart:convert';
import 'dart:typed_data';

class ImageItem {
  final int id;
  final String name;
  final String classification;
  final String contentType;
  final Uint8List data;

  ImageItem({
    required this.id,
    required this.name,
    required this.classification,
    required this.contentType,
    required this.data,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      id: json['id'],
      name: json['name'],
      classification: json['classification'],
      contentType: json['contentType'],
      data: base64Decode(json['data']),
    );
  }
}
