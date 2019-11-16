const express = require("express");

const app = express();

app.use("/", (req, res) => {
  return res.json({ status: "ok", version: process.env.APPLICATION });
});

app.listen(3000, () => {
  console.log("Running");
});
