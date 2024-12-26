import 'package:objectbox/objectbox.dart';

@Entity()
class Scenario {
  @Id()
  late int id;
  String title;
  String content;

  Scenario(this.title, {this.content = '', this.id = 0});
}
