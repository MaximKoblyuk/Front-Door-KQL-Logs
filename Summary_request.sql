AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "redberry.app.euccz.org"
| extend Environment = case(
    requestUri_s contains "uat.",  "UAT",
    requestUri_s contains "test.", "TEST",
    "PROD")
| summarize
    Total     = count(),
    Err4xx    = countif(toint(httpStatusCode_s) between (400..499)),
    Err5xx    = countif(toint(httpStatusCode_s) between (500..599)),
    AvgMs     = round(avg(todouble(timeTaken_s)), 1),
    MaxMs     = max(todouble(timeTaken_s))
  by Environment
