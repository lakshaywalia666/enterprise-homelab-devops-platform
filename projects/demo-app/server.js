const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.json({
    message: "Enterprise Homelab Demo App is running",
    status: "success",
    environment: process.env.APP_ENV || "local",
    version: "1.0.0"
  });
});

app.get("/health", (req, res) => {
  res.json({
    status: "healthy",
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

app.get("/version", (req, res) => {
  res.json({
    app: "homelab-demo-app",
    version: "1.0.0"
  });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Demo app running on port ${PORT}`);
});
