/***************************************************************************
    File                 : globals.cpp
    Description          : Definition of global constants and enums
    --------------------------------------------------------------------
    Copyright            : (C) 2006-2009 Tilman Benkert (thzs*gmx.net)
    Copyright            : (C) 2006-2007 Ion Vasilief (ion_vasilief*yahoo.fr)
                           (replace * with @ in the email addresses)

 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *  This program is free software; you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation; either version 2 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the Free Software           *
 *   Foundation, Inc., 51 Franklin Street, Fifth Floor,                    *
 *   Boston, MA  02110-1301  USA                                           *
 *                                                                         *
 ***************************************************************************/

#include "globals.h"
#include <QMessageBox>
#include <QIcon>
#include <QObject>
#include <QMetaObject>
#include <QMetaEnum>
#include <QtDebug>

const int AlphaPlot::AlphaPlot_versionNo = 00001;
const char* AlphaPlot::AlphaPlot_version = "0.01A";
const char* AlphaPlot::extra_version = "-alpha";
const char* AlphaPlot::release_date = "March 10, 2016";
const char* AlphaPlot::homepage_Uri = "http://AlphaPlot.sourceforge.net";
const char* AlphaPlot::manual_Uri =
    "http://sourceforge.net/projects/AlphaPlot/files/AlphaPlot%20Documentation/"
    "0.1/";
const char* AlphaPlot::forum_Uri =
    "http://sourceforge.net/forum/?group_id=199120";
const char* AlphaPlot::bugreport_Uri =
    "http://sourceforge.net/tracker/?group_id=199120&atid=968214";
const char* AlphaPlot::download_Uri =
    "http://sourceforge.net/projects/AlphaPlot/files/AlphaPlot/";

int AlphaPlot::version() { return AlphaPlot_versionNo; }

QString AlphaPlot::schemaVersion() {
  return "AlphaPlot " + QString::number((version() & 0xFF0000) >> 16) + "." +
         QString::number((version() & 0x00FF00) >> 8) + "." +
         QString::number(version() & 0x0000FF);
}

QString AlphaPlot::versionString() { return AlphaPlot_version; }

QString AlphaPlot::extraVersion() { return QString(extra_version); }

QString AlphaPlot::releaseDateString() { return release_date; }

QString AlphaPlot::originalAuthorString() {
  return "Arun Narayanankutty <n.arun.lifescience@gmail.com>";
}

QString AlphaPlot::enumValueToString(int key, const QString& enum_name) {
  int index = staticMetaObject.indexOfEnumerator(enum_name.toAscii());
  if (index == -1) return QString("invalid");
  QMetaEnum meta_enum = staticMetaObject.enumerator(index);
  return QString(meta_enum.valueToKey(key));
}

int AlphaPlot::enumStringToValue(const QString& string,
                                 const QString& enum_name) {
  int index = staticMetaObject.indexOfEnumerator(enum_name.toAscii());
  if (index == -1) return -1;
  QMetaEnum meta_enum = staticMetaObject.enumerator(index);
  return meta_enum.keyToValue(string.toAscii());
}
