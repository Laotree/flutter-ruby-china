import 'package:intl/intl.dart';

const ISO8601_DATE_FORMAT = "yyyy-MM-dd";
const ISO8601_FORMAT = "yyyy-MM-dd hh:mm:ss";

final DateFormat dateFormatter = DateFormat(ISO8601_DATE_FORMAT);

final DateFormat datetimeFormatter = DateFormat(ISO8601_FORMAT);

String datetimeFormat(DateTime t) {
  return datetimeFormatter.format(t);
}

// fixme
String datetimeStringFormat(String ts) {
  return datetimeFormatter.format(DateTime.parse(ts).toLocal());
}

String dateFormat(DateTime t) {
  return dateFormatter.format(t);
}

String dateStringFormat(String ts) {
  return dateFormatter.format(DateTime.parse(ts));
}
