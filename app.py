from flask import Flask, request, make_response
import os

app = Flask(__name__)

@app.route("/")
def index():
    resp = make_response("Welcome to the insecure app!")
    # Set a cookie 'foobar' with SameSite=None and Secure=False
    # ⚠️ Most browsers will ignore this because SameSite=None requires Secure
    resp.set_cookie(
        "foobar",
        "value123",
        samesite='None',
        secure=False
    )
    return resp

@app.route("/secret")
def secret():
    # Exposes environment variable (insecure)
    return "AWS_SECRET_ACCESS_KEY: " + os.getenv("AWS_SECRET_ACCESS_KEY", "not_set")

@app.route("/cmd")
def run_command():
    # ⚠️ Extremely insecure: allows remote code execution
    cmd = request.args.get("exec")
    if cmd:
        return os.popen(cmd).read()
    return "No command provided."

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
