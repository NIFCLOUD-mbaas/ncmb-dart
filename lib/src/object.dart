import 'main.dart';
import 'dart:convert';
import 'dart:async';
import 'acl.dart';
import 'request.dart';
import 'geopoint.dart';
import 'package:intl/intl.dart';

/// データストアのオブジェクトを扱うクラス
class NCMBObject extends NCMBBase{
  /// NCMBオブジェクト
  static NCMB? ncmb;

  /// クラス名
  String _name = '';

  /// オブジェクトID
  String? objectId;

  /// コンストラクター
  /// [name] クラス名
  /// [fields] フィールドデータ。省略時は空のMap
  NCMBObject(this._name, {Map fields = const {}}) {
    fields.forEach((key, value) {
      _fields[key] = fields[key];
    });
  }


  /// フィールドデータを取得する
  /// 取得したデータは自分自身にセットする
  Future<void> fetch() async {
    if (!_fields.containsKey('objectId')) {
      throw Exception('ObjectId is required.');
    }
    NCMBRequest r = new NCMBRequest();
    Map response = await r.exec('GET', _name, objectId: get('objectId'));
    sets(response);
  }


  /// データを保存する
  Future<void> save() async {
    if (!_fields.containsKey('objectId')) {
      NCMBRequest r = new NCMBRequest();
      Map response = await r.post(_name, _fields);
      sets(response);
    } else {
      NCMBRequest r = new NCMBRequest();
      Map response = await r.put(_name, _fields['objectId'], _fields);
      sets(response);
    }
  }

  /// データを削除する
  Future<bool> delete() async {
    if (!_fields.containsKey('objectId')) {
      throw Exception('objectId is not found.');
    }
    NCMBRequest r = new NCMBRequest();
    Map res = await r.delete(_name, _fields['objectId']);
    return res.keys.length == 0;
  }

}
