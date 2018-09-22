import 'package:dart_json_mapper/annotations.dart';
import 'package:dart_json_mapper/converters.dart';
import 'package:intl/intl.dart';

class CustomDateConverter implements ICustomConverter<DateTime> {
  const CustomDateConverter() : super();

  @override
  DateTime fromJSON(dynamic jsonValue, [JsonProperty jsonProperty]) {
    if(jsonValue == null) return null;

    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

    if (jsonValue is String) {
      return format != null
          ? format.parse(jsonValue)
          : DateTime.parse(jsonValue);
    }

    return jsonValue;
  }

  @override
  dynamic toJSON(DateTime object, [JsonProperty jsonProperty]) {
    if(object == null) return null;

    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    return format != null && !(object is String)
        ? format.format(object)
        : object.toString();
  }
}