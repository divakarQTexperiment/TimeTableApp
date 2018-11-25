#include"sortfilterclass.h"
#include "timetable.h"
#include <QDebug>

customModelfilterClass::customModelfilterClass(QObject *parent ,QAbstractItemModel * sourceModel): QSortFilterProxyModel (parent)
{
    qDebug() << "customModelfilterClass constructor called";
    this->setSourceModel(sourceModel);
}

customModelfilterClass::~customModelfilterClass()
{
    qDebug() << "customModelfilterClass destructor called";
}

void customModelfilterClass::setSourceModel(QAbstractItemModel * sourceModel)
{
    QSortFilterProxyModel::setSourceModel(sourceModel);
    qDebug() << "source model is set";
}


QLSqlTimeTableModel * customModelfilterClass::sourceModel()
{
    return ((QLSqlTimeTableModel *) QSortFilterProxyModel::sourceModel());
}

//bool customModelfilterClass::removeRows(int row, int count, const QModelIndex &parent)
//{
// QModelIndex id = this->index(row,0) ; //this->parent(this->index(1,1))
// qDebug() << id<<id.isValid()<<id.data(257).toInt()<<id.column()<<id.row()<<id.parent()<<id.parent().isValid();
// beginRemoveRows(id.parent(),row,row);
////bool k = sourceModel()->remove(row,"MON");
// bool k =sourceModel()->removeRow(row,QModelIndex());
// qDebug() << k;
//k = sourceModel()->submitAll();
// qDebug() << k;
// //emit rowsRemoved(id.row(),id.row());


//// sourceModel()->setsqlquery("MON");
//// sourceModel()->setTable("MON");
//// sourceModel()->setEditStrategy(QSqlTableModel::OnManualSubmit);
//// sourceModel()->select();
//// sourceModel()->generateRoleNames();
////
//  endRemoveRows();


// return k;
//}


//bool customModelfilterClass::removeRow(int row, const QModelIndex &parent)
//{
// QModelIndex id = this->index(row,0) ;
//// qDebug() << id<<id.isValid()<<id.data(257).toInt()<<id.column()<<id.row()<<id.parent()<<id.parent().isValid();
// beginRemoveRows(id.parent(),row,row);
// bool k =removeRows(row,1,QModelIndex());
// qDebug() << k;
//k = sourceModel()->submitAll();
// qDebug() << k;
// //emit rowsRemoved(id.row(),id.row());

//  endRemoveRows();


// return k;
//}

bool customModelfilterClass::removeRows(int position, int rows, const QModelIndex &index)
{
    qDebug() << position <<rows;
    Q_UNUSED(index);
    beginRemoveRows(QModelIndex(), position, position+rows-1);

    for (int row=0; row < rows; ++row) {
       // QSortFilterProxyModel::removeRows(position);

        // qDebug() <<"pppp" <<sourceModel()->removeRow(position)<<sourceModel()->lastError();
        // qDebug() <<"oooo" <<sourceModel()->submitAll();
        QSortFilterProxyModel::removeRows(position,rows);
        submit();
    }

qDebug() << sourceModel()->submitAll();
     //sourceModel()->select();
    endRemoveRows();


    // qDebug() <<"pppp" <<sourceModel()->removeRow(position)<<sourceModel()->lastError();
    // qDebug() <<"oooo" <<sourceModel()->submitAll();
    return true;
}
