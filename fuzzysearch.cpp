#include "fuzzysearch.h"
#include <QDebug>
#include <algorithm>

FuzzySearch::FuzzySearch(QObject *parent)
    : QObject(parent)
{
}

QVariantList FuzzySearch::search(const QString &query, const QVariantList &items, const QString &searchField)
{
    if (query.isEmpty()) {
        return items;
    }

    QVariantList results;
    QString lowerQuery = query.toLower();

    // Score each item
    QList<QPair<QVariant, int>> scoredItems;

    for (const QVariant &item : items) {
        QVariantMap itemMap = item.toMap();
        QString text = itemMap.value(searchField).toString().toLower();

        // Calculate match score
        int score = calculateScore(lowerQuery, text);

        if (score > 0) {
            scoredItems.append({item, score});
        }
    }

    // Sort by score (descending)
    std::sort(scoredItems.begin(), scoredItems.end(),
              [](const QPair<QVariant, int> &a, const QPair<QVariant, int> &b) {
                  return a.second > b.second;
              });

    // Extract sorted results
    for (const auto &pair : scoredItems) {
        results.append(pair.first);
    }

    return results;
}

int FuzzySearch::matchScore(const QString &query, const QString &text)
{
    return calculateScore(query.toLower(), text.toLower());
}

bool FuzzySearch::fuzzyMatch(const QString &pattern, const QString &text)
{
    int patternIdx = 0;
    int textIdx = 0;

    while (patternIdx < pattern.length() && textIdx < text.length()) {
        if (pattern[patternIdx] == text[textIdx]) {
            patternIdx++;
        }
        textIdx++;
    }

    return patternIdx == pattern.length();
}

int FuzzySearch::levenshteinDistance(const QString &s1, const QString &s2)
{
    const int len1 = s1.length();
    const int len2 = s2.length();

    QVector<QVector<int>> d(len1 + 1, QVector<int>(len2 + 1));

    for (int i = 0; i <= len1; ++i) {
        d[i][0] = i;
    }
    for (int j = 0; j <= len2; ++j) {
        d[0][j] = j;
    }

    for (int i = 1; i <= len1; ++i) {
        for (int j = 1; j <= len2; ++j) {
            int cost = (s1[i - 1] == s2[j - 1]) ? 0 : 1;
            d[i][j] = std::min({
                d[i - 1][j] + 1,      // deletion
                d[i][j - 1] + 1,      // insertion
                d[i - 1][j - 1] + cost // substitution
            });
        }
    }

    return d[len1][len2];
}

int FuzzySearch::calculateScore(const QString &query, const QString &text)
{
    if (query.isEmpty() || text.isEmpty()) {
        return 0;
    }

    int score = 0;

    // Exact match - highest score
    if (text == query) {
        return 1000;
    }

    // Starts with query - very high score
    if (text.startsWith(query)) {
        return 900 + (100 - query.length());
    }

    // Contains query - high score
    if (text.contains(query)) {
        int position = text.indexOf(query);
        // Earlier position = higher score
        return 700 - position;
    }

    // Fuzzy match - medium score
    if (fuzzyMatch(query, text)) {
        // Score based on how close the match is
        int distance = levenshteinDistance(query, text);
        int maxLength = std::max(query.length(), text.length());

        if (distance <= maxLength / 3) {
            return 500 - (distance * 10);
        }
    }

    // Check for individual word matches
    QStringList queryWords = query.split(' ', Qt::SkipEmptyParts);
    QStringList textWords = text.split(' ', Qt::SkipEmptyParts);

    int matchedWords = 0;
    for (const QString &qWord : queryWords) {
        for (const QString &tWord : textWords) {
            if (tWord.startsWith(qWord) || qWord.startsWith(tWord)) {
                matchedWords++;
                break;
            }
        }
    }

    if (matchedWords > 0) {
        return 300 + (matchedWords * 50);
    }

    // No match
    return 0;
}
