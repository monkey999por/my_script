# my_loca_script (mls)

<font size="5">**■mlsとは？**</font><br>
・windows cmdとwindows powershellを使用した拡張コマンド群<br>

<font size="5">**■mlsが目指す場所**</font><br>
・windowsの標準機能のみを使い、OS以外の機能に依存性をもたないこと<br>
・mls実行前後で、ユーザの意図しない場所にファイルやフォルダを残さない。(痕跡を残さずに必要な処理を行うことが可能)　※ただし、%userprofile%/Downloadsは標準の出力先として使用する<br>
・インターネットからの直接的なダウンロードを必要としない。(⇒ビルド用テキストファイルをコピぺ
し、それをローカルマシン上で実行することでインストール完了とする)<br>
・ローカルマシン上でのファイル操作を主とするため、ネットワーク通信を行わないこと<br>

<font size="5">**■インストール**</font><br>
・・・・・作成中・・・・・（mls.batにパスを通すことを忘れずに）

<font size="5">**■使用例**</font><br>
コマンドプロンプトを開き、ヘルプオプションをつけてmlsを実行してみましょう
```
$mls --help
```
mlsで使用できるカスタムコマンドの一覧が表示されますね。<br>

試しにwnameコマンドの詳細ヘルプを見てみましょう
```
$mls wname --help
```
wnameコマンドの詳細ヘルプが出ますね、<br>
本当かどうか試してみましょう！<br>

```
$mls whelp
```
どうやらhtmlファイルが書き出されたみたいですね<br>
ためしにブラウザで開いてみましょう。<br>
cmd.exeの標準のhelpが全量表示されますね！<br>

**上記のほかにも、mlsは`$mls [command] [option] [input] [option] [input]....`の形式で実行できます**

<font size="5">**■開発者向け**</font><br>

**〇新規カスタムコマンドを作成したい**<br>
`$mls --new [command_name]`を指定してください。<br>
下記のものが作成されます。<br>
1. ./batch/command/[command_name]/[command_name].bat<br>
2. ./batch/command/[command_name]/[command_name]_test.bat<br>

1にカスタムコマンドを実装し、2にテストコードを書きます。<br>
それと、helpファイルの更新が必要です。`./batch/props/command.help`に新規追加したコマンドの説明を書いてください<br>


**〇カスタムコマンドのテストがしたい**<br>
 `$mls [command_name] --test`でテストが実行できます。<br>
`./batch/command/[command_name]/[command_name]_test.bat`が実行されます。

**〇mlsの開発で考えなければいけないことは？**<br>
基本的に下記の点にだけ注意すれば、あとはいい感じにつくちゃってOKです。
1. mlsは、実行時に`batch\props\env_path_set.bat`を読み込みます
2. `$mls --help`は`batch\props\command.help`を表示します。
3. `$mls [command_help] --help`で詳細コマンドを表示する時は、一行目に`batch\props\command.help`の中の[command_help]に該当する内容を表示します。それ以外は適当に作ってください
4. mlsは、現在のディレクトリをカレントディレクトリとします。
