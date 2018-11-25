//javascript to create dynamic qml object

var component=null;
var obj=null;

function createObjects(filepath,parentItem) {

    component = Qt.createComponent(filepath);
    if (component.status === Component.Ready)
        finishCreation(parentItem);
    else {
        component.statusChanged.connect(finishCreation);
    }
   // return obj;
}

function finishCreation(parentItem) {
    if (component.status === Component.Ready) {
        obj = component.createObject(parentItem/*, {"x": 100, "y": 100}*/);
        if (obj === null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}

function createObjectsWithArg(filepath,parentItem,prop1,val1) {

    component = Qt.createComponent(filepath);
    if (component.status === Component.Ready)
        finishCreation(parentItem,prop1,val1);
    else {
        component.statusChanged.connect(finishCreation);
    }
   // return obj;
}

function finishCreationWithArg(parentItem,prop1,val1) {
    if (component.status === Component.Ready) {
        obj = component.createObject(parentItem, {prop1:val1});
        if (obj === null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}

