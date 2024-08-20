base=`dirname $(readlink -f $0)`
F=$base/hasil.txt
rm -f $F

find $base/content/game -name *.md -type f > $base/cache

while IFS= read -r line; do
  A=`cat "$line" | grep title | cut -d : -f 2`
  L=`cat "$line" | grep link | cut -d : -f 3` 
  NUM=$(((NUM+1)))
  Z=`cat "$line" | grep aethersx2file`
  if [ "$Z" ]; then
  echo "- $A" >> $F
  fi
done < $base/cache


