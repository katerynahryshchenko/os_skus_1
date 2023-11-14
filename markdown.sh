#!/bin/bash
echo '<!DOCTYPE html>'
echo '<html>'
echo '<head>'
echo '        <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />'
echo '</head>'
echo '<body>'
ZOZ=n

while IFS= read LINE
do
	if echo "$LINE" | grep '^# '>/dev/null
       	then
		LINE=$(echo "$LINE" | sed 's@^#\(.*\)$@<h1>\1</h1>@')
		echo "$LINE"
	elif echo "$LINE" | grep '^## '>/dev/null
       	then
		LINE=$(echo "$LINE" | sed 's@^##\(.*\)$@<h2>\1</h2>@')
		echo "$LINE"
	elif  echo "$LINE" | grep '__.*__ '>/dev/null
       	then
		LINE=$(echo "$LINE" | sed 's@__\([^_]\+\)__@<strong>\1</strong>@g')
		echo "$LINE"
	elif  echo "$LINE" | grep '_.*_'>/dev/null
       	then
		LINE=$(echo "$LINE" | sed 's@_\([^_]\+\)_@<em>\1</em>@g')
		echo "$LINE"
	elif  echo "$LINE" | grep '<https://.*>'>/dev/null
       	then
		LINE=$(echo "$LINE" | sed 's@<https://\([^<]\+\)>@<a href = "https://\1">https://\1</a>@g')
		echo "$LINE"
	elif echo "$LINE" | grep '^ - .*$'>/dev/null
	then
		if test "$ZOZ" = "y"
		then 
			LINE=$(echo "$LINE" | sed 's@^ - \(.*\)$@<li>\1</li>@')
			echo "$LINE"
		else 
			ZOZ="y"
			echo "<ol>"
			LINE=$(echo "$LINE" | sed 's@^ - \(.*\)$@<li>\1</li>@')
			echo "$LINE"
		fi
	elif echo "$LINE" | grep '^.[^-].*$'>/dev/null
	then
		if test "$ZOZ" = "y"
		then
	 		echo "</ol>"
		fi
	elif  echo "$LINE" | grep '^$'>/dev/null
       	then
		echo "<p>"
	else
		echo "$LINE"
	fi
done

echo '</body>'
echo '</html>'

