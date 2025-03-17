import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final String? id;
  String? url;
  final String? title;
  final String? author;
  String? thumbUrl;

  ImageModel({
    this.id,
    this.url,
    this.title,
    this.author,
    this.thumbUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

class ImageListModel {
  final List<ImageModel> images = [];
  var isLoading = false.obs;
  var error = ''.obs;
}
