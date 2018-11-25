#ifndef CHECKDATABASE_H
#define CHECKDATABASE_H
#include<QDebug>
#include<QObject>
#include <QSqlDatabase>
#include<QStandardPaths>
#include<QDir>
#include<QSqlQuery>
#include <QSqlError>

class  createDatabase:public QObject
{

  Q_OBJECT
private :
    QString dbFileName;

public :
    createDatabase(QObject *parent=nullptr);
    ~ createDatabase();
    Q_INVOKABLE bool checkDbExists();
    Q_INVOKABLE bool createDbFile(QString dbName,QString tableName);
    Q_INVOKABLE bool createUserInfo(QString dbName,QString tableName);
    QString dbPath;
    QStringList tableList = {"MON","TUE","WED","THU","FRI","SAT","SUN"};
    QString userInfoTableName = "userinfo";
};




#endif // CHECKDATABASE_H
