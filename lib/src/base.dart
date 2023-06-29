import 'main.dart';
import 'dart:convert';
import 'dart:async';
import 'acl.dart';
import 'request.dart';
import 'geopoint.dart';
import 'package:intl/intl.dart';
import 'user.dart';
import 'object.dart';

/// データストアのオブジェクトを扱うクラス
class NCMBBase {
  /// フィールドデータ
  Map<String, dynamic> _fields = {};
  Map<String, dynamic> get fields => _fields;

  /// クラス名
  String _name = '';
  String get name => _name;

  /// オブジェクトID
  String? objectId;

  /// コンストラクター
  /// [name] クラス名
  /// [fields] フィールドデータ。省略時は空のMap
  NCMBBase(name, Map fields) {
    _name = name;
    fields.forEach((key, value) {
      _fields[key] = fields[key];
    });
  }

  /// フィールドデータをセットする
  /// [name] フィールド名
  /// [value] セットするデータ
  void set(String name, Object value) {
    if (name == 'createDate' || name == 'updateDate') {
      value = DateTime.parse(value as String);
      _fields[name] = value;
      return;
    }
    if (['NCMBUser', 'NCMBObject', 'NCMBFile', 'NCMBPush', 'NCMBInstallation']
        .indexOf(value.runtimeType.toString()) >
        -1) {
      _fields[name] = value;
      return;
    }
    if (name == 'objectId') {
      objectId = value as String;
      _fields[name] = value;
      return;
    }
    if (name == 'acl') {
      if (!(value is NCMBAcl)) {
        var acl = new NCMBAcl();
        acl.sets(value as Map);
        value = acl;
      }
      _fields[name] = value;
      return;
    }
    try {
      var map = value as Map;
      if (map.containsKey('className')) {
        var className = map['className'] as String;
        map.remove('__type');
        map.remove('className');
        print(className);
        switch (className) {
          case 'user':
            var user = NCMBUser();
            user.sets(map);
            value = user;
            break;
          default:
            NCMBObject obj = NCMBObject(className);
            obj.sets(map);
            value = obj;
        }
        _fields[name] = value;
        return;
      }
      if (map.containsKey('__type') && map['__type'] == 'GeoPoint') {
        var geo = NCMBGeoPoint(
            map['latitude'].toDouble(), map['longitude'].toDouble());
        _fields[name] = geo;
        return;
      } else if (map.containsKey('__type') && map['__type'] == 'Date') {
        var format = DateFormat("yyyy-MM-ddTHH:mm:ss.S'Z'");
        _fields[name] = format.parseStrict(map['iso']);
        return;
      }
    } catch (e) {
      _fields[name] = value;
    }
  }

  /// フィールドデータをまとめてセットする
  /// [map] フィールド名をキーにしたマップデータ
  void sets(Map map) {
    map.removeWhere((k, v) => v == null);
    map.forEach((k, v) => set(k, v));
  }

  /// 指定したフィールドが存在するか確認する
  /// [name] フィールド名
  bool containsKey(String name) {
    return _fields.containsKey(name);
  }

  /// 指定したフィールドが存在するか確認する
  /// [name] フィールド名
  bool hasKey(String name) {
    return _fields.containsKey(name);
  }

  /// 指定したフィールドの値を返す
  /// [name] フィールド名
  Object? get(String name) {
    return _fields[name];
  }

  /// 指定したフィールドの値を文字列型として返す
  /// [name] フィールド名
  /// [defaultValue] デフォルト値
  String getString(String name, {String? defaultValue}) {
    if (!_fields.containsKey(name) && defaultValue != null) return defaultValue;
    return _fields[name]! as String;
  }

  /// 指定したフィールドの値を日時型として返す
  /// [name] フィールド名
  /// [defaultValue] デフォルト値
  DateTime getDateTime(String name, {DateTime? defaultValue}) {
    if (!_fields.containsKey(name) && defaultValue != null) return defaultValue;
    return _fields[name]! as DateTime;
  }

  /// 指定したフィールドの値を数値型（int）として返す
  /// [name] フィールド名
  /// [defaultValue] デフォルト値
  int getInt(String name, {int? defaultValue}) {
    if (!_fields.containsKey(name) && defaultValue != null) return defaultValue;
    return _fields[name]! as int;
  }

  /// 挻定したフィールドの値を数値型（double）として返す
  /// [name] フィールド名
  /// [defaultValue] デフォルト値
  double getDouble(String name, {double? defaultValue}) {
    if (!_fields.containsKey(name) && defaultValue != null) return defaultValue;
    if (_fields[name].runtimeType == int) {
      return (_fields[name] as int).toDouble();
    }
    return _fields[name]! as double;
  }

  /// 指定したフィールドの値を真偽値として返す
  /// [name] フィールド名
  /// [defaultValue] デフォルト値
  bool getBool(String name, {bool? defaultValue}) {
    if (!_fields.containsKey(name) && defaultValue != null) return defaultValue;
    return _fields[name]! as bool;
  }

  /// 指定したフィールドの値をリストとして返す
  /// [name] フィールド名
  /// [defaultValue] デフォルト値
  List<dynamic> getList(String name, {List<dynamic>? defaultValue}) {
    if (!_fields.containsKey(name) && defaultValue != null) return defaultValue;
    return _fields[name]! as List;
  }

  /// データをJSON化する
  dynamic toJson() {
    return {
      '__type': 'Pointer',
      'className': _name,
      'objectId': _fields['objectId']
    };
  }

  /// データを文字列化する
  String toString() {
    return json.encode(_fields, toEncodable: myEncode);
  }

  /// 文字列化する際に利用するエンコード関数
  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toUtc().toIso8601String();
    }
    if (item is NCMBAcl ||
        item is NCMBGeoPoint ||
        item is NCMBObject) {
      return item.toJson();
    }
    return item;
  }

  /// 指定したフィールドの値をインクリメンタルする設定にする
  /// [name] フィールド名
  /// [number] インクリメントする値。省略時は1
  void increment(String name, {int number = 1}) {
    if (!_fields.containsKey('objectId')) {
      return set(name, number);
    }
    set(name, {'__op': 'Increment', 'amount': number});
  }

  /// 指定したフィールドに値を追加する
  /// [name] フィールド名
  /// [value] 追加するオブジェクト
  void add(String name, Object value) {
    if (!_fields.containsKey('objectId')) {
      return set(name, value);
    }
    if (!(value is List)) {
      value = [value];
    }
    set(name, {'__op': 'Add', 'objects': value});
  }

  /// 指定したフィールドに値を追加する（すでにある場合は追加しない）
  /// [name] フィールド名
  /// [value] 追加するオブジェクト
  void addUnique(String name, Object value) {
    if (!_fields.containsKey('objectId')) {
      return set(name, value);
    }
    if (!(value is List)) {
      value = [value];
    }
    set(name, {'__op': 'AddUnique', 'objects': value});
  }

  /// 指定したフィールドの値を削除する
  /// [name] フィールド名
  /// [value] 削除するオブジェクト
  void remove(String name, Object value) {
    if (!_fields.containsKey('objectId')) {
      return set(name, value);
    }
    if (!(value is List)) {
      value = [value];
    }
    set(name, {'__op': 'Remove', 'objects': value});
  }

}