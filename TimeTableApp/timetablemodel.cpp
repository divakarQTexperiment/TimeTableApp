#include "timetable.h"

/* relational table model for Time table feature code*/
QLSqlTimeTableModel::QLSqlTimeTableModel(QObject *parent, QSqlDatabase db ):QSqlRelationalTableModel(parent, db ) {

    qDebug() << "QLSqlTimeTableModel::QLSqlTimeTableModel : QLSqlTimeTableModel constructor called";
    //qDebug() << "executing query for table "+MyTableName;
    //setsqlquery("MON");
}

QLSqlTimeTableModel::~QLSqlTimeTableModel() {

    qDebug() << "QLSqlTimeTableModel::~QLSqlTimeTableModel : QLSqlTimeTableModel destructor called";
}


QVariant QLSqlTimeTableModel::data( const QModelIndex & index, int role ) const
{
    if(index.row() >= rowCount())
    {
        return QString("");
    }
    if(role < Qt::UserRole)
    {
        return QSqlRelationalTableModel::data(index, role);
    }
    else
    {
        // search for relationships
        for (int i = 0; i < columnCount(); i++)
        {
            if (this->relation(i).isValid())
            {
            return record(index.row()).value(QString(roles.value(role)));
            }
        }
    // if no valid relationship was found
    return QSqlRelationalTableModel::data(this->index(index.row(), role - Qt::UserRole - 1), Qt::DisplayRole);
    }
}


void QLSqlTimeTableModel::generateRoleNames()
{
    roles.clear();

    for( int i = 0; i < record().count(); i ++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }

   // qDebug() <<"time table roles->>>>>"<< roles;

//#ifndef HAVE_QT5
//    setRoleNames(roles);
//#endif
}

int QLSqlTimeTableModel::setsqlquery(QString tableName)
{

    this->setTable(tableName);
    this->setEditStrategy(QSqlTableModel::OnManualSubmit);

    /*sorting data based on fromTime*/
//    QSqlRecord tempRec = this->record();
//    int indx = tempRec.indexOf("fromHour");
//    if(indx == -1)
//    {
//        qDebug() << "invalid index -1";
//        return -1;
//    }
//    this->setSort(indx,Qt::SortOrder::AscendingOrder);

    if(this->select()) {
        this->generateRoleNames();
    }
    else {
        qDebug() << "QLSqlTimeTableModel::setsqlquery : query exec failed "<< this->lastError();
        return -1;
    }

    return 0;
}


bool QLSqlTimeTableModel::setDbData(QString TableName,int rowNo, QVariantList data)
{
   // QVariantList data = {1,"social","tommorow no class",9,0,10,15};
        this->setTable(TableName);
        this->setEditStrategy(QSqlTableModel::OnManualSubmit);
        bool k = this->select();
        if(!k)
        {
            qDebug() << "QLSqlTimeTableModel::InsertNewDatadb select statement failed !!";
            return false;
        }
      // int  rowCount = this->rowCount();

        QSqlRecord tempRec = this->record();
       // qDebug() << tempRec;
        int colCount = this->columnCount();
        for(int index = 0;index < colCount;index++)
        {
           // if(index > 0)
                tempRec.setValue(index ,data[index]);
        }
      //  qDebug() << tempRec;
        k = this->setRecord(rowNo,tempRec);
        if(!k) {
         qDebug() << "QLSqlTimeTableModel::InsertNewDatadb : query exec failed "<< this->lastError();
         return k;
        }
        k =  this->submitAll();
        if(!k) {
         qDebug() << "QLSqlTimeTableModel::InsertNewDatadb : submitAll failed "<< this->lastError();
         return k;
        }
        return k;
}

void QLSqlTimeTableModel::setSort(int column, Qt::SortOrder order)
{
    QSqlTableModel::setSort(column,order);
}

bool QLSqlTimeTableModel::append(QString TableName )
{
    int totalRows = 0,taskNo=0;
    QVariantList data = {"social","tommorow no class",9,0,10,15};

    this->setTable(TableName);
    this->setEditStrategy(QSqlTableModel::OnManualSubmit);
    bool k = this->select();
    if(!k)
    {
        qDebug() << "QLSqlTimeTableModel::InsertNewDatadb select statement failed !!";
        return k;
    }
    totalRows = this->rowCount();
    QSqlRecord lastRow = this->record(totalRows-1);
    //qDebug() << lastRow;
    int indx = lastRow.indexOf("taskNo");
    if(indx == -1)
    {
        qDebug() << "invalid index -1";
        return false;
    }
    QVariant qVar = lastRow.value(indx);
    if(!qVar.isValid())
    {
        taskNo = 0;
    }
    else
    {
        taskNo = qVar.toInt();
    }
   // qDebug() << taskNo;

    if(totalRows < MAXACTIVITYCOUNT)
    {

        QSqlRecord tempRec = this->record();
        int colCount = this->columnCount();
        for(int index = 0;index < colCount;index++)
        {
           // qDebug() << tempRec;
            if(index == 0)
                tempRec.setValue(index ,taskNo+1);
            else
                tempRec.setValue(index ,data[index-1]);
        }

        k = this->insertRecord(totalRows,tempRec);
        //k = this->setRecord(totalRows,tempRec);
        if(!k)
        {
         qDebug() << "QLSqlTimeTableModel::InsertNewDatadb : query exec failed "<< this->lastError();
         return k;
        }
        k =  this->submitAll();
        if(!k) {
         qDebug() << "QLSqlTimeTableModel::InsertNewDatadb : submitAll failed "<< this->lastError();
         return k;
        }
        return k;

    }
    else
    {
        qDebug() << "Cant Add more Row already crossed maxrows count "<<MAXACTIVITYCOUNT;
        return false;
    }
}

bool QLSqlTimeTableModel::remove(int index,QString TableName)
{
    bool k;
    this->setTable(TableName);
    this->setEditStrategy(QSqlTableModel::OnManualSubmit);

    /*sorting data based on fromTime*/
//    QSqlRecord tempRec = this->record();
//    int indx = tempRec.indexOf("fromHour");
//    if(indx == -1)
//    {
//        qDebug() << "invalid index -1";
//        return -1;
//    }
//    this->setSort(indx,Qt::SortOrder::AscendingOrder);

    k = this->select();
    if(!k)
    {
        qDebug() << "QLSqlTimeTableModel:remove select statement failed !!";
        return k;
    }
   // QModelIndex parent = this->index(index,1);
   // beginRemoveRows(parent,index,index);
    k =  this->removeRow(index);
    if( k == false) {
        qDebug() << "QLSqlTimeTableModel:remove failed " <<this->lastError();
        return k;
    }

    //endRemoveRows();

    k =  this->submitAll();
    if(!k) {
        qDebug() << "QLSqlTimeTableModel::remove : submitAll failed "<< this->lastError();
        return k;
    }

    return k;
}
