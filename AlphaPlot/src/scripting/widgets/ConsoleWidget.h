/* This file is part of AlphaPlot.
   Copyright 2016, Arun Narayanankutty <n.arun.lifescience@gmail.com>

   AlphaPlot is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   AlphaPlot is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   You should have received a copy of the GNU General Public License
   along with AlphaPlot.  If not, see <http://www.gnu.org/licenses/>.

   Description : AlphaPlot Console dock widget
*/

#ifndef CONSOLEWIDGET_H
#define CONSOLEWIDGET_H

#include <QDockWidget>

class Ui_ConsoleWidget;

class ConsoleWidget : public QDockWidget {
  Q_OBJECT

 public:
  explicit ConsoleWidget(QWidget *parent = nullptr);
  ~ConsoleWidget();

 private:
  Ui_ConsoleWidget *ui_;
};

#endif  // CONSOLEWIDGET_H
