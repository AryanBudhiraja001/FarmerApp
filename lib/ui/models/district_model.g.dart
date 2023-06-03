// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) =>
    DistrictModel(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
