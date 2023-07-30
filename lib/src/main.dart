import 'base.dart';
import 'object.dart';
import 'request.dart';
import 'user.dart';

/// NCMBクラス
/// NCMBクラスは、NCMBの初期化を行うためのクラスです
class NCMB {
  /// アプリケーションキー
  String? applicationKey;

  /// クライアントキー
  String? clientKey;

  /// セッショントークン
  String? sessionToken;

  /// ドメイン
  String? domainUrl;

  ///APIバージョン
  String? apiVersion;

  /// バージョン
  final String sdkVersion = '0.1.0';

  /// SDK 名前
  final String sdkName = 'Dart';

  ///API URL
  static const  String  defaultDomainURL = "https://mbaas.api.nifcloud.com/";

  ///API version
  static const String  defaultAPIVersion = "2013-09-01";

  /// FQDN
  static const String  fqdn = 'mbaas.api.nifcloud.com';

  /// スクリプト用FQDN
  static const  String scriptFqdn = 'script.mbaas.api.nifcloud.com';

  /// APIバージョン
  static const String version = '2013-09-01';

  /// スクリプトAPIバージョン
  static const  String scriptVersion = '2015-09-01';

  /// NCMBクラスのコンストラクタ
  /// アプリケーションキー、クライアントキーを指定して初期化します
  /// [applicationKey] アプリケーションキー
  /// [clientKey] クライアントキー
  NCMB(String applicationKey, String clientKey, {String domainUrl = defaultDomainURL, String apiVersion = defaultAPIVersion}) {
    this.applicationKey = applicationKey;
    this.clientKey = clientKey;
    this.domainUrl = domainUrl;
    this.apiVersion = apiVersion;
    NCMBUser.ncmb = this;
    NCMBObject.ncmb = this;
    NCMBRequest.ncmb = this;
  }
}
