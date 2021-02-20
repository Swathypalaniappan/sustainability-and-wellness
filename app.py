from flask import Flask,jsonify
import random
Records = {
    "Normal": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(80, 120),
        "respiration": random.randint(12, 16),
        "glucose": random.randint(72, 140),
        "heartRate": random.randint(60, 100),
        "cholesterol": random.randint(125, 200),
        "oxygenSaturation": random.randint(95, 100),
    },
    "Diabetes": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(80, 120),
        "respiration": random.randint(12, 16),
        "glucose": random.randint(200, 350),
        "heartRate": random.randint(60, 100),
        "cholesterol": random.randint(125, 200),
        "oxygenSaturation": random.randint(95, 100)

    },

    "PreDiabetes": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(80, 120),
        "respiration": random.randint(12, 16),
        "glucose": random.randint(140, 199),
        "heartRate": random.randint(60, 100),
        "cholesterol": random.randint(125, 200),
        "oxygenSaturation": random.randint(95, 100)

    },

    "Bronchiectasis": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(90, 120),
        "respiration": random.randint(40, 60),
        "glucose": random.randint(72, 140),
        "heartRate": random.randint(60, 100),
        "cholesterol": random.randint(125, 200),
        "oxygenSaturation": random.randint(95, 100),
    },

    "CongenitalHeartDefect": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(90, 120),
        "respiration": random.randint(12, 16),
        "glucose": random.randint(72, 140),
        "heartRate": random.randint(45, 60),
        "cholesterol": random.randint(200, 270),
        "oxygenSaturation": random.randint(95, 100),
    },

    "Hypoxemia": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(90, 120),
        "respiration": random.randint(12, 16),
        "glucose": random.randint(72, 140),
        "heartRate": random.randint(60, 100),
        "cholesterol": random.randint(125, 200),
        "oxygenSaturation": random.randint(50, 96),
    },

    "AcuteAsthma": {
        "steps": random.randint(4000, 10000),
        "bodyTemperature": (round(random.uniform(35.5, 37.5), 1)),
        "bloodPressure": random.randint(90, 120),
        "respiration": random.randint(20, 30),
        "glucose": random.randint(72, 140),
        "heartRate": random.randint(100, 125),
        "cholesterol": random.randint(125, 200),
        "oxygenSaturation": random.randint(92, 95),
    }}
app = Flask(__name__)

@app.route('/simulation/<string:value>',methods=["GET"])

def simulation(value):
    return jsonify({'data' : Records[value],'message':'successful'})

if __name__ == "__main__":
    app.run(debug = True)