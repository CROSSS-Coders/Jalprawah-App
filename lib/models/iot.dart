class ValueIOT {
  final double value;
  final DateTime time;

  ValueIOT({this.value, this.time});

  double get getValues => value;
  DateTime get getTime => time;
}

class IOTValues {
  final List<ValueIOT> waterSeries;

  IOTValues({this.waterSeries});

  List<ValueIOT> get getWaterValues => waterSeries;

  factory IOTValues.fromJson(Map<String, dynamic> json) {
    List<ValueIOT> waterValues = [];
    for (dynamic value in json['values']) {
      waterValues.add(
        ValueIOT(
          value: value['water_level'],
          time: DateTime.parse(value['created_at']),
        ),
      );
    }
    return IOTValues(
      waterSeries: waterValues,
    );
  }
}
