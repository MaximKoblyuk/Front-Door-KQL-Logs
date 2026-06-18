AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "redberry.app.euccz.org"
| extend Environment = case(
    requestUri_s contains "uat.",  "UAT",
    requestUri_s contains "test.", "TEST",
    "PROD")
| project TimeGenerated, Environment,
    Method       = httpMethod_s,
    URI          = requestUri_s,
    Status       = httpStatusCode_s,
    DurationMs   = timeTaken_s,
    RespBytes    = responseBytes_s,
    ClientIP     = clientIp_s,
    Origin       = originName_s,
    TrackingRef  = trackingReference_s
| order by TimeGenerated desc
