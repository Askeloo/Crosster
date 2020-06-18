#include "dbmanager.h"

DBManager::DBManager()
{

}

bool DBManager::setUp()
{
    const QString driver {"QSQLITE"};

    if (!QSqlDatabase::isDriverAvailable(driver))
    {
        qWarning() << "Driver " << driver << " is not available.";
        return false;
    }

    if (!setUpWorkspace())
    {
        qCritical() << "Workspace setup failed!";
        return false;
    }

    auto* db = new QSqlDatabase {QSqlDatabase::addDatabase(driver)};
    m_database.reset(db);
    m_database->setDatabaseName(m_dbPath);

    qDebug() << "Database name: " << m_database->databaseName();

    if (!m_database->open())
    {
        qCritical() << "Error in opening DB " << m_database->databaseName()
                   << " reason: " <<  m_database->lastError().text();
        return false;
    }

    return setUpTables();
}

bool DBManager::setUpWorkspace()
{

    const QString databaseName {"PatternsDB"};
    const QString location {QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)};
    const QString fullPath {location + "/" + databaseName};

    m_dbPath = fullPath;

    QDir dbDirectory {location};
    if (!dbDirectory.exists())
    {
        const bool creationResult {dbDirectory.mkpath(location)};
        qWarning() << "DB directory not exist, creating result: "
                   << creationResult;
    }

    qDebug() << "Data path: " << fullPath;

    return dbDirectory.exists();
}

bool DBManager::setUpTables()
{
    bool result {true};

    std::vector<QSqlQuery> creationQueries = {
        QSqlQuery {
            "CREATE TABLE IF NOT EXISTS Pattern"
            "("
            "PatternID INTEGER PRIMARY KEY,"
            "Name TEXT,"
            "Height INTEGER,"
            "Width INTEGER,"
            "Progress REAL,"
            "ThreadType TEXT,"
            "ThreadsCount INTEGER"
//            "UNIQUE(Name)"
            ")"
        },

//        QSqlQuery {
//            "CREATE TABLE IF NOT EXISTS Color"
//            "("
//            "ColorID INTEGER PRIMARY KEY,"
//            "RGB INTEGER,"
//            "BrandCode TEXT,"
//            "Symbol TEXT,"
//            "Description TEXT,"
//            "PatternID INTEGER,"
//            "FOREIGN KEY (PatternID)"
//               "REFERENCES Pattern (PatternID) "
//            ")"
//        },

        QSqlQuery {
            "CREATE TABLE IF NOT EXISTS Color"
            "("
            "ColorID INTEGER PRIMARY KEY,"
            "RGB INTEGER,"
            "BrandCode TEXT,"
            "Symbol TEXT,"
            "Description TEXT,"
            "PatternID INTEGER,"
            "Amount INTEGER"
            "FOREIGN KEY (PatternID)"
               "REFERENCES Pattern (PatternID) "
            ")"
        },

//        QSqlQuery {
//            "CREATE TABLE IF NOT EXISTS Cell"
//            "("
//            "CellID INTEGER PRIMARY KEY,"
//            "PatternID INTEGER,"
//            "CellIndex INTEGER,"
//            "Checked INTEGER,"
//            "ColorID INTEGER,"
//            "FOREIGN KEY (PatternID)"
//               "REFERENCES Pattern (PatternID)"
//            "FOREIGN KEY (ColorID)"
//               "REFERENCES Color (ColorID) "
//            ")"
//        }

        QSqlQuery {
            "CREATE TABLE IF NOT EXISTS Cell"
            "("
            "CellID INTEGER PRIMARY KEY,"
            "PatternID INTEGER,"
//            "CellIndex INTEGER,"
            "RGB INTEGER,"
            "Checked INTEGER,"
            "Symbol TEXT,"
//            "ColorID INTEGER,"
            "FOREIGN KEY (PatternID)"
               "REFERENCES Pattern (PatternID)"
//            "FOREIGN KEY (ColorID)"
//               "REFERENCES Color (ColorID) "
            ")"
        }

    };

    for (auto& query : creationQueries)
    {
        if (!query.exec())
        {
            result = false;
            qWarning() << "Table creation failed. Reason: "
                       << query.lastError();
        }
        else
        {
            qWarning() << "Table successfully created! Query: \n" << query.lastQuery();
        }
    }

    return result;
}

int DBManager::insertPatternInfo(const PatternInfo & pi)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Pattern (Name, Height, Width, Progress, ThreadType, ThreadsCount)"
                        " VALUES (:n, :h, :w, :p, :tt, :tc)");

    query.bindValue(":n", pi.name);
    query.bindValue(":h", pi.height);
    query.bindValue(":w", pi.width);
    query.bindValue(":p", 0);
    query.bindValue(":tt", pi.flossBrand);
    query.bindValue(":tc", pi.threadsAmount);

    query.exec();

    qDebug() <<"Last id_______" + QString::number(query.lastInsertId().toInt());

    return query.lastInsertId().toInt();
}
