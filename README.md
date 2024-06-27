# Navigation from Elements -> Elements

It contains these simple two steps to recreate after you created the necessary Apps:
Actually 3 if you want the launch page for testing.

| File or Folder    | Purpose                                           |
| ----------------- | ------------------------------------------------- |
| `manifest.json`   | cross navigation inbound in target app            |
| `annotations.cds` | to create a link that navigates to the target app |

- manifest.json in target application

```json
"crossNavigation": {
      "inbounds": {
        "ApplicationName-display": {
          "semanticObject": "ApplicationName",
          "action": "display",
          "title": "{{flpTitle}}",
          "signature": {
            "parameters": {},
            "additionalParameters": "allowed"
          }
        }
      }
    }
    //TODO: change the application name to the name of your target application
```

- annotations.cds

```cds
annotate service.AlcoholInCup with {
    to_Alcohol @Common.SemanticObject : 'fiorielementsnavto'
};
annotate service.AlcoholInCup with {
    to_Alcohol @Common.SemanticObjectMapping : [
        {
            $Type : 'Common.SemanticObjectMappingType',
            LocalProperty : to_Alcohol_ID,
            SemanticObjectProperty : 'ID',
        },
    ]
};
//TODO: the semantic object references to the semantic object in the cross navigation inbound of your target app.
//TODO: the local Property should be the ID of your object you want to navigate to
//TODO: the semantic object property should be the name of the ID in the target app
// in this case:
//  to_Alcohol_ID (local property) is the UUID of the object in the outbound app.
//  ID (semantic object property) is the UUID of the object in the target app.
```

# Navigation from Elements -> Ui5

It contains these simple three steps to recreate after you created the necessary Apps:
Actually 4 if you want the launch page for testing.

| File or Folder    | Purpose                                                                 |
| ----------------- | ----------------------------------------------------------------------- |
| `manifest.json`   | cross navigation inbound in target app                                  |
| `annotations.cds` | to create a link that navigates to the target app                       |
| `components.js`   | startup parameters to replace the hash and navigate to the correct page |

- manifest.json in target application

```json
"crossNavigation": {
      "inbounds": {
        "ApplicationName-display": {
          "semanticObject": "ApplicationName",
          "action": "display",
          "title": "{{flpTitle}}",
          "signature": {
            "parameters": {},
            "additionalParameters": "allowed"
          }
        }
      }
    }
    //TODO: change the application name to the name of your target application
```

- annotations.cds

```cds
annotate service.LiquidInCup with {
    to_Liquid @Common.SemanticObject: 'ui5freestylenavto'
};
annotate service.LiquidInCup with {
    to_Liquid @Common.SemanticObjectMapping: [{
        $Type                 : 'Common.SemanticObjectMappingType',
        LocalProperty         : to_Liquid_ID,
        SemanticObjectProperty: 'ID',
    }, ]
};
//TODO: the semantic object references to the semantic object in the cross navigation inbound of your target app.
//TODO: the local Property should be the ID of your object you want to navigate to
//TODO: the semantic object property should be the name of the ID in the target app
// in this case:
//  to_Liquid_ID (local property) is the UUID of the object in the outbound app.
//  ID (semantic object property) is the UUID of the object in the target app.
```

- components.js in target application

```js
const oComponentData = this.getComponentData();
if (oComponentData.startupParameters && oComponentData.startupParameters.ID) {
  const hashChanger = sap.ui.core.routing.HashChanger.getInstance();
  hashChanger.replaceHash("Liquid/(" + oComponentData.startupParameters.ID[0] + ")");
}
//TODO: change the replace hash content with the name of your object
```

# Navigation from Ui5 -> Elements

It contains these simple three steps to recreate after you created the necessary Apps:
Actually 4 if you want the launch page for testing.

| File or Folder         | Purpose                                                                          |
| ---------------------- | -------------------------------------------------------------------------------- |
| `manifest.json`        | cross navigation inbound in target app                                           |
| `object.view.xml`      | to create a link that has the correct target property with the correct object ID |
| `object.controller.js` | to enable the cross navigation                                                   |

