AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "redberry.app.euccz.org"
| where toint(httpStatusCode_s) >= 400
| extend Environment = case(
    requestUri_s contains "uat.",  "UAT",
    requestUri_s contains "test.", "TEST",
    "PROD")
| extend Meaning = case(
    httpStatusCode_s == "400", "Bad request",
    httpStatusCode_s == "401", "Unauthorized",
    httpStatusCode_s == "403", "Forbidden / WAF block",
    httpStatusCode_s == "404", "Not found",
    httpStatusCode_s == "429", "Rate limited",
    httpStatusCode_s == "500", "App crash",
    httpStatusCode_s == "502", "Origin unreachable",
    httpStatusCode_s == "503", "Service unavailable",
    httpStatusCode_s == "504", "Gateway timeout",
    "Other")
| project TimeGenerated, Environment, Meaning,
    Method  = httpMethod_s,
    URI     = requestUri_s,
    Status  = httpStatusCode_s,
    DurMs   = timeTaken_s,
    ClientIP = clientIp_s,
    Origin   = originName_s,
    Ref      = trackingReference_s
| order by TimeGenerated desc
