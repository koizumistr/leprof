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
dot -Tsvg myprog.dot > myprog.svg
open myprog.svg
```

デフォルトでは次のext.gvprと連携して動作させるために出力に小細工しています。
「そんなのは要らん」という方はBEGINの中を修正してください。（何をやれば良いかはソースを見れば分かるかと。）

### ext.gvpr
それなりの大きさのプログラムであれば、profile.seからcallgraph.awkを救って作成した図は巨大になると思います。それを見て「俺の作ったプログラムすげー」とか「こんな巨大な図を表示できる俺のPCすげー」とか一人悦に入るのも悪くないですが、気になる部分だけを取り出して見たくなることもあるでしょう。その時のためのgvpr用スクリプトです。こんな感じで使ってください。

```
gvpr -f ext.gvpr -a 注目するノード myprog.dot > myprog2.dot
```
