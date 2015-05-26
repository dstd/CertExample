# CertExample
Sample code for the response on StackOverflow

- in `-viewDidLoad` update `_baseURL` to your own address;
- get your certificate with command:
```
openssl s_client -servername YOUR_OWN_ADDRESS -connect YOUR_OWN_ADDRESS:443 </dev/null 2>/dev/null | openssl x509 -outform DER > ./api.cer
```
- replace `api.cer` (`Supporting Files` group of the project) with your certificate
