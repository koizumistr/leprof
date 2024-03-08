# leprof
## in English
Liberty Eiffel profile viewer

## 日本語で
Liberty Eiffelでは-profileと指定してコンパイルするとprofile.seというファイルにプロファイルが取れます。各クラスの関数毎にCount、Own、*Cumul*という値でプロファイルが取れますが、Summaryでは*Cumul*の降順に並んでいます。それをCountやOwnの降順にも並べて出力するスクリプトです。

はい、その時しか使えません。

入力ファイルにはLiberty Eiffelが出力したプロファイルを指定してください。通常はprofile.seという名前です。

### オプション n [NUM]
それぞれNUM行出力します。0もしくは負の値を指定すると元の行数と同じだけ出力します。オプションを指定しなければ20行出力します。
