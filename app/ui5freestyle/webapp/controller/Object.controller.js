sap.ui.define(
  [
    "./BaseController",
    "sap/ui/model/json/JSONModel",
    "sap/ui/core/routing/History",
    "../model/formatter",
    "sap/ui/core/UIComponent",
  ],
  function (BaseController, JSONModel, History, formatter, UIComponent) {
    "use strict";
    return BaseController.extend("ui5freestyle.controller.Object", {
      formatter: formatter,

      /* =========================================================== */
      /* lifecycle methods                                           */
      /* =========================================================== */

      /**
       * Called when the worklist controller is instantiated.
       * @public
       */
      onInit: function () {
        // Model used to manipulate control states. The chosen values make sure,
        // detail page shows busy indication immediately so there is no break in
        // between the busy indication for loading the view's meta data
        var oViewModel = new JSONModel({
          busy: true,
          delay: 0,
        });
        var oRouter = UIComponent.getRouterFor(this);
        oRouter.getRoute("object").attachPatternMatched(this._onObjectMatched, this);
        this.setModel(oViewModel, "objectView");
      },
      /* =========================================================== */
      /* event handlers                                              */
      /* =========================================================== */

      /**
       * Event handler  for navigating back.
       * It there is a history entry we go one step back in the browser history
       * If not, it will replace the current entry of the browser history with the worklist route.
       * @public
       */
      onNavBack: function () {
        this.getRouter().navTo("worklist", {}, true);
      },
      navToAlcohol: function (oEvent) {
        //Navigation Script for Navigation from Ui5 to Fiori Elements
        var to_Alcohol_ID = oEvent.getSource().getProperty("target");
        if (sap.ushell && sap.ushell.Container && sap.ushell.Container.getService) {
          var oCrossAppNav = sap.ushell.Container.getService("CrossApplicationNavigation");
          oCrossAppNav.toExternal({
            target: { semanticObject: "fiorielementsnavto", action: "display" },
            params: { ID: [to_Alcohol_ID] },
          });
        }
      },
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

      /* =========================================================== */
      /* internal methods                                            */
      /* =========================================================== */

      /**
       * Binds the view to the object path.
       * @function
       * @param {sap.ui.base.Event} oEvent pattern match event in route 'object'
       * @private
       */
      _onObjectMatched: function (oEvent) {
        var key = oEvent.getParameter("arguments").key;
        this._bindView("/Cup" + key);
      },

      /**
       * Binds the view to the object path.
       * @function
       * @param {string} sObjectPath path to the object to be bound
       * @private
       */
      _bindView: function (sObjectPath) {
        var oViewModel = this.getModel("objectView");

        this.getView().bindElement({
          path: sObjectPath,
          events: {
            change: this._onBindingChange.bind(this),
            dataRequested: function () {
              oViewModel.setProperty("/busy", true);
            },
            dataReceived: function () {
              oViewModel.setProperty("/busy", false);
            },
          },
        });
      },

      _onBindingChange: function () {
        var oView = this.getView(),
          oViewModel = this.getModel("objectView"),
          oElementBinding = oView.getElementBinding();

        // No data for the binding
        if (!oElementBinding.getBoundContext()) {
          this.getRouter().getTargets().display("objectNotFound");
          return;
        }

        var oResourceBundle = this.getResourceBundle(),
          oObject = oView.getBindingContext().getObject(),
          sObjectId = oObject.ID,
          sObjectName = oObject.Liquid;

        oViewModel.setProperty("/busy", false);
        oViewModel.setProperty(
          "/shareSendEmailSubject",
          oResourceBundle.getText("shareSendEmailObjectSubject", [sObjectId])
        );
        oViewModel.setProperty(
          "/shareSendEmailMessage",
          oResourceBundle.getText("shareSendEmailObjectMessage", [
            sObjectName,
            sObjectId,
            location.href,
          ])
        );
      },
    });
  }
);
