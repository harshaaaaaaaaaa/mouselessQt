#ifndef FUZZYSEARCH_H
#define FUZZYSEARCH_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QVariantMap>

class FuzzySearch : public QObject
{
    Q_OBJECT

public:
    explicit FuzzySearch(QObject *parent = nullptr);

    // Search through list of items for query string
    Q_INVOKABLE QVariantList search(const QString &query,
                                     const QVariantList &items,
                                     const QString &searchField = "title");

    // Fuzzy match score (0-100, higher is better)
    Q_INVOKABLE int matchScore(const QString &query, const QString &text);

private:
    bool fuzzyMatch(const QString &pattern, const QString &text);
    int levenshteinDistance(const QString &s1, const QString &s2);
    int calculateScore(const QString &query, const QString &text);
};

#endif // FUZZYSEARCH_H
