#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "checkdatabase.h"
#include "shareutils.h"
#include "timetable.h"
#include "sortfilterclass.h"
#include "userinfo.h"
#include <QQmlContext>
#include "emailutils.h"
#include "notification.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("material");
    QGuiApplication app(argc, argv);

    /*register cpp types to qml engine*/
    int ok = qmlRegisterType<ShareUtils>("QtShareButton", 1, 0, "ShareUtils");
   // qDebug() <<ok;
    ok = qmlRegisterType<QLSqlTimeTableModel>("TimeTableModel.custom", 1, 0, "QLSqlTimeTableModel");
   // qDebug() <<ok;
    ok = qmlRegisterType<customModelfilterClass>("sqlfilter.custom", 1, 0,"SqlFilterModel");
   // qDebug() <<ok;
    ok = qmlRegisterType<emailUtils>("QtEmailIntent", 1, 0, "EmailIntent");
   // qDebug() <<ok;

    createDatabase dbcheck;

    QSqlDatabase *question_table = new QSqlDatabase(QSqlDatabase::addDatabase("QSQLITE"));
    question_table->setDatabaseName(dbcheck.dbPath);
    if (!(question_table->open())) {
        qDebug() <<" main.c : database open failed " <<question_table->lastError();
        return -1;
    }

    QLSqlTimeTableModel timeTableObj(nullptr,*question_table);
    timeTableObj.setTable("MON");
    timeTableObj.setEditStrategy(QSqlTableModel::OnManualSubmit);
    timeTableObj.select();
    timeTableObj.generateRoleNames();

    NotificationClient *notificationClient = new NotificationClient(&app);


   // timeTableObj.setsqlquery(dbcheck.tableList[0]);
    customModelfilterClass proxyModel;
    proxyModel.setSourceModel(&timeTableObj);
   // proxyModel.setDynamicSortFilter(true);
   // proxyModel.setSortRole(257);
   // proxyModel.sort(1,Qt::DescendingOrder);

    userdatamodel userinfo(nullptr,*question_table);
    userinfo.return_userinfo();

    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();
    context->setContextProperty("timeTableModel",&timeTableObj);
    context->setContextProperty("proxyModel",&proxyModel);
    context->setContextProperty("userInfo",&userinfo);
    context->setContextProperty("notificationClient",notificationClient);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

#if defined(Q_OS_ANDROID)
    QtAndroid::hideSplashScreen(1000);
#endif

    return app.exec();
}
