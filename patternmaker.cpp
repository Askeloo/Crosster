#include "patternmaker.h"

#include <QTextStream>

PatternMaker::PatternMaker()
{
    //hardcoded file path
    QFile file("/storage/emulated/0/org.askelo.crosster/files/dmc.csv");
    if (file.open(QFile::ReadOnly | QFile::Text) )
    {
        QTextStream in(&file);
        //Reads the data up to the end of file
        QString line = in.readLine();
        while (!in.atEnd())
        {
            QString line = in.readLine();
            QStringList items = line.split(",");
            QString id = items[0];
            QString descr = items[1];
            QString color = items[5];
            m_flosses.push_back(FlossData(id, descr, color));
        }
        file.close();
    }


}
