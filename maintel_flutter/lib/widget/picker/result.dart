class PickerResult<T> {
  int index;
  T data;
  PickerResult(this.index, this.data);

  @override
  String toString() {
    return "index::$index data::${data.toString()}";
  }
}

class TimePickerResult {
  String dateString;
  DateTime dateTime;

  TimePickerResult(this.dateString, this.dateTime);

  @override
  String toString() {
    return "dateString::$dateString dateTime::${dateTime.toString()}";
  }
}
