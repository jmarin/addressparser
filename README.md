# addressparser

REST API to break address into its indivivual components

## Installation

The service depends on the [Flask Microframework](http://flask.pocoo.org/) and the [US Address parsing library](https://github.com/datamade/usaddress)


```
pip install usaddress
pip install flask
```

## Usage

The service can be run directly with:

```
python app.py
```

Send a POST request to `/addresses/parse` with a JSON object such as the following:

```json
{
	"id":1,
	"address":"1311 30th st washington dc 20007"
}
```

The service should respond with:

```json
{
  "input-address": "1311 30th st washington dc 20007",
    "result": {
       "AddressNumber": "1311",
       "PlaceName": "washington",
       "StateName": "dc",
       "StreetName": "30th",
       "StreetNamePostType": "st",
       "ZipCode": "20007"
   }
}
```
