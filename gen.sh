#! /bin/sh

SOURCE="$1"
DEST="$2"
TEMPLATE="template.html"
NMEFLAGS="--headernum2 --xref --html --body"

TITLE=`sed -n -e 's/^[= ]*\(.*\)[= ]*$/\1/' -e '1p' $SOURCE`

LINECOUNT=`wc -l < $TEMPLATE`
SPLITLINE=`awk '/{CONTENT}/ {print FNR}' $TEMPLATE`
TOP=`head -n $(($SPLITLINE - 1)) $TEMPLATE | sed "s/{TITLE}/$TITLE/"`
BOT=`tail -n $(($LINECOUNT - $SPLITLINE)) $TEMPLATE`
MID=`nme $NMEFLAGS < $SOURCE`

cat > $DEST <<EOF
$TOP
$MID
$BOT
EOF
