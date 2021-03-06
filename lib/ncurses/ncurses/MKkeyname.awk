# $Id: MKkeyname.awk 153052 2007-11-02 21:10:56Z coreos $
BEGIN {
	print "/* generated by MKkeyname.awk */"
	print ""
	print "#include <ncurses_cfg.h>"
	print "#include <stdlib.h>"
	print "#include <string.h>"
	print "#include <curses.h>"
	print "#include <term.h>"
	print ""
	print "struct kn {"
	print "\tconst char *name;"
	print "\tint code;"
	print "};"
	print ""
	print "const struct kn key_names[] = {"
}

/^[^#]/ {
#	printf "\t{ \"%s\",%*s%s },\n", $1, 16-length($1), " ", $1;
	printf "\t{ \"%s\",%s },\n", $1, $1;
	}

END {
	print "};"
	print ""
	print "NCURSES_CONST char *keyname(int c)"
	print "{"
	print "int i, size = sizeof(key_names)/sizeof(struct kn);"
	print "static char name[5];"
	print "char *p;"
	print ""
	print "\tfor (i = 0; i < size; i++)"
	print "\t\tif (key_names[i].code == c)"
	print "\t\t\treturn key_names[i].name;"
	print "\tif (c >= 256) return \"UNKNOWN KEY\";"
	print "\tp = name;"
	print "\tif (c >= 128) {"
	print "\t\tstrcpy(p, \"M-\");"
	print "\t\tp += 2;"
	print "\t\tc -= 128;"
	print "\t}"
	print "\tif (c < 0)"
	print "\t\tsprintf(p, \"%d\", c);"
	print "\telse if (c < 32)"
	print "\t\tsprintf(p, \"^%c\", c + '@');"
	print "\telse if (c == 127)"
	print "\t\tstrcpy(p, \"^?\");"
	print "\telse"
	print "\t\tsprintf(p, \"%c\", c);"
	print "\treturn name;"
	print "}"
	print "" 
}
