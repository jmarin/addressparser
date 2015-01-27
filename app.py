from flask import Flask
from flask import jsonify
from flask import abort
from flask import make_response
from flask import request
import usaddress

app = Flask(__name__)

@app.route('/address/parse', methods=['POST'])
def parse_address():
    if not request.json or not 'address' in request.json:
        print('received: ' + reuest)
        abort(400)
    result = {}
    components = usaddress.parse(request.json['address']) 
    for c in components:
        key = c[1]
        value = c[0]
        result[key] = value
        #print(key + ":" + value)
    response = {
      'input-address': request.json['address'],
      'result': result
    }
    return jsonify(response)


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error':'Not Found'}), 404)

if __name__ == '__main__':
    app.run(debug=True)
