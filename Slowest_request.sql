AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "redberry.app.euccz.org"
| where todouble(timeTaken_s) > 2000
| extend Environment = case(
    requestUri_s contains "uat.",  "UAT",
    requestUri_s contains "test.", "TEST",
    "PROD")
| project TimeGenerated, Environment,
    Method   = httpMethod_s,
    URI      = requestUri_s,
    Status   = httpStatusCode_s,
    DurMs    = timeTaken_s,
    RespKB   = round(todouble(responseBytes_s)/1024, 1),
    Origin   = originName_s,
    Ref      = trackingReference_s
| order by DurMs desc
