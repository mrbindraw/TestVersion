#include "mainwindow.h"
#include <QApplication>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    MainWindow w;
    const QString title = QString("%1 v%2").arg(w.windowTitle()).arg(GIT_VERSION_FULL_STR);

    a.setApplicationVersion(GIT_VERSION_FULL_STR);
    qDebug() << "title:" << title;
    qDebug() << "Copyright years:" << YEARS_STR;
    qDebug() << "version:" << a.applicationVersion();

    w.setWindowTitle(title);
    w.show();

    return a.exec();
}
