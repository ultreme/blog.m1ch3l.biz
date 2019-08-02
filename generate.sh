#!/bin/sh

day=$(date "+%Y-%m-%d")
hour=$(date "+%H:%M:%S")
date=$(date)

body=$(pipotron marabout)
title=$(echo "$body" | head -n 1)

cat > content/post/pipotron/marabout/$day-$hour.md <<EOF
---
title: "$title"
date: "$date"
tags: ["marabout", "pipotron"]
author: m1ch3l
categories:
- pipotron
---

$body

EOF
