// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_breed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DogBreed _$DogBreedFromJson(Map<String, dynamic> json) {
  return DogBreed(
    name: json['name'] as String,
    imgUrl: json['imgUrl'] as String,
    origin: json['origin'] as String,
  );
}

Map<String, dynamic> _$DogBreedToJson(DogBreed instance) => <String, dynamic>{
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'origin': instance.origin,
    };
