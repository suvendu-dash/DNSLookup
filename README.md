# DNSLookupTool
A comprehensive script for gathering detailed DNS information and performing network reconnaissance. Leverages multiple tools to query DNS records, perform reverse DNS lookups, attempt zone transfers, and more. Designed for network administrators and cybersecurity professionals to enhance domain analysis and security assessments.

# Features
- **Name Server Lookup:** Retrieves the list of Name Servers (NS) associated with a given domain.
- **A and AAAA Records:** Queries for A (IPv4) and AAAA (IPv6) records, mapping the domain to its respective IP addresses.
- **MX Records:** Fetches MX (Mail Exchange) records, identifying the mail servers responsible for email handling for the domain.
- **TXT Records Analysis:** Gathers TXT records, which can include SPF (Sender Policy Framework) and DMARC (Domain-based Message Authentication, Reporting, and Conformance) policies.
- **SRV Records:** Looks up SRV (Service) records, detailing the location of services provided under the domain.
- **Reverse DNS Lookups:** Performs reverse DNS lookups for the IP addresses found in the A records, to find associated domain names.
- **Zone Transfer Attempt:** Tries to execute a DNS Zone Transfer (AXFR) from the domain's Name Servers, which could enumerate all the DNS records for the domain.
- **Public IP Discovery:** Utilizes the OpenDNS service to find the public IP address of the machine running the script.
- **Traceroute:** Executes a traceroute command to the domain, mapping the network path packets take from the host to the target domain.
- **Shodan Integration:** Makes advanced API calls to Shodan to gather comprehensive information about the domain's internet-facing infrastructure.
- **Comprehensive Reporting:** Outputs all collected information into a structured text file (<domain>_dns_info.txt), providing a detailed report of the DNS and network analysis.

# Prerequisites
Before running DNSLookup.sh, ensure you have the following installed:

- dig
- curl
- jq

# Installation
1. Clone the repository to your local machine:
   ```
   git clone https://github.com/yourusername/DNSLookupTool.git
   ```
3. Navigate to the script directory:
   ```
   cd DNSLookupTool
   ```
4. Make the script executable:
   ```
   chmod +x DNSLookup.sh
   ```
 # Configuration
 # Shodan API Key
DNSLookup.sh requires a Shodan API key to fetch additional information about the domain.

1. Sign up or log in to your account on [Shodan](https://www.shodan.io/).
2. Locate your API Key in your account settings.
3. Open DNSLookup.sh in a text editor and replace YOUR_SHODAN_API_KEY with your actual Shodan API key.

 # Usage
 To execute the script and perform DNS lookups on a domain:
 ```
./DNSLookup.sh example.com
```
Replace example.com with the domain you wish to investigate.

# Output
The script generates a detailed report named <domain>_dns_info.txt, containing all the DNS records and additional information gathered during the execution.

# Contributing
Contributions to DNSLookup.sh are welcome! Feel free to fork the repository, make improvements, and submit pull requests. If you encounter any issues or have suggestions, please open an issue in the GitHub repository.

# License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/suvendu-dash/DNSLookupTool/blob/main/LICENSE) file for details.
