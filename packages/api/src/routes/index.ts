import { Response, Request, NextFunction } from "express";

export default class Routes {
  public routes(app: any): void {
    app.route("/").get((_: Request, res: Response, next: NextFunction) => {
      res.status(200).send({
        message: "Default route",
      });
      next();
    });
  }
}
