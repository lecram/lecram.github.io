#! /bin/sh

SOURCE="$1"
DEST="$2"
TEMPLATE="template.html"
NMEFLAGS="--headernum2 --xref --html --body"

TITLE=`sed -n -e 's/^[= ]*\(.*\)[= ]*$/\1/' -e '1p' "$SOURCE"`
git status -s "$SOURCE" > /dev/null
git diff-files --quiet "$SOURCE"
if [ $? -ne 0 ]
then
  TIMESTAMP=`date -d "@$(stat -c '%Y' $SOURCE)" "+%F %T %z"`
else
  TIMESTAMP=`git log -n 1 --pretty=format:"%ai" -- "$SOURCE"`
fi

LINECOUNT=`wc -l < "$TEMPLATE"`
SPLITLINE=`awk '/{CONTENT}/ {print FNR}' "$TEMPLATE"`
TOP=`head -n $(($SPLITLINE - 1)) "$TEMPLATE" |
     sed -e "s/{TITLE}/$TITLE/" -e "s/{TIMESTAMP}/$TIMESTAMP/"`
BOT=`tail -n $(($LINECOUNT - $SPLITLINE)) "$TEMPLATE"`
MID=`sed '1d' $SOURCE | nme $NMEFLAGS`

cat > $DEST <<EOF
$TOP
$MID
$BOT
EOF
