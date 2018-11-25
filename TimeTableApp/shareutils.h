#ifndef SHAREUTILS_H
#define SHAREUTILS_H

#include <QQuickItem>
#if defined(Q_OS_ANDROID)
#include <QtAndroidExtras>
#endif

class PlatformShareUtils : public QQuickItem
{
public:
    PlatformShareUtils(QQuickItem *parent = 0);
    virtual ~PlatformShareUtils();
    virtual void share(const QString &text, const QUrl &url){ qDebug() << text << url; }
};

#if defined(Q_OS_ANDROID)
class AndroidShareUtils : public PlatformShareUtils
{
public:
    AndroidShareUtils(QQuickItem* parent = 0);
    ~AndroidShareUtils();
    void share(const QString &text, const QUrl &url) override;
};

#elif defined(Q_OS_LINUX)
class linuxShareUtils : public PlatformShareUtils
{
public:
    linuxShareUtils(QQuickItem* parent = 0);
    ~linuxShareUtils();
    void share(const QString &text, const QUrl &url) override;
};

#elif defined(Q_OS_WIN_32)
class windowsShareUtils : public PlatformShareUtils
{
public:
    windowsShareUtils(QQuickItem* parent = 0);
    ~windowsShareUtils();
    void share(const QString &text, const QUrl &url) override;
};
#endif
class ShareUtils : public QQuickItem
{
    Q_OBJECT
    PlatformShareUtils* _pShareUtils;
public:
    explicit ShareUtils(QQuickItem *parent = 0);
    Q_INVOKABLE void share(const QString &text, const QUrl &url);
};

#endif // SHAREUTILS_H
