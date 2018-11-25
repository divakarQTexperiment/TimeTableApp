#ifndef EMAILUTILS_H
#define EMAILUTILS_H

#include <QQuickItem>
#if defined(Q_OS_ANDROID)
#include <QtAndroidExtras>
#endif

class PlatformEmailUtils : public QQuickItem
{
public:
    PlatformEmailUtils(QQuickItem *parent = 0);
    virtual ~PlatformEmailUtils();
    virtual void email(const QString &emailBody,const QString &subject ,const QString &emailId){ qDebug() << emailBody<< emailId << subject ; }
};

#if defined(Q_OS_ANDROID)
class AndroidEmailUtils : public PlatformEmailUtils
{
public:
    AndroidEmailUtils(QQuickItem* parent = 0);
    ~AndroidEmailUtils();
    void email(const QString &emailBody,const QString &subject ,const QString &emailId) override;
};

#elif defined(Q_OS_LINUX)
class linuxEmailUtils : public PlatformEmailUtils
{
public:
    linuxEmailUtils(QQuickItem* parent = 0);
    ~linuxEmailUtils();
    void email(const QString &emailBody,const QString &subject ,const QString &emailId) override;
};

#elif defined(Q_OS_WIN_32)
class windowsEmailUtils : public PlatformEmailUtils
{
public:
    windowsEmailUtils(QQuickItem* parent = 0);
    ~windowsEmailUtils();
    void email(const QString &emailBody,const QString &subject ,const QString &emailId) override;
};
#endif
class emailUtils : public QQuickItem
{
    Q_OBJECT
    PlatformEmailUtils* _pemailUtils;
public:
    explicit emailUtils(QQuickItem *parent = 0);
    Q_INVOKABLE void email(const QString &emailBody,const QString &subject ,const QString &emailId);
};

#endif // EMAILUTILS_H
