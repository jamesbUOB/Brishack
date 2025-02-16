from flask import Flask, request, jsonify, Response
from flask_socketio import SocketIO, emit
import simulation

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")

@app.route('/end')
def get_data():
    # method for getting data from the frontend

    return "200"

@app.route('/end', methods=['POST'])
def send_data():
    data = request.get_json()

    socketio.emit('update', data)
    
    return "200"


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

    socketio.emit('update', "window opened")
    # flutter passes in parameters for starting condition


    simulation.main(start)

        
        


if __name__ == '__main__':
    socketio.run(app, host="127.0.0.1", port=5000, debug=True)