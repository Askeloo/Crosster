#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QStandardPaths>
#include <QDir>

#include "PatternInfo.h"

namespace
{
    class DBCloser {
    public:
        void operator() (QSqlDatabase* db) {
            db->close();
            QSqlDatabase::removeDatabase(QSqlDatabase::defaultConnection);
        }
    };
}

class DBManager
{
public:
    DBManager();

    bool setUp();
    bool setUpWorkspace();
    bool setUpTables();

    int insertPatternInfo(const PatternInfo&);

private:
    QString m_dbPath;
    std::unique_ptr<QSqlDatabase, DBCloser> m_database;
};

#endif // DBMANAGER_H
