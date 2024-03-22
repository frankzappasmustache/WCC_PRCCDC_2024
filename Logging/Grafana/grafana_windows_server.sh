# Download Grafana
Invoke-WebRequest -Uri "https://dl.grafana.com/oss/release/grafana-8.0.6.windows-amd64.zip" -OutFile "grafana.zip"

# Extract Grafana
Expand-Archive -Path "grafana.zip" -DestinationPath "C:\Program Files\Grafana"

# Set Grafana home path environment variable
[Environment]::SetEnvironmentVariable("GRAFANA_HOME", "C:\Program Files\Grafana", "Machine")

# Start Grafana service
& "C:\Program Files\Grafana\bin\grafana-server.exe" web

# Open Grafana in default web browser
Start-Process "http://localhost:3000"
