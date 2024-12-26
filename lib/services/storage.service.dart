import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/prompt.model.dart';
import '../objectbox.g.dart';

class StorageService {
  late final Store _store;
  late final Box<Scenario> _promptBox = _store.box<Scenario>();

  StorageService._create(this._store);

  static Future<StorageService> create() async {
    final store = await openStore(
      directory: p.join((await getApplicationDocumentsDirectory()).path, "obx"),
      macosApplicationGroup: "openai.realtime.demo",
    );
    return StorageService._create(store);
  }

  List<Scenario> getScenarioList() => _promptBox.getAll();

  Scenario? getScenario(int id) => _promptBox.get(id);
}
