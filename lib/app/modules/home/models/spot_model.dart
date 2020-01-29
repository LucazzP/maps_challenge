import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/models/comment_model.dart';
import 'package:desafio_maps/app/shared/extensions.dart';
import 'package:equatable/equatable.dart';

class SpotModel implements Equatable {
  final String name;
  final String description;
  final double rating;
  final String category;
  final String about;
  final List<CommentModel> comments;
  final double lat;
  final double lng;
  final String photo;
  final DocumentReference documentReference;
  final double iconColor;

  SpotModel({
    this.iconColor,
    this.name,
    this.description,
    this.rating,
    this.category,
    this.about,
    this.comments,
    this.lat,
    this.lng,
    this.photo,
    this.documentReference,
  });

  factory SpotModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data;
    json['documentRef'] = doc.reference;
    return SpotModel.fromJson(json);
  }

  factory SpotModel.fromJson(Map<String, dynamic> json) => SpotModel(
        documentReference:
            json.containsKey("documentRef") ? json['documentRef'] : null,
        name: json['name'],
        description: json['description'],
        rating: double.tryParse(json['rating'].toString()),
        category: json['category'],
        about: json['about'],
        comments: json['comments'] == null
            ? null
            : List.from(json['comments'])
                .map((comment) => CommentModel.fromJson(comment))
                .toList(),
        lat: json['lat'],
        lng: json['lng'],
        photo: json['photo'],
        iconColor: double.tryParse(json['iconColor'].toString()),
      );

  static Future<SpotModel> fromReference(DocumentReference reference) async {
    final res = await reference.get();
    return SpotModel.fromDocument(res);
  }

  Map<String, dynamic> toJson() => {
        "name": name.capitalise(),
        "description": description,
        "rating": rating,
        "category": category,
        "about": about,
        "comments": comments == null
            ? []
            : comments.map((comment) => comment.toJson()),
        "lat": lat,
        "lng": lng,
        "photo": photo,
        "iconColor": iconColor,
      };

  @override
  List<Object> get props => [
        name,
        description,
        rating,
        category,
        about,
        comments,
        lat,
        lng,
        photo,
        iconColor,
        documentReference
      ];
}
