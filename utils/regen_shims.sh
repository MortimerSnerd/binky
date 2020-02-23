#!/bin/bash

# Generate zig source from headers.
#TODO why do I need the /usr/include -I here?  Quirk of current zig master?
echo "Translating C -> zig"
zig translate-c -I../vendor/include -I/usr/include -I/usr/include/x86_64-linux-gnu allrayheaders.c > gen-raylib.raw 
if [ "$?" != "0" ]; then
  echo "ERROR: translate-c failed."
  exit 1
fi

# Do some conservative trimming to get rid of some of the noise from the 
# standard c headers.
echo "Cleaning obvious garbage out of generated zig."
awk '!/^pub (const|extern fn) _/ {print}' gen-raylib.raw > gen-raylib.zig
if [ "$?" != "0" ]; then
  echo "ERROR: awk barfed?"
  exit 1
fi
rm gen-raylib.raw

echo "Build genshims"
zig build-exe genshims.zig -lc
if [ "$?" != "0" ]; then
  echo "ERROR: build of genshims.zig failed."
  exit 1
fi

echo "Generating shims"
./genshims
if [ "$?" != "0" ]; then
  echo "ERROR: genshims failed."
  exit 1
fi

GENSHIMS_OUT="rayshims.c raylib.zig"
echo "Updating parent source."
cp $GENSHIMS_OUT ../src
if [ "$?" != "0" ]; then
  echo "ERROR: file copy failed."
  exit 1
fi

rm -f $GENSHIMS_OUT




