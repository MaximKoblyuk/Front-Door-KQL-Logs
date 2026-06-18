let ip = "1.2.3.4"; // replace with client IP
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "URL......."
| where clientIp_s == ip
| project TimeGenerated,
    Method  = httpMethod_s,
    URI     = requestUri_s,
    Status  = httpStatusCode_s,
    DurMs   = timeTaken_s,
    Origin  = originName_s,
    Ref     = trackingReference_s
| order by TimeGenerated asc
