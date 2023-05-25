# Flutter SDK for NIFCLOUD mobile backend

# 概要

ニフクラ mobile backend Kotlin SDKは、 モバイルアプリのバックエンド機能を提供するクラウドサービス ニフクラ mobile backend用のFlutter SDKであり、dartで開発されたSDKです。

  - データストア　(開発中)
  - 会員管理　(開発中)
  - プッシュ通知 (開発中)
  - 位置情報　(開発中)
  - ファイルストア　(開発中)
  - スクリプト　(開発中)
  - SNS連携　(開発中)

といった機能をアプリから利用することが可能です。

このSDKを利用する前に、ニフクラ mobile backendのアカウントを作成する必要があります。 ニフクラ mobile backendのサービスサイトからアカウント登録を行ってください。

# 動作環境

本SDKは、以下の環境にて動作確認を行っております。
- Android x.x ～ y.y
- API levels 26 ～ 33
- Android Studio 2020.3.1 Patch 2 ～ 2021.3.1
- iOS x.x〜y.y
(※2023年XX月時点)

## テクニカルサポート窓口対応バージョン

テクニカルサポート窓口では、1年半以内にリリースされたSDKに対してのみサポート対応させていただきます。<br>
定期的なバージョンのアップデートにご協力ください。<br>
※なお、mobile backend にて大規模な改修が行われた際は、1年半以内のSDKであっても対応出来ない場合がございます。<br>
その際は[informationブログ](https://mbaas.nifcloud.com/info/)にてお知らせいたします。予めご了承ください。

- v1.0.0 ～ (※2023年XX月時点)

# インストール

import 'package:ncmb/ncmb.dart';
NCMB('YOUR_APPLICATION_KEY', 'YOUR_CLIENT_KEY');

# サンプル

[example.md](./example/readme.md)をご確認ください。

# ライセンス

こちらのSDKは[ncmb-dart](https://github.com/NCMBMania/ncmb-dart)からForkし、開発されました。
このSDKのライセンスは Apache License Version 2.0 に従います。

# 参考URL集

- [ニフクラ mobile backend](https://mbaas.nifcloud.com/)
- [SDKの詳細な使い方](https://mbaas.nifcloud.com/doc/current/)
- [ユーザーコミュニティ](https://github.com/NIFCLOUD-mbaas/UserCommunity)
