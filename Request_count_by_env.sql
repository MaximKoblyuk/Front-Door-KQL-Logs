AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| extend Environment = case(
    requestUri_s contains "uat.",  "UAT",
    requestUri_s contains "test.", "TEST",
    "PROD")
| summarize Requests = count()
    by bin(TimeGenerated, 1h), Environment
| render timechart
