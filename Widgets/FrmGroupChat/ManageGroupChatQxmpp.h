#ifndef MANAGEGROUPCHATQXMPP_H
#define MANAGEGROUPCHATQXMPP_H

#include <QObject>
#include <QMap>
#include "GroupChat.h"
#include "ManageGroupChat.h"

class CManageGroupChatQxmpp : public CManageGroupChat
{
    Q_OBJECT
public:
    explicit CManageGroupChatQxmpp(QObject *parent = 0);

    virtual int Create(const QString &szName,
                       const QString &szSubject,
                       const QString &szPassword = QString(),
                       const QString &szDescription = QString(),
                       bool bProtracted = false,
                       const QString &szNick = QString());
    virtual int Join(const QString &szId, const QString &szNick = QString());
    virtual QSharedPointer<CGroupChat> Get(const QString &szId);

signals:

public slots:
private:
};

#endif // MANAGEGROUPCHATQXMPP_H