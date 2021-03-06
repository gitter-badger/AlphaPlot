#!/bin/bash
# Create a distributable installable package

MAC_DIST_DIR=AlphaPlot/AlphaPlot.app/Contents/MacOS
RES_DIR=AlphaPlot/AlphaPlot.app/Contents/Resources
version=`grep AlphaPlot_version libAlphaPlot/src/version.cpp|tail -1|cut -f5 -d' '|tr -d '";'`
if [ $version = '"unknown"' ]; then
    version=0.0.0.0
fi

rewrite_dylibs()
{
    local target=$1
    echo "rewrite_dylibs $target"
    otool -L $target|grep opt/local|cut -f1 -d' '|while read dylib; do
        # avoid infinite loops
        if [ "${dylib##*/}" == "${target##*/}" ]; then 
            install_name_tool -change $dylib @executable_path/${dylib##*/} $target
            continue
        else
            cp -f $dylib $MAC_DIST_DIR
            chmod u+rw $MAC_DIST_DIR/${dylib##*/}
            rewrite_dylibs $MAC_DIST_DIR/${dylib##*/}
            echo "install_name_tool -change $dylib @executable_path/${dylib##*/} $target"
            install_name_tool -change $dylib @executable_path/${dylib##*/} $target
        fi
    done
    otool -L $target|grep usr/local|cut -f1 -d' '|while read dylib; do
        cp -f $dylib $MAC_DIST_DIR
        chmod u+rw $MAC_DIST_DIR/${dylib##*/}
        rewrite_dylibs $MAC_DIST_DIR/${dylib##*/}
        install_name_tool -change $dylib @executable_path/${dylib##*/} $target
    done
}

rewrite_dylibs $MAC_DIST_DIR/AlphaPlot

chmod u+w $MAC_DIST_DIR/*

# Generic resources required for Qt
cp -rf /opt/local/libexec/qt4/Library/Frameworks/QtGui.framework/Resources/qt_menu.nib $RES_DIR

# python resources
mkdir -p $RES_DIR/lib
cp -rf /opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7 $RES_DIR/lib

# python resources contain some dynamic libraries that need rewriting
find $RES_DIR/lib -name "*.so" -print | while read soname; do
    otool -L $soname|grep /opt/local|cut -f1 -d' '|while read oldName; do
        install_name_tool -change $oldName @executable_path/${oldName##*/} $soname
        done
done

# copy translation files
cp -rf AlphaPlot/translations $MAC_DIST_DIR

# copy icon, and create mainfest
cp -f AlphaPlot/icons/AlphaPlot.icns $RES_DIR
cat >AlphaPlot/AlphaPlot.app/Contents/Info.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSPrincipalClass</key>
	<string>NSApplication</string>
	<key>CFBundleIconFile</key>
	<string>AlphaPlot.icns</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleGetInfoString</key>
	<string>Created by Qt/QMake</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleExecutable</key>
	<string>AlphaPlot</string>
	<key>CFBundleIdentifier</key>
	<string>net.sourceforge.AlphaPlot</string>
        <key>LSEnvironment</key>
        <dict>
           <key>PYTHONHOME</key>
           <string>/Applications/AlphaPlot.app/Contents/Resources</string>
        </dict>
</dict>
</plist>
EOF

echo AlphaPlot-$version.pkg
pkgbuild --root AlphaPlot/AlphaPlot.app --install-location /Applications/AlphaPlot.app --identifier AlphaPlot AlphaPlot-$version.pkg

