#include "userinfo.h"
#include"checkdatabase.h"
userdatamodel::userdatamodel(QObject *parent, QSqlDatabase db):QSqlRelationalTableModel(parent, db )
{
    qDebug() << "userdatamodel::userdatamodel : constructor called!!";


}

userdatamodel::~userdatamodel()
{
    qDebug() << "userdatamodel::userdatamodel : destructor called!!";
}

bool userdatamodel::fill_user_info(QVariantList userdata)
{

    QString tableName = this->userInfoTableName;
    setTable(tableName);
    this->setEditStrategy(QSqlTableModel::OnManualSubmit);
    bool k = this->select();
    if(!k)
    {
        qDebug() << "userdatamodel::fill_user_info select statement failed !!";
        return false;
    }
    int userIdNo  = 0;
    int rowNo = this->rowCount();
    qDebug() << "userdatamodel::fill_user_info : total row no " <<rowNo;

    int len = userdata.length();

    for(int i=1 ; i <= len ; i++) {
      k =  this->setData(this->index(userIdNo,i),userdata[i-1].toString(),Qt::EditRole);
      if(k != true) {
      qDebug() << "userdatamodel::fill_user_info : query exec failed "<< this->lastError()<<"----------exiting-----";
      return false;
      }
    }
    k =  this->submitAll();
    if(k != true) {
    qDebug() << "userdatamodel::fill_user_info : query exec failed "<< this->lastError()<<"----------exiting-----";
    return false;
    }

    return true;
}


bool userdatamodel::return_userinfo()
{

    QString tableName = this->userInfoTableName;
    QStringList userinfolist ;
    this->setTable(tableName);
   // this->setFilter("rowid=1");
    this->setEditStrategy(QSqlTableModel::OnManualSubmit);
    if(!this->select())
    {
        qDebug() << "userdatamodel::create_userinf_model : query exec failed "<< this->lastError();
        return false;
    }
    int len = this->columnCount();

    for(int col = 1 ; col <= len ; col++ )
    userinfolist.append(QString(this->data(this->index(0,col)).toString()));

    this->userinfolist = userinfolist;
   // qDebug() << this->userinfolist.at(0);

    return true;
}
