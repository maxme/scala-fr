#!/bin/sh

MARKDOWN=Markdown.pl
$MARKDOWN < $1 > $1.html

perl -pi -e 's/<pre><code>/<pre lang="scala">/g;' \
     -e 's+</code></pre>+</pre>+g;' \
     -e 's/&lt/</g;' -e 's/&gt/>/g;' $1.html
