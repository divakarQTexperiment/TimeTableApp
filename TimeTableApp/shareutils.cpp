#include "shareutils.h"


PlatformShareUtils::PlatformShareUtils(QQuickItem *parent) : QQuickItem(parent)
{
    qDebug() << "PlatformShareUtils constructor called !!";
}

PlatformShareUtils::~PlatformShareUtils()
{
    qDebug() << "PlatformShareUtils destructor called !!";

}

#if defined(Q_OS_ANDROID)
AndroidShareUtils::AndroidShareUtils(QQuickItem* parent) : PlatformShareUtils(parent)
{
    qDebug() << "AndroidShareUtils constructor called!!";
}

AndroidShareUtils::~AndroidShareUtils()
{
    qDebug() << "AndroidShareUtils destructor called!!";
}

void AndroidShareUtils::share(const QString &text, const QUrl &url)
{
    QAndroidJniObject jsText = QAndroidJniObject::fromString(text);
    QAndroidJniObject jsUrl = QAndroidJniObject::fromString(url.toString());
    QAndroidJniObject::callStaticMethod<void>("com/lasconic/QShareUtils",
                                       "share",
                                       "(Ljava/lang/String;Ljava/lang/String;)V",
                                       jsText.object<jstring>(), jsUrl.object<jstring>());
}

#elif defined(Q_OS_LINUX)
linuxShareUtils::linuxShareUtils(QQuickItem* parent) : PlatformShareUtils(parent)
{
    qDebug() << "linuxShareUtils constructor called!!";

}

linuxShareUtils::~linuxShareUtils()
{
    qDebug() << "linuxShareUtils destructor called!!";
}

void linuxShareUtils::share(const QString &text, const QUrl &url)
{
    qDebug() << "this feature not implemented for this platform "<<text<<url;
}

#elif defined(Q_OS_WIN32)
windowsShareUtils::windowsShareUtils(QQuickItem* parent) : PlatformShareUtils(parent)
{
    qDebug() << "windowsShareUtils constructor called!!";

}

windowsShareUtils::~windowsShareUtils()
{
    qDebug() << "windowsShareUtils destructor called!!";
}

void windowsShareUtils::share(const QString &text, const QUrl &url)
{
    qDebug() << "this feature not implemented for this platform "<<text<<url;
}
#endif


ShareUtils::ShareUtils(QQuickItem *parent)
    : QQuickItem(parent)
{

#if defined(Q_OS_ANDROID)
    _pShareUtils = new AndroidShareUtils(this);
#elif defined(Q_OS_LINUX)
    _pShareUtils = new linuxShareUtils(this);
#elif defined(Q_OS_WIN32)
    _pShareUtils = new windowsShareUtils(this);
#endif
}

void ShareUtils::share(const QString &text, const QUrl &url)
{
    _pShareUtils->share(text, url);
}
