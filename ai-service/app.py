from flask import Flask, request, jsonify
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import random
import time

app = Flask(__name__)

REQUEST_COUNT = Counter('app_requests_total', 'Total requests', ['endpoint'])
PREDICTION_LATENCY = Histogram('prediction_latency_seconds', 'Time spent generating a prediction')

@app.route('/health')
def health():
    REQUEST_COUNT.labels(endpoint='/health').inc()
    return jsonify({"status": "ok"}), 200

@app.route('/predict', methods=['POST'])
def predict():
    REQUEST_COUNT.labels(endpoint='/predict').inc()
    start = time.time()

    data = request.get_json(force=True) or {}
    distance_km = float(data.get('distance_km', 10))
    current_load = float(data.get('current_load', 0.5))  # 0.0 - 1.0, how busy the fleet is

    # Mock model: base speed of 40km/h, slowed down by current fleet load,
    # plus a bit of random noise to simulate real-world variance.
    base_speed_kmh = 40 * (1 - (current_load * 0.4))
    eta_minutes = round((distance_km / base_speed_kmh) * 60 + random.uniform(-3, 3), 1)

    PREDICTION_LATENCY.observe(time.time() - start)

    return jsonify({
        "distance_km": distance_km,
        "current_load": current_load,
        "eta_minutes": max(eta_minutes, 1)
    }), 200

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
