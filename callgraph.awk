BEGIN {
    print "digraph callgraph {";
}

/^[^ ].*call[s]{0,1}$/ {
    sub(":$", "", $1)
    callee = $1;
    next;
}

/	From / {
    sub(":$", "", $2)
    print "\t\"" $2 "\" -> \"" callee "\"";
    next;
}

#
#/	To /{
#    print "\t\"" callee "\" -> \"" $2 "\"";
#    next;
#}

END {
    print "}"
}
