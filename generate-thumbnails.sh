#!/bin/sh

find content/post/pipotron -name index.md
# FIXME: if thumb.png, not exists -> generate
#sudo xvfb-run --server-args="-screen 0, 1024x768x24" phantomjs build/rasterize.js -u public/post/horoscope/2019-08-02-221408/index.html -i  -s ".text-justify" --css ".text-justify{test-shadow: white 0px 0px 10px;padding:10px;text-align:center;height:600px;width:800px;margin-top:50vh;transform:translateY(-50%)}body{background: linear-gradient(#e66465, #9198e5);}" --timeout 1000
