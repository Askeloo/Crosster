#include "patternmaker.h"

#include <random>

#include <QDebug>
#include <QElapsedTimer>

//improve symbols list
//std::vector<QString> PatternMaker::SYMBOLS=  {"*", "-", "+", "T", ">", "<", "V", "O", "X", "U", "B", "A", "X", "||", "^"};
    //Not working all
std::vector<QString> PatternMaker::SYMBOLS=  {"+", "-", "<", ">", "@", "#", "$", "%", "꒫", "*",
                                              "?", "=", "꒧", "♈️", "♉️", "♊️", "♋️", "♌️", "♏️", "☁️",
                                              "☂️", "☃️", "★","☆", "☉", "☎️", "☯️", "☼", "♂", "♥️",
                                              "♦️", "♠️", "♣️", "‰", "♪", "♫", "✂️", "ε", "ϝ", "ϛ",
                                              "η", "θ", "κ", "λ", "μ", "ν", "ξ", "π", "ϟ", "ʯ",
                                              "ρ", "σ", "τ", "υ", "φ", "χ", "ψ", "ω", "ϡ", "Ⴔ",
                                              "¬", "Þ", "☻", "☑️", "☟", "꓃", "꒜", "֍", "҂", "꒿",
                                              "꒾", "©", "|", "♒️", "¥", "β", "¢", "γ", "α", "⁑",
                                              "δ", "♑️", "ɮ", "§", "∴", "®", "ᛖ", "¤", "£", "♓️"};


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

std::tuple<QVector<CellItem*>, int> PatternMaker::createPattern(const PatternInfo& pi)
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
    auto vectCells = convertImage(reducedImage);
    int flossesAmount = m_colorBindings.size();
    m_colorBindings.clear();

    qDebug() << "Creating pattern took: " << timer.elapsed() << "milliseconds";

    return {vectCells, flossesAmount};
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

    for (int it = 0; it < maxIterations; ++it)
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
            break;
    }

    QImage out(width, height, QImage::Format_RGB32);
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            int index = indices[x + y * width];
            out.setPixelColor(x, y, clusters[index].color);
        }
    }
    return out;
}

QVector<CellItem*> PatternMaker::convertImage(const QImage &image)
{
    const int width = image.width();
    const int height = image.height();
    QVector<CellItem*> vectCells;

    for (int y = 0; y < height; ++y)
    {
        for (int x = 0; x < width; ++x)
        {
            QColor color = image.pixelColor(x,y);
            QColor convertedColor;
            if(m_colorBindings.contains(color))
            {
                convertedColor = m_colorBindings[color];
            }
            else
            {
                //FlossData temp = m_flosses[closestFloss(color)]; //should save
                convertedColor = m_flosses[closestFloss(color)].color;
                m_colorBindings[color] = convertedColor;
            }
            CellItem* tempCell = new CellItem(convertedColor, getSymbol(convertedColor), false);
            vectCells.push_back(tempCell);

        }
    }
    return vectCells;
}
