import 'package:flutter/cupertino.dart';

class Chat_Model extends ChangeNotifier {
  final int id;
  final String text;
  final bool is_admin;

  Chat_Model({
    required this.id,
    required this.text,
    required this.is_admin,
  });
}
