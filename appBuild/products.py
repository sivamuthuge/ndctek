
import requests
import json

# Making a get request
response = requests.get('https://reqres.in/api/products/')


#print(response.content)

cont = json.loads(response.content.decode())
#print(cont)
print("-------")
print("Product")
print("-------")
for item in cont['data']:
    print(item['name'])

print("-------")
