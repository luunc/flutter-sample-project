import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dog_breed_model.g.dart';

@JsonSerializable()
class DogBreed extends Equatable {
  final String name;
  final String imgUrl;
  final String origin;

  DogBreed({this.name, this.imgUrl, this.origin});

  factory DogBreed.fromMap(Map<String, dynamic> json) =>
      _$DogBreedFromJson(json);

  Map<String, dynamic> toJson() => _$DogBreedToJson(this);

  @override
  List<Object> get props => [name, imgUrl, origin];
}
