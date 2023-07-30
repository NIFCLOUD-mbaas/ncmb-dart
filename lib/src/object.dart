import 'main.dart';
import 'dart:convert';
import 'dart:async';
import 'acl.dart';
import 'request.dart';
import 'geopoint.dart';
import 'base.dart';
import 'package:intl/intl.dart';

/// データストアのオブジェクトを扱うクラス
class NCMBObject extends NCMBBase{
  /// NCMBオブジェクト
  static NCMB? ncmb;

  /// コンストラクター
  /// [name] クラス名
  /// [fields] フィールドデータ。省略時は空のMap
  NCMBObject(name, {Map fields = const {}}) :
        super(name, fields);

  /// フィールドデータを取得する
  /// 取得したデータは自分自身にセットする
  Future<void> fetch() async {
    if (!fields.containsKey('objectId')) {
      throw Exception('ObjectId is required.');
    }
    NCMBRequest r = new NCMBRequest();
    Map response = await r.exec('GET', name, objectId: get('objectId'));
    sets(response);
  }


  /// データを保存する
  Future<void> save() async {
    if (!fields.containsKey('objectId')) {
      NCMBRequest r = new NCMBRequest();
      Map response = await r.post(name, fields);
      sets(response);
    } else {
      NCMBRequest r = new NCMBRequest();
      Map response = await r.put(name, fields['objectId'], fields);
      sets(response);
    }
  }

  /// データを削除する
  Future<bool> delete() async {
    if (!fields.containsKey('objectId')) {
      throw Exception('objectId is not found.');
    }
    NCMBRequest r = new NCMBRequest();
    Map res = await r.delete(name, fields['objectId']);
    return res.keys.length == 0;
  }

}
