#!/bin/bash

# Function to check command availability
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if required commands are available
if ! command_exists dig || ! command_exists curl || ! command_exists jq; then
  echo "Error: This script requires 'dig', 'curl', and 'jq' commands to be installed."
  exit 1
fi

# API Key for Shodan - replace with your actual API key
SHODAN_API_KEY="YOUR_SHODAN_API_KEY"

# Check if a domain has been passed as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1
OUTPUT_FILE="${DOMAIN}_dns_info.txt"

# Define API query function for Shodan
query_shodan() {
    echo "Shodan search for $DOMAIN:"
    curl -s "https://api.shodan.io/dns/domain/$DOMAIN?key=$SHODAN_API_KEY" | jq '.'
}

# Main script execution
{
  echo "Advanced DNS Information for: $DOMAIN"
  echo "====================================================="
  
  # Get the list of Name Servers for the domain
  echo "Name Servers:"
  dig NS $DOMAIN +short
  echo
  
  # Get A and AAAA records
  echo "A (IPv4) records:"
  dig A $DOMAIN +noall +answer
  echo
  echo "AAAA (IPv6) records:"
  dig AAAA $DOMAIN +noall +answer
  echo

  # Get MX records
  echo "MX (Mail Exchange) records:"
  dig MX $DOMAIN +noall +answer
  echo

  # Get TXT records, including SPF and DMARC
  echo "TXT records:"
  dig TXT $DOMAIN +noall +answer
  echo
  echo "SPF records:"
  dig TXT $DOMAIN +short | grep "v=spf1"
  echo
  echo "DMARC records:"
  dig TXT _dmarc.$DOMAIN +short

  # Get SRV records
  echo "SRV records:"
  dig SRV $DOMAIN +noall +answer
  echo

  # Perform reverse DNS lookups on A records
  echo "Reverse DNS Lookup results:"
  for ip in $(dig +short A $DOMAIN); do
    echo "Reverse DNS for $ip:"
    dig -x $ip +noall +answer
    echo
  done

  # Zone Transfer attempt
  echo "Attempting Zone Transfer:"
  for ns in $(dig NS $DOMAIN +short); do
    echo "Trying $ns..."
    dig AXFR $DOMAIN @$ns
  done
  echo

  # What is my IP - using OpenDNS service
  echo "Public IP of this machine:"
  dig +short myip.opendns.com @resolver1.opendns.com
  echo

  # Traceroute to the domain
  echo "Traceroute to $DOMAIN (may require root privileges):"
  traceroute $DOMAIN

  # Advanced API check for Shodan
  echo "====================================================="
  echo "Performing advanced check via Shodan API:"
  query_shodan

} | tee "$OUTPUT_FILE"

echo "DNS information, including Shodan check, has been saved to $OUTPUT_FILE"

# Remember to run this script with the necessary permissions.
# Ensure you have the authorization to perform DNS reconnaissance against the domain in question.
