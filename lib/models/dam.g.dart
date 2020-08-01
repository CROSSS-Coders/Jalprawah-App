// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dam.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DamInfoAdapter extends TypeAdapter<DamInfo> {
  @override
  final int typeId = 0;

  @override
  DamInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DamInfo(
      damID: fields[0] as int,
      damName: fields[1] as String,
      riverName: fields[2] as String,
      doe: fields[3] as String,
      district: fields[4] as String,
      stationCode: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DamInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.damID)
      ..writeByte(1)
      ..write(obj.damName)
      ..writeByte(2)
      ..write(obj.riverName)
      ..writeByte(3)
      ..write(obj.doe)
      ..writeByte(4)
      ..write(obj.district)
      ..writeByte(5)
      ..write(obj.stationCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DamInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
