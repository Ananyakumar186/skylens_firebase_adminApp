import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    required String imageName,
    required String directoryName,
    required String downloadUrl
}) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}

// flutter pub run build_runner build -> run this command after the above code to generate the code and files.