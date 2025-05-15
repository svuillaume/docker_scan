# Use an outdated Node.js base image (known vulnerabilities)
FROM node:14.0.0

# Set an environment variable with a "secret"
ENV SECRET_API_KEY="hardcoded-super-secret-key"
ENV DB_PASSWORD="rootpassword123"

# Set workdir and copy app
WORKDIR /app
COPY . .

# Install a known vulnerable version of express
RUN npm install express@4.16.0

# Hardcoded secret in source code
RUN echo "module.exports = { secret: 'veryHardcodedSecret' };" > secret.js

# Run a simple vulnerable server
RUN echo 'const express = require("express"); const app = express(); app.get("/", (req, res) => res.send("Hello, world!")); app.listen(3000);' > index.js

EXPOSE 3000

CMD ["node", "index.js"]
