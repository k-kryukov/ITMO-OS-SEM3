man bash | grep -Eoh "[a-z,A-Z,0-9]{4,}" | sort | uniq -dic | sort -nr | head -3
