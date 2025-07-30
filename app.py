from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from db_config import db_config

app = Flask(__name__)
CORS(app)  # Allow React frontend to access API

@app.route("/")
def home():
    return "Flask API is running!"

@app.route("/add-category", methods=["POST"])
def add_category():
    data = request.json
    name = data.get("name")
    taxable = data.get("taxable")
    age_restricted = data.get("age_restricted")
    ebt_eligible = data.get("ebt_eligible")

    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        sql = """
        INSERT INTO product_category (name, taxable, age_restricted, ebt_eligible)
        VALUES (%s, %s, %s, %s)
        """
        cursor.execute(sql, (name, taxable, age_restricted, ebt_eligible))
        conn.commit()
        return jsonify({"message": "Category added successfully!"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

