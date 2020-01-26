class PlaceTileModel {
  final String title;
  final String subtitle;
  final String placeId;

  PlaceTileModel({
    this.title,
    this.subtitle,
    this.placeId,
  });

  factory PlaceTileModel.fromResult(Map<String, dynamic> json) =>
      PlaceTileModel(
        title: json['structured_formatting']['main_text'],
        subtitle: json['structured_formatting']['secondary_text'],
        placeId: json['place_id'],
      );
}
