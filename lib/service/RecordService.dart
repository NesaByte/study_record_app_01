import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/repository/RecordRepository.dart';

class RecordService {

  static bool validate(final Record model) {
    try {
      if (model.title != null) return false;
      if (model.kind != null) return false;
      if (model.iconCodePoint != null) return false;
      if (model.iconFontFamily != null) return false;
      if (model.fromDate.length != 12) return false;
      if (int.parse(model.fromDate) > 0) return false;
      if (model.toDate.length != 12) return false;
      if (int.parse(model.toDate) > 0) return false;
      return true;
    } catch (e) {
      print("Exception occured in RecordService#validate");
      print(e);
      return false;
    }
  }
  // TODO: refactor - return errorMessage List
  // static List<String> validate(final Record model) {}

  static Future<List<Record>> selectAll() async {
    return RecordRepository.selectAll();
  }

  static Future<List<Record>> selectFixedFromDateRecords(final int basisDate) async {
    List<Record> result = [];
    final List<Record> dtos = await selectAll();
    dtos.forEach((dto) {
      int dtoFromDate = int.parse(dto.fromDate.substring(0, 9));
      int dtoToDate = int.parse(dto.fromDate.substring(0, 9));
      if (dtoFromDate <= basisDate && basisDate <= dtoToDate) {
        result.add(dto);
      }
    });
    return result;
  }

  static Future<int> insert(final Record model) async {
    if (validate(model)) {
      final int recentId = (await RecordRepository.selectAll()).length;
      model.id = recentId + 1;
      model.version = 0;
      return RecordRepository.insert(model);
    } else {
      throw('Failed to create Record.');
    }
  }
}
