# enable C++11 support
greaterThan(QT_MAJOR_VERSION, 4){
  CONFIG += c++11
} else {
  QMAKE_CXXFLAGS += -std=c++0x
}

INCLUDEPATH += AlphaPlot AlphaPlot/src ../data/translations

include(sourcefiles.pri)
include(muparser.pri)
include(../config.pri)
include(basic.pri)
python {include( python.pri )}


CONFIG        += qt warn_on exceptions opengl thread zlib

DEFINES       += QT_PLUGIN
DEFINES       += TS_PATH="\\\"$$replace(translationfiles.path," ","\\ ")\\\""
DEFINES       += DOC_PATH="\\\"$$replace(documentation.path," ","\\ ")\\\""

!isEmpty( manual.path ) {
DEFINES       += MANUAL_PATH="\\\"$$replace(manual.path," ","\\ ")\\\""
}

!isEmpty(plugins.path): DEFINES += PLUGIN_PATH=\\\"$$replace(plugins.path," ","\\ ")\\\"

!mxe {
  win32:DEFINES += QT_DLL QT_THREAD_SUPPORT
}

QT            += opengl qt3support network svg xml

MOC_DIR        = ../tmp/AlphaPlot
OBJECTS_DIR    = ../tmp/AlphaPlot
DESTDIR        = ./

### this is the program itself
INSTALLS        += target

### README, INSTALL.html, manual (if present in the manual subfolder), etc.
INSTALLS        += documentation

### translations
INSTALLS        += translationfiles

### icon file (for Windows installer)
win32:INSTALLS  += win_icon

########### Future code backported from the aspect framework ##################
DEFINES += LEGACY_CODE_0_2_x
INCLUDEPATH += src/future
