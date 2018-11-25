import QtQuick 2.0
import QtQml.Models 2.3

ListModel {
        id: drawermodel
        ListElement { name  : "Home"
                     source : "qrc:/images/home.png"
                     pagetoload : "qrc:/toolcomps/Home.qml"
        }
        ListElement { name : "Daily Time Table"
                    source : "qrc:/images/timetable.png"
                    pagetoload :"qrc:/pages/DailyTimeTable.qml"  // "qrc:/toolcomps/ex1.qml"

        }
        ListElement { name : "study Time table"
                    source : "qrc:/images/timetable.png"
                    pagetoload : "qrc:/toolcomps/NumTestListView.qml"


        }
        ListElement { name : "exam Time table"
                    source : "qrc:/images/timetable.png"
                    pagetoload : "qrc:/toolcomps/NumTestListView.qml"
        }

        ListElement { name : "User"
                    source : "qrc:/images/user.png"
                    pagetoload : "qrc:/pages/UserInfoPage.qml"
        }

        ListElement { name : "Feedback"
                    source : "qrc:/images/feedback.png"
                    pagetoload : "qrc:/pages/FeedBackPage.qml"
        }

        ListElement { name : "about"
                    source : "qrc:/images/about.png"
                    pagetoload : "qrc:/pages/AboutPage.qml"
        }
    }
