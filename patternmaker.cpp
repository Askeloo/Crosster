#include "patternmaker.h"

#include <random>

#include <QDebug>
#include <QElapsedTimer>

bool operator<(const QColor & a, const QColor & b)    //TO DELETE
{
   return a.red() < b.red()
       || a.green() < b.green()
       || a.blue() < b.blue()
       || a.alpha() < b.alpha();
}

PatternMaker::PatternMaker()
{
    QFile file(":/files/dmc.csv");
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
            m_flosses.emplace_back(id, descr, color);
        }
        file.close();
    }
}

std::tuple<QVector<CellItem*>, QVector<FlossItem*>> PatternMaker::createPattern(const PatternInfo& pi)
{
    QElapsedTimer timer;
    timer.start();

    QImage resisedImg;
    //enhancing

    //resizing
    resisedImg = pi.image.scaledToWidth(pi.width);
    if(resisedImg.isNull())
    {
        //do smth
    }

    //reducing colors
    QImage reducedImage = reduceColors(resisedImg, pi.maxColors);

    //binding to flosses` colors
    auto [vectCells, vectFlosses] = convertImage(reducedImage);

    //int flossesAmount = m_colorBindings.size();
    //m_colorBindings.clear();

    qDebug() << "Creating pattern took: " << timer.elapsed() << "milliseconds";

    return {vectCells, vectFlosses};
}

int PatternMaker::getDistance(const QColor &c, const QColor &c2)
{
    int dr = c.red() - c2.red() ;
    int dg = c.green() - c2.green() ;
    int db = c.blue() - c2.blue();
    return dr * dr + dg * dg + db * db;
}


int PatternMaker::closestColorBlock(const QColor &color, const std::vector<ColorBlock> &clusters)
{
    int minDist = std::numeric_limits<int>::max();
    int index = 0;
    for (auto it = clusters.begin(); it != clusters.end(); ++it)
    {
        int dist = getDistance(it->color, color);
        if (dist < minDist) {
            minDist = dist;
            index = it - clusters.begin();
        }
    }
    return index;
}

unsigned PatternMaker::closestFloss(const QColor &color)
{
    unsigned minDist = std::numeric_limits<unsigned>::max();
    unsigned index = 0;
    for(unsigned i = 0;i < m_flosses.size(); i++)
    {
        unsigned dist = getDistance(color, m_flosses[i].color);
        if (dist < minDist)
        {
            minDist = dist;
            index = i;
        }
    }
    return index;
}

//depricated function
QString PatternMaker::getSymbol(const QColor &color)
{
    unsigned mixed = (color.red() * 17 + color.green() * 11 + color.blue());
    return SYMBOLS[mixed % SYMBOLS.size()];
}

QImage PatternMaker::reduceColors(const QImage &image, int num_colors)
{
    std::mt19937 rndgn;
    rndgn.seed(std::random_device()());

    const int width = image.width();
    const int height = image.height();
    const int maxIterations = 100;

    std::uniform_int_distribution<std::mt19937::result_type> widthRange(0, width);
    std::uniform_int_distribution<std::mt19937::result_type> heightRange(0, height);

    std::vector<int> indices(width * height, 0);

    std::vector<ColorBlock> clusters;
    clusters.reserve(num_colors);

    for (int i = 0; i < num_colors; ++i)
    {   //random points to start
        int x = widthRange(rndgn);
        int y = heightRange(rndgn);
        clusters.emplace_back(image.pixelColor(x,y));
    }

    int it = 0;
    for (; it < maxIterations; ++it)
    {
        for (int y = 0; y < height; ++y)
        {
            for (int x = 0; x < width; ++x)
            {
                auto color = image.pixelColor(x,y);
                int index = closestColorBlock(color, clusters);
                clusters[index].addColor(color);
                indices[x + y * width] = index;
            }
        }

        bool changed = false;
        for (auto &cluster : clusters)
        {
            if (cluster.update())
                changed = true;
        }
        if (!changed)
        {
            qDebug() << "Iteration: " << it;
            break;
        }
    }
    qDebug() << "Iteration: " << it;

    QImage out(width, height, QImage::Format_RGB32);
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            int index = indices[x + y * width];
            out.setPixelColor(x, y, clusters[index].color);
        }
    }
    return out;
}

std::tuple<QVector<CellItem*>, QVector<FlossItem*>> PatternMaker::convertImage(const QImage &image)
{
    const int width = image.width();
    const int height = image.height();
    int symbolIndex = 0;
    int symbolsAmount = SYMBOLS.size();
    QVector<CellItem*> vectCells;
    QVector<FlossItem*> vectFlosses;   //sort for amount
//    fsadd.insert(new FlossItem());

    QMap<QColor, QString> rgb2floss;
    QMap<QString, FlossItem*> m_colorBindings;  //change to QHash

    for (int y = 0; y < height; ++y)
    {
        for (int x = 0; x < width; ++x)
        {
            QColor color = image.pixelColor(x,y);
            QString convertedColorId;
            QColor convertedColor;
            QString colorSymbol;

            //FlossData fd = m_flosses[closestFloss(color)];

            if(rgb2floss.contains(color))
            {
                convertedColorId = rgb2floss[color];

                colorSymbol = m_colorBindings[convertedColorId]->symbol();
                convertedColor = m_colorBindings[convertedColorId]->color();

                m_colorBindings[convertedColorId]->incrAmount();
            }
            else
            {

                FlossData fd = m_flosses[closestFloss(color)];
                rgb2floss[color] = fd.id;

                convertedColorId = rgb2floss[color];
                if(m_colorBindings.contains(convertedColorId))
                {

                    m_colorBindings[convertedColorId]->incrAmount();
                    colorSymbol = m_colorBindings[convertedColorId]->symbol();
                    convertedColor = m_colorBindings[convertedColorId]->color();
                }
                else
                {
//                    convertedColor = m_flosses[closestFloss(color)].color;
//                    rgb2floss[color] = convertedColor;
                    QString symbol = "";
                    if(symbolIndex <= symbolsAmount)
                    {
                        symbol = SYMBOLS[symbolIndex];
                        symbolIndex++;
                    }
                    else
                    {
                        symbol = "?";
                    }

                    colorSymbol = symbol;
                    convertedColor = fd.color;
                    m_colorBindings[convertedColorId] = new FlossItem(fd.color, fd.id, fd.descr, symbol, 1);
                }
            }
            CellItem* tempCell = new CellItem(convertedColor, colorSymbol, false);
            vectCells.push_back(tempCell);
        }
    }

    for(auto it = m_colorBindings.begin(); it != m_colorBindings.end(); it++)
    {
        vectFlosses.push_back(it.value());
    }
    return {vectCells, vectFlosses};
}
