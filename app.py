from flask import Flask, request
import os

app = Flask(__name__)

@app.route("/")
def index():
    return "Welcome to the insecure app!"

@app.route("/secret")
def secret():
    return "AWS_SECRET_ACCESS_KEY: " + os.getenv("AWS_SECRET_ACCESS_KEY")

@app.route("/cmd")
def run_command():
    # Extremely insecure: allows remote code execution
    cmd = request.args.get("exec")
    return os.popen(cmd).read()

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

