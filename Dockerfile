FROM node:10.0.0

# Optional: add secrets and unsafe practices
ENV AWS_SECRET_ACCESS_KEY="AKIAFAKE-EXAMPLE-DEMO1"

# Install packages that will show up in CVE databases
RUN npm install -g express

CMD ["node"]
