#!/bin/sh

day=$(date "+%Y-%m-%d")
hour=$(date "+%H:%M:%S")
date=$(date)

pipotron_run() {
    type="$1"
    title_filters="${2:-cat}"
    body_filters="${3:-cat}"
    body=$(docker run moul/pipotron "$type" | $body_filters)
    title=$(echo "$body" | head -n 1 | $title_filters | sed 's/<br>//' | sed -e's/[[:space:]]*$//' | awk -v len=40 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }' | iconv -t utf-8 -c)
    mkdir -p content/post/pipotron/$type/$day-$hour
    cat > content/post/pipotron/$type/$day-$hour/index.md <<EOF
---
title: "$title"
date: "$date"
tags: ["$type", "pipotron"]
author: m1ch3l
categories: ["generated"]
slug: "$type/$day-$hour"
---

$body
EOF
}

pipotron_save() {
    type="$1"
    title="$2"
    filename="$3"
    body="$4"

    mkdir -p content/post/pipotron/$type/$day-$hour/
    docker run moul/pipotron "$type" > content/post/pipotron/$type/$day-$hour/$filename
    cat > content/post/pipotron/$type/$day-$hour/index.md <<EOF
---
title: "$title"
date: "$date"
tags: ["$type", "pipotron", "image"]
author: m1ch3l
categories: ["generated"]
slug: "$type/$day-$hour"
---

$body
EOF
}

add_br() {
    sed 's/.*/&<br>/'
}

append_day() {
    sed "s/\$/ $day/"
}

pipotron_run "marabout"
pipotron_run "moijaime"
pipotron_run "fuu"
pipotron_run "insulte-mignone"
pipotron_run "prenom-compose"
pipotron_run "horoscope" "append_day" "add_br"
pipotron_run "reve" "" "add_br"

pipotron_save "image-svg" "image-svg" "image.svg" '![](image.svg)'


## jargon generator

mkdir -p content/post/pipotron/jargon/$day-$hour
body=$(docker run ultreme/jargon-generator)
title="jargon"
type=jargon
cat > content/post/pipotron/jargon/$day-$hour/index.md <<EOF
---
title: "$title"
date: "$date"
tags: ["$type", "pipotron"]
author: m1ch3l
categories: ["generated"]
slug: "$type/$day-$hour"
---

$body
EOF
