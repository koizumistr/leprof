# le profile tools
## in English
Liberty Eiffel profile tools

## 日本語で
Liberty Eiffelでは-profileと指定してコンパイルするとprofile.seというファイルにプロファイルが取れます。そのファイルをいい感じで見るためのツールです。

はい、その時しか使えません。

それぞれ入力ファイルにはLiberty Eiffelが出力したプロファイル（通常はprofile.seという名前です）を指定してください。

### leprof.rb
profile.seでは各クラスの関数毎にCount、Own、\*Cumul\*という値でプロファイルが取れますが、Summaryでは\*Cumul\*の降順に並んでいます。それをCountやOwnの降順にも並べて出力するRubyのスクリプトです。

#### オプション n [NUM]
それぞれNUM行出力します。0もしくは負の値を指定すると元の行数と同じだけ出力します。オプションを指定しなければ20行出力します。

### callgraph.awk
profile.seからコールグラフをdot形式で作成するAWKのスクリプトです。
あとはgraphvizとかsvgビューアーとかご自由に。例えば以下のような感じ。

```
awk -f callgraph.awk profile.se > myprog.dot
dot -Tsvg mag.dot > myprog.svg
open myprog.svg
```
