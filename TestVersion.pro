#-------------------------------------------------
#
# Project created by QtCreator 2019-01-26T15:36:57
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = TestVersion
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

#message($$PWD)
#message($$OUT_PWD)
#message($(QTDIR))
#message($$QMAKE_QMAKE)
#message($$_PRO_FILE_PWD_)
#message($$_PRO_FILE_)
#message($$QMAKE_QMAKE)

# Fast update version app in window title
win32:CONFIG(release, debug|release):system(del /Q /F $$system_path($$OUT_PWD\release\main.*))
win32:CONFIG(debug, debug|release):system(del /Q /F $$system_path($$OUT_PWD\debug\main.*))

unix:CONFIG(release, debug|release):system(rm $$system_path($$OUT_PWD\release\main.*))
unix:CONFIG(debug, debug|release):system(rm $$system_path($$OUT_PWD\debug\main.*))

GIT_STATUS = $$system(git status --short) # Detect uncommited, unindexed, untracked files
isEmpty(GIT_STATUS) {
    GIT_COMMIT = $$system(git describe --always --abbrev=8) # Sometimes return only tag name? So let's check!
    # fixme when GIT_COMMIT something like this:
    #GIT_COMMIT = 1.3.0-1-g2b73f4fc
    result = $$find(GIT_COMMIT, "(([0-9]|[a-f]){2}){4}")
    isEmpty(result) {
        message("GIT_COMMIT bad format! result:" $$result $$GIT_COMMIT)
        GIT_COMMIT_FOR_LAST_TAG = $$system(git rev-list --tags --max-count=1)
        GIT_COMMIT = $$system(git rev-parse --short=8 $$GIT_COMMIT_FOR_LAST_TAG)
        message("GIT_COMMIT after fix format!" $$GIT_COMMIT)
    }
}
!isEmpty(GIT_STATUS) {
    GIT_COMMIT = uncommitted
}

GIT_BRANCH = $$system(git symbolic-ref --short HEAD)
isEmpty(GIT_BRANCH):message("GIT_BRANCH is empty! Set to master") GIT_BRANCH = master

GIT_TAG_PART1 = $$system(git rev-list --tags --max-count=1)
GIT_TAG = $$system(git describe --tags $$GIT_TAG_PART1)
isEmpty(GIT_TAG):message("GIT_TAG is empty! Set to 1.0.0") GIT_TAG = 1.0.0

YEAR_FROM = 2015
win32:YEAR_TO = $$system("echo %date:~10,4%")
unix:YEAR_TO = $$system(date +%Y)

YEARS = $$YEAR_FROM-$$YEAR_TO

GIT_VERSION_FULL = $$GIT_TAG-$$GIT_BRANCH-$$GIT_COMMIT

message($$GIT_VERSION_FULL ";" $$YEARS)

win32:COMMAND_REMOVE_MAKEFILES=$$quote(del /Q /F $$system_path($$OUT_PWD\Makefile*))
unix:COMMAND_REMOVE_MAKEFILES=$$quote(rm $$system_path($$OUT_PWD\Makefile*))

PRE_BUILD_TARGET = .dummyfile
updatemakefiles.target = $$PRE_BUILD_TARGET
updatemakefiles.commands = $$COMMAND_REMOVE_MAKEFILES
updatemakefiles.depends = FORCE

PRE_TARGETDEPS += $$PRE_BUILD_TARGET
QMAKE_EXTRA_TARGETS += updatemakefiles

DEFINES += GIT_TAG_STR=\\\"$$GIT_TAG\\\"
DEFINES += GIT_BRANCH_STR=\\\"$$GIT_BRANCH\\\"
DEFINES += GIT_COMMIT_STR=\\\"$$GIT_COMMIT\\\"
DEFINES += GIT_VERSION_FULL_STR=\\\"$$GIT_VERSION_FULL\\\"
DEFINES += YEARS_STR=\\\"$$YEARS\\\"

VERSION = $$GIT_TAG

QMAKE_TARGET_COMPANY = "Company"
QMAKE_TARGET_DESCRIPTION = $$TARGET "v"$$GIT_VERSION_FULL
QMAKE_TARGET_COPYRIGHT =  "\\251 "$$YEARS $$QMAKE_TARGET_COMPANY". All rights reserved."
