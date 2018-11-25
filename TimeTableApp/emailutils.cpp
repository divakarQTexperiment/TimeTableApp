#include "emailutils.h"


PlatformEmailUtils::PlatformEmailUtils(QQuickItem *parent) : QQuickItem(parent)
{
    qDebug() << "PlatformEmailUtils constructor called !!";
}

PlatformEmailUtils::~PlatformEmailUtils()
{
    qDebug() << "PlatformEmailUtils destructor called !!";

}

#if defined(Q_OS_ANDROID)
AndroidEmailUtils::AndroidEmailUtils(QQuickItem* parent) : PlatformEmailUtils(parent)
{
    qDebug() << "AndroidEmailUtils constructor called!!";
}

AndroidEmailUtils::~AndroidEmailUtils()
{
    qDebug() << "AndroidEmailUtils destructor called!!";
}

void AndroidEmailUtils::email(const QString &emailBody,const QString &subject ,const QString &emailId)
{
    QAndroidJniObject jsemailBody = QAndroidJniObject::fromString(emailBody);
    QAndroidJniObject jssubject = QAndroidJniObject::fromString(subject);
    QAndroidJniObject jsemailId = QAndroidJniObject::fromString(emailId);
    //QAndroidJniObject jsUrl = QAndroidJniObject::fromString(url.toString());
    QAndroidJniObject::callStaticMethod<void>("com/lasconic/QEmailUtils",
                                       "sendEmail",
                                       "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                                       jsemailBody.object<jstring>(), jssubject.object<jstring>(),
                                       jsemailId.object<jstring>());
}

#elif defined(Q_OS_LINUX)
linuxEmailUtils::linuxEmailUtils(QQuickItem* parent) : PlatformEmailUtils(parent)
{
    qDebug() << "linuxEmailUtils constructor called!!";

}

linuxEmailUtils::~linuxEmailUtils()
{
    qDebug() << "linuxEmailUtils destructor called!!";
}

void linuxEmailUtils::email(const QString &emailBody,const QString &subject ,const QString &emailId)
{
    qDebug() << "this feature not implemented for this platform "<< emailBody << subject << emailId;
}

#elif defined(Q_OS_WIN32)
windowsEmailUtils::windowsEmailUtils(QQuickItem* parent) : PlatformEmailUtils(parent)
{
    qDebug() << "windowsEmailUtils constructor called!!";

}

windowsEmailUtils::~windowsEmailUtils()
{
    qDebug() << "windowsEmailUtils destructor called!!";
}

void windowsEmailUtils::email(const QString &emailBody,const QString &subject ,const QString &emailId)
{
    qDebug() << "this feature not implemented for this platform "<< emailBody << subject << emailId;
}
#endif


emailUtils::emailUtils(QQuickItem *parent)
    : QQuickItem(parent)
{

#if defined(Q_OS_ANDROID)
    _pemailUtils = new AndroidEmailUtils(this);
#elif defined(Q_OS_LINUX)
    _pemailUtils = new linuxEmailUtils(this);
#elif defined(Q_OS_WIN32)
    _pemailUtils = new windowsEmailUtils(this);
#endif
}

void emailUtils::email(const QString &emailBody,const QString &subject ,const QString &emailId)
{
    _pemailUtils->email(emailBody, subject, emailId);
}
