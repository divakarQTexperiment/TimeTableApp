#include"checkdatabase.h"

createDatabase::createDatabase(QObject *parent):QObject(parent)
{
    qDebug() << "createDatabase::createDatabase : copyobj constructor called";
    this->dbPath = "";
    this->dbFileName = "TimeTableDB.db";
    if(checkDbExists())
    {
        qDebug() << "database check success";
    }
    else
    {
        qDebug() << "database check failure !!";

    }
}
createDatabase::~createDatabase()
{
    qDebug() << "createDatabase::createDatabase : copyobj destructor called";
}


bool createDatabase::createDbFile(QString dbName,QString tableName)
{
    QString queryToExec =" CREATE TABLE "+tableName+" (taskNo integer PRIMARY KEY,"
                         "task varchar(150),note varchar(150),fromHour integer,"
                         "fromMin integer,toHour integer,toMin integer)";
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    db.setDatabaseName(dbName);
    if(!db.open())
    {
        qDebug() << "failed to open database !!"<< db.lastError();
        return false;
    }

    if(!db.transaction())
    {
        qDebug() << "database transaction failed !!" << db.lastError();
        return false;
    }
    QSqlQuery query;
    if(!query.exec(queryToExec))
    {
        qDebug() << "database query exec failed !!" << query.lastError();
        return false;
    }
#if 1
   bool exec = query.exec("INSERT INTO "+tableName+" VALUES(1,'english','carry english note book',9,0,10,15)");
   exec = query.exec("INSERT INTO "+tableName+" VALUES(2,'maths','carry english note book',1,0,2,15)");
   exec = query.exec("INSERT INTO "+tableName+" VALUES(3,'kannada','carry english note book',12,0,2,15)");
   exec = query.exec("INSERT INTO "+tableName+" VALUES(4,'english','carry english note book',23,0,24,0)");
#endif

   if (!db.commit())
   {
       qDebug() << "database query exec failed !!" << db.lastError();
       return false;
   }
   return true;
}



bool createDatabase::createUserInfo(QString dbName,QString tableName)
{
    QString queryToExec = "create table IF NOT EXISTS "
                    +tableName+" (id INTEGER primary key,name TEXT,"
                    "age TEXT,city TEXT,phone TEXT,emailid TEXT,"
                    "education TEXT)";

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    db.setDatabaseName(dbName);
    if(!db.open())
    {
        qDebug() << "failed to open database !!"<< db.lastError();
        return false;
    }

    if(!db.transaction())
    {
        qDebug() << "database transaction failed !!" << db.lastError();
        return false;
    }
    QSqlQuery query;
    if(!query.exec(queryToExec))
    {
        qDebug() << "database query exec failed !!" << query.lastError();
        return false;
    }
#if 1
   bool exec = query.exec("INSERT INTO "+tableName+" VALUES(1,'divakar','25','bang','1111','div@sas.com','BE')");
#endif

   if (!db.commit())
   {
       qDebug() << "database query exec failed !!" << db.lastError();
       return false;
   }
   return true;
}


bool createDatabase::checkDbExists()
{
    QString mDataRoot = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);   //QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).value(0);
    qDebug() <<"createDatabase::checkDbExists : " <<mDataRoot;
    qDebug() <<"createDatabase::checkDbExists : " <<QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).value(0);
    QDir myDir;
    bool exists;
    exists = myDir.exists(mDataRoot);
    if (!exists) {
        bool ok = myDir.mkpath(mDataRoot);
        if(!ok) {
            qDebug() << "Couldn't create mDataRoot " << mDataRoot;
            return false;
        }
        else {
        qDebug() << "createDatabase::checkDbExists : created directory mDataRoot " << mDataRoot;
        }
    }

    QString path = mDataRoot +"/"+ this->dbFileName;
    exists = QFile::exists(path);
    if(!exists)
    {
        for(int i=0;i<this->tableList.length();i++)
        {
            if(!this->createDbFile(path,this->tableList[i]))
            {
                qDebug() << "createDbFile failed !!"<<this->tableList[i];
                return false;
            }
        }
        if(!createUserInfo(path,this->userInfoTableName))
        {
            qDebug() << "userinfo table creation failed";
            return false;
        }
    }

    else {
        qDebug() << "createDatabase::checkDbExists : db file already there in appdatalocation !!";
    }
    this->dbPath = path;
    return true;
}
