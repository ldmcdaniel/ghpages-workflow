#!/bin/sh

rm -rf public
mkdir public

# compile jade to html
./node_modules/.bin/jade src -P
cd src
find . -name "*.html" | cpio -pdvm ../public
cd ..
rm -rf src/*.html \
	src/**/*.html \
	public/**/_*.html \
	public/_partials
./node_modules/.bin/node-sass \
	--output-style comporessed \
	--source-map-embed \
	src/_styles/main.scss public/css/main.css

# Convert ES6 to ES5
./node_modules/.bin/babel src --out-dir public -s inline
