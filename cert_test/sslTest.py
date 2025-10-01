import requests
cert_path = "/Users/AM33440/Downloads/cert_test/certs/combined_certs.pem" # please update this path as needed
response = requests.get("https://iam.cloud.ibm.com", verify=cert_path)
print("Status code:", response.status_code)
print("Response text:\n", response.text) 