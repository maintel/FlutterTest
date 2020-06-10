class PickerResult<T> {
  int index;
  T data;
  PickerResult(this.index, this.data);

  @override
  String toString() {
    return "index::$index data::${data.toString()}";
  }

}
