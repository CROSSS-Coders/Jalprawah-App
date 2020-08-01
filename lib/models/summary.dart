class Summary {
  final int total;
  final int normal;
  final int warning;
  final int danger;

  Summary({
    this.total,
    this.normal,
    this.warning,
    this.danger,
  });

  int get getTotal => total;
  int get getNormal => normal;
  int get getWarning => warning;
  int get getDanger => danger;
}