- manifest.json in target application

```json
"crossNavigation": {
      "inbounds": {
        "ApplicationName-display": {
          "semanticObject": "ApplicationName",
          "action": "display",
          "title": "{{flpTitle}}",
          "signature": {
            "parameters": {},
            "additionalParameters": "allowed"
          }
        }
      }
    }
    //TODO: change the application name to the name of your target application
```

- object.view.xml

```xml
<Link
    text="{to_Alcohol/Name}"
    target="{to_Alcohol_ID}"
    press=".navToAlcohol"
/>
<!-- TODO: change the text and target to the right object bindings and connect the function through a press event.
        this link tag is placed in a table -->
```

- object.controller.js

```js
navToAlcohol: function (oEvent) {
        var to_Alcohol_ID = oEvent.getSource().getProperty("target");
        if (sap.ushell && sap.ushell.Container && sap.ushell.Container.getService) {
          var oCrossAppNav = sap.ushell.Container.getService("CrossApplicationNavigation");
          oCrossAppNav.toExternal({
            target: { semanticObject: "fiorielementsnavto", action: "display" },
            params: { ID: [to_Alcohol_ID] },
          });
        }
      },
//TODO: the semantic object references to the semantic object in the cross navigation inbound of your target app.
//TODO: the parameter ID should be the ID of your object you want to navigate to
// in this case:
//  to_Alcohol_ID is the UUID of the object in the outbound app.
//  ID is the UUID of the object in the target app.
```

# Navigation from Ui5 -> Ui5

It contains these simple four steps to recreate after you created the necessary Apps:
Actually 4 if you want the launch page for testing.

| File or Folder         | Purpose                                                                          |
| ---------------------- | -------------------------------------------------------------------------------- |
| `manifest.json`        | cross navigation inbound in target app                                           |
| `object.view.xml`      | to create a link that has the correct target property with the correct object ID |
| `object.controller.js` | to enable the cross navigation                                                   |
| `components.js`        | startup parameters to replace the hash and navigate to the correct page          |

- manifest.json in target application

```json
"crossNavigation": {
      "inbounds": {
        "ApplicationName-display": {
          "semanticObject": "ApplicationName",
          "action": "display",
          "title": "{{flpTitle}}",
          "signature": {
            "parameters": {},
            "additionalParameters": "allowed"
          }
        }
      }
    }
    //TODO: change the application name to the name of your target application
```

- object.view.xml

```xml
<Link
    text="{to_Liquid/Name}"
    target="{to_Liquid_ID}"
    press=".navToLiquid"
/>
<!-- TODO: change the text and target to the right object bindings and connect the function through a press event.
        this link tag is placed in a table -->
```

- object.controller.js

```js
navToLiquid: function (oEvent) {
        //Navigation Script for Navigation from Ui5 to another Ui5 Application
        var to_Liquid_ID = oEvent.getSource().getProperty("target");
        if (sap.ushell && sap.ushell.Container && sap.ushell.Container.getService) {
          var oCrossAppNav = sap.ushell.Container.getService("CrossApplicationNavigation");
          oCrossAppNav.toExternal({
            target: { semanticObject: "ui5freestylenavto", action: "display" },
            params: { ID: [to_Liquid_ID] },
          });
        }
      },
//TODO: the semantic object references to the semantic object in the cross navigation inbound of your target app.
//TODO: the parameter ID should be the ID of your object you want to navigate to
// in this case:
//  to_Liquid_ID is the UUID of the object in the outbound app.
//  ID is the UUID of the object in the target app.
```

- components.js in target application

```js
const oComponentData = this.getComponentData();
if (oComponentData.startupParameters && oComponentData.startupParameters.ID) {
  const hashChanger = sap.ui.core.routing.HashChanger.getInstance();
  hashChanger.replaceHash("Liquid/(" + oComponentData.startupParameters.ID[0] + ")");
}
//TODO: change the replace hash content with the name of your object
```
