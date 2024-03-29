#ifndef PATTERNMAKER_H
#define PATTERNMAKER_H

#include <array>

#include <QString>
#include <QColor>
#include <QFile>
#include <QImage>
#include <QMap>
#include <QStringList>

#include "PatternInfo.h"
#include "cellitem.h"
#include "flossitem.h"

class PatternMaker
{
    struct FlossData
    {
        FlossData(QString i = "B5200", QString d = "Snow White",
                  QString c = "FFFFFF")
            : id(i), descr(d), color("#" + c) {}

        QString id;
        QString descr;
        QColor color;
    };

    class ColorBlock {
      private:
        std::array<int, 3> sum;
        int size;

      public:
        QColor color;

        ColorBlock(const QColor &c) : sum{}, size{0}, color{c} {}

        void addColor(const QColor &c) {
            sum[0] += c.red();
            sum[1] += c.green();
            sum[2] += c.blue();
            ++size;
        }

        bool update() {
            if (size > 0) {
                auto prev = color;
                color = {sum[0] / size, sum[1] / size, sum[2] / size};
                sum = {0, 0, 0};
                size = 0;
                return color != prev;
            }
            return false;
        }
    };


public:
    PatternMaker(QString);

    std::tuple<QVector<CellItem*>, QVector<FlossItem*>> createPattern(const PatternInfo&);

    int getDistance(const QColor &c, const QColor &c2);
    int closestColorBlock(const QColor &color, const std::vector<ColorBlock> &clusters); // make it template
    unsigned closestFloss(const QColor &color);
    QString getSymbol(const QColor& color);

    QImage reduceColors(const QImage &image, int num_colors);
    std::tuple<QVector<CellItem*>, QVector<FlossItem*>> convertImage(const QImage &image); //should return tuple <vector<cell>, vector<floss>, image>

private:
    std::vector<FlossData> m_flosses;

    const std::vector<QString> SYMBOLS = {"+", "-", "<", ">", "@", "#", "$", "%", "꒫", "*",
                                          "!", "=", "꒧", "♈️", "♉️", "♊️", "♋️", "♌️", "♏️", "☁️",
                                          "☂️", "☃️", "★","☆", "☉", "☎️", "☯️", "☼", "♂", "♥️",
                                          "♦️", "♠️", "♣️", "‰", "♪", "♫", "✂️", "ε", "ϝ", "ϛ",
                                          "η", "θ", "κ", "λ", "μ", "ν", "ξ", "π", "ϟ", "ʯ",
                                          "ρ", "σ", "τ", "υ", "φ", "χ", "ψ", "ω", "ϡ", "Ⴔ",
                                          "¬", "Þ", "☻", "☑️", "☟", "꓃", "꒜", "֍", "҂", "꒿",
                                          "꒾", "©", "|", "♒️", "¥", "β", "¢", "γ", "α", "⁑",
                                          "δ", "♑️", "ɮ", "§", "∴", "®", "ᛖ", "¤", "£", "♓️"};
};

#endif // PATTERNMAKER_H
