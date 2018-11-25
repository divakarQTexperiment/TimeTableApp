#ifndef USERINFO_H
#define USERINFO_H
#include<QSqlRelationalTableModel>
#include<QDebug>
#include<QSqlRecord>
#include<QSqlError>

class userdatamodel : public QSqlRelationalTableModel
{
    Q_OBJECT
    Q_PROPERTY(QStringList userinfo MEMBER userinfolist )
private:
public:
    userdatamodel(QObject *parent=nullptr, QSqlDatabase db=QSqlDatabase());
    ~userdatamodel();
    Q_INVOKABLE bool fill_user_info(QVariantList userInfo);
    QStringList userinfolist ;
    QString userInfoTableName="userinfo";
    Q_INVOKABLE bool return_userinfo();
};

#endif // USERINFO_H
