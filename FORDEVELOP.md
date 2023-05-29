## SDK開発者向け資料

* 本資料は SDK の開発を円滑にするために SDK 開発者に向けて以下の内容をお伝えするために作成いたしました。
  * SDK の内部構造、 REST API の呼び出し方法
  * テストコードのルールと補助ツール
  * p-r など開発フロー について
* 機能追加、修正される際などに参考としていただけたらと思います。

### 1. SDK説明について
#### ディレクトリ・ファイル構成

SDKのメイン構成は以下となります。

WIP

#### SDK の内部処理と REST API の関係

SDK では以下の順序で REST API リクエストを行い、レスポンスを取得している。

WIP

参考: [REST APIリファレンス：オブジェクト登録](https://mbaas.nifcloud.com/doc/current/rest/datastore/objectRegistration.html)

#### 同期処理と非同期処理

SDK 利用者が直接利用するメソッドの中で REST API を利用するものについては同期処理メソッドと非同期処理メソッドの2点を用意する。

##### 同期処理

WIP

##### 非同期処理

WIP

### 2. 環境について
#### 動作保証環境

参照：[README](./README.md#動作環境)

#### ビルドの環境

WIP

### 3. テストについて
#### 利用するテストツール

テストでは以下のライブラリを利用しています。

WIP

#### テストコード実行方法

* 原則的にすべてのメソッドについてテストコードを作成し、不足している部分についても今後追加を行います。
* バグ修正、新機能開発などの改修時には必ず全パターンのテストを行い、テスト失敗が発生していないことを確認します。

##### 利用するライブラリー

WIP

##### テストコード実行方法

WIP

##### Flutter SDKのテスト構成

WIP

##### テストを書く時に必要なこと

WIP

#### レファレンス作成

WIP

### 4. 開発について

#### 開発フロー
* バグ修正、新機能開発での開発フローは Github フローを用いる。
* 各開発、改修は develop ブランチ へ向けたプルリクエストにて行う。
* バージョン番号が設定されるリリースにて develop ブランチを再度検証した上で、master ブランチにマージする。

#### コーディング規約

* Dartのコーディング規約
https://dart.dev/effective-dart/style
* ncmb-dartの開発ルール
https://dart.dev/effective-dart/usage

#### ドキュメント

以下のようにコメントする際に、フォーマットに従い、コメントを行ってください。
- 参考：https://dart.dev/effective-dart/documentation
markdownを利用可能のため、以下を参照し、必要に応じて、サンプルコードなどを追記してください
- 参考：https://dart.dev/effective-dart/documentation#markdown

```
/// クラスの説明、役割
///
class ClassName {
    /// メソッドの説明
    ///
    /// [var1] [var2] 例外や戻り値の説明文章
    ///
    Type functionName (Type var1, Type var2)
    { ... }
}
```

* 記載例（[参考](https://dart.dev/effective-dart/documentation#do-use-prose-to-explain-parameters-return-values-and-exceptions)）

```
/// Defines a flag.
///
/// Throws an [ArgumentError] if there is already an option named [name] or
/// there is already an option using abbreviation [abbr]. Returns the new flag.
Flag addFlag(String name, String abbr) => ...
```


### 5. 利用中外部ライブラリについて

以下のライブラリを利用しています。それぞれライブラリのライセンスに従います。

WIP

### 6. ライセンスについて

このSDKのライセンスは Apache License Version 2.0 に従います。
