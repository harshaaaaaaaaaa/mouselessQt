#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "userdatamanager.h"
#include "fuzzysearch.h"
#include "keyboardlayout.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    // Set application name and organization for QStandardPaths
    QCoreApplication::setOrganizationName("MouselessQt");
    QCoreApplication::setApplicationName("MouselessQt");

    QQmlApplicationEngine engine;

    // Create and register UserDataManager
    UserDataManager *userDataManager = new UserDataManager(&app);
    engine.rootContext()->setContextProperty("userDataManager", userDataManager);

    // Create and register FuzzySearch
    FuzzySearch *fuzzySearch = new FuzzySearch(&app);
    engine.rootContext()->setContextProperty("fuzzySearch", fuzzySearch);

    // Create and register KeyboardLayout
    KeyboardLayout *keyboardLayout = new KeyboardLayout(&app);
    engine.rootContext()->setContextProperty("keyboardLayout", keyboardLayout);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("practice", "Main");

    return app.exec();
}
