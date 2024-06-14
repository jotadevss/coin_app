extension FormatList on List<double> {
  List<double> interval(int length) {
    final intervalList = <double>[];
    final list = this;

    list.sort();

    // get first element
    final firstValue = list[0] - (list[0] * 0.3);
    intervalList.add(firstValue);

    // remove the first and next element the in stack sorted list
    list.removeAt(0);
    list.removeAt(0);

    // get last element
    final lastValue = list[list.length - 1] + (list[list.length - 1] * 0.1);
    intervalList.add(lastValue);

    // remove the last and previous element the in stack sorted list
    list.removeAt(list.length - 1);
    list.removeAt(list.length - 1);

    if (intervalList.length == length) {
      return intervalList;
    }

    for (var i = 0; i < list.length; i += list.length - 1) {
      intervalList.add(list[i]);
    }

    intervalList.sort();
    return intervalList;
  }

  Map<int, List<double>> consecutivePointRangeMap() {
    final list = this;
    // Create list points
    final points = List.generate(list.length, (i) => i + 1);

    // Initialize list
    final range = <List<double>>[];

    /*
      Get the the actual value and next value
      ex:   [1, 2, 3] => [[1, 2], [2, 3], [3, 3]]
    */
    for (var i = 0; i < list.length; i++) {
      final slice = list[i];

      // Validate the next value
      final nextSlice = (i == list.length - 1) ? slice : list[i + 1];
      range.add([slice, nextSlice]);
    }

    // Create map
    final map = Map.fromIterables(points, range);

    return map;
  }
}

extension MapperPoints on Map<int, List<double>> {
  List<double> mapValuesToPoints(List<double> list) {
    // Initialize list
    final valuesInRange = <double>[];
    final rangePoints = this;

    for (var value in list) {
      rangePoints.forEach((point, range) {
        /*
          Check if the current value falls within the current 
          range (inclusive lower bound, exclusive upper bound)
      */
        if (value >= range[0] && value < range[1]) {
          // Calculate the result based on the value, point, and lower bound.
          final result = (value * point) / range[0];
          valuesInRange.add(result);
        }

        /*
          Handle edge case: If the range is a single point (lower bound == upper bound) 
          and the value matches the point exactly.
      */
        if (range[0] == range[1] && value == range[0]) {
          valuesInRange.add(point.toDouble());
        }
      });
    }

    return valuesInRange;
  }
}
