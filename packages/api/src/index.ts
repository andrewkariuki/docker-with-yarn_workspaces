import serve from "./serve";

const PORT: Number = 4000;

serve.listen(PORT, () => {
  console.log("Express server listening on port " + PORT);
});
