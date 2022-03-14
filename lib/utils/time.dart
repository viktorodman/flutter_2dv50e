String convertDateTimeToString(DateTime time) {
  final localDay = time.toLocal().toString();
  final splitted = localDay.split(' ');
  //return '${time.year.toString()}-${time.month.toString()}-${time.day.toString()}';
  return splitted.first;
}
