#!/bin/bash

# This is run immediatly after the "cargo doc" command.

SDIR="$HOME/suibase/rust/helper/target/doc"
TDIR="$HOME/suibase-api-docs/docs"

# Verify that the generated target/doc are sane.
# Return 0 if OK, else 1 if any hint of a problem (this will terminate the Github CI).
if [ ! -d "$SDIR" ]; then
    echo "Missing $SDIR"
    exit 1
fi

# Remove generated .lock, which has permission that was
# causing github deploy pages to fail. More info:
#  https://github.com/actions/deploy-pages/issues/188
#  https://github.com/actions/upload-pages-artifact#file-permissions
rm -f "$SDIR/.lock"

echo "<meta http-equiv=\"refresh\" content=\"0; url=suibase\">" > "$SDIR/index.html"

if [ ! -f "$SDIR/index.html" ]; then
    echo "Missing $SDIR/index.html"
    exit 1
fi

rm -rf "$TDIR"
cp -r "$SDIR" "$TDIR"

if [ ! -f "$TDIR/help.html" ]; then
    echo "Missing $TDIR/help.html"
    exit 1
fi

if [ ! -f "$TDIR/index.html" ]; then
    echo "Missing $TDIR/index.html"
    exit 1
fi

if [ ! -d "$TDIR/suibase" ]; then
    echo "Missing $TDIR/suibase"
    exit 1
fi

if [ ! -f "$TDIR/suibase/index.html" ]; then
    echo "Missing $TDIR/suibase/index.html"
    exit 1
fi

if [ ! -f "$TDIR/suibase/enum.Error.html" ]; then
    echo "Missing $TDIR/suibase/enum.Error.html"
    exit 1
fi

if [ ! -f "$TDIR/suibase/struct.Helper.html" ]; then
    echo "Missing $TDIR/suibase/struct.Helper.html"
    exit 1
fi

echo "Postprocess success"
