BEGIN {
    sqsub = "_"
#    sqsub = ""
    print "digraph callgraph {"
}

/^[^ ].*call[s]{0,1}$/ {
    sub(/:$/, "", $1);
    if (sqsub != "") {
	print "hoge"
	gsub(/\[|\]/, sqsub, $1)
    }
    callee = $1;
    next;
}

/	From / {
    sub(/:$/, "", $2)
    if (sqsub != "")
	gsub(/\[|\]/, sqsub, $2)
    print "\t\"" $2 "\" -> \"" callee "\""
    next;
}

#/	To /{
#    print "\t\"" callee "\" -> \"" $2 "\""
#    next;
#}

END {
    print "}"
}
