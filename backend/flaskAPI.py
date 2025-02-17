import json
from flask import Flask, request, jsonify, Response
from flask_socketio import SocketIO, emit
import simulation
from flask_cors import CORS
import subprocess

app = Flask(__name__)
CORS(app)
socketio = SocketIO(app, cors_allowed_origins="*")

@app.after_request
def add_cors_headers(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
    return response


@app.route('/end', methods=['POST'])
def send_data():
    data = request.get_json()

    socketio.emit('update', data)
    
    return jsonify({"message": "Success"})


@app.before_request
def handle_preflight():
    if request.method == "OPTIONS":
        res = Response()
        res.headers['X-Content-Type-Options'] = '*'
        return res


@socketio.on('connect')
def handle_connect():
    print("Client connected")

@socketio.on('start')
def handle_message(start):
    print(f"Received message: {start}")

    # flutter passes in parameters for starting condition

    parameters = json.dumps(start)

    subprocess.Popen(["python", "simulation.py", parameters])
    


if __name__ == '__main__':
    socketio.run(app, host="127.0.0.1", port=5000, debug=False, use_reloader=False)