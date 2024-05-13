import requests

Address = "192.168.0.19:8000"

response = requests.get(Address)
print(response.text)