import express from "express";
import Routes from "./routes";

class Serve {
  public app: express.Application = express();
  public ApplicationRoutes: Routes = new Routes();
  constructor() {
    this.config();
    this.ApplicationRoutes.routes(this.app);
  }

  private config(): void {}
}

export default new Serve().app;
