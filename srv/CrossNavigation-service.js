const cds = require("@sap/cds");
class CrossNavigation extends cds.ApplicationService {
  async init() {
    const {} = this.entities;
    await super.init();
  }
}
module.exports = { CrossNavigation };
