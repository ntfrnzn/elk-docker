import simplejson as json
import requests
import argparse

parser = argparse.ArgumentParser(description='Send a har file to logstash. Sends each entry as a separate document.  Removes the response.content field.')
parser.add_argument('-f', metavar='har-file', type=argparse.FileType('r'), dest="json_input", help='har file to parse and send')
parser.add_argument('-u', metavar='url', dest='host', default="http://localhost:8080", help='url of the logstash http receiver')

args = parser.parse_args()


json_data=args.json_input.read()
har=json.loads(json_data)
log = har['log']

browser=log['browser']['name']+"/"+log['browser']['version']

for entry in log['entries']:
    entry['browser']=browser
    del entry['response']['content']
    requests.put(args.host+"/har",data=json.dumps(entry))





    
