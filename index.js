const express = require('express');
const app = express();

// Azure App Service sets the PORT environment variable
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Server is running on port ${port}`);
});
