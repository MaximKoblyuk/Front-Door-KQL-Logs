AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "redberry.app.euccz.org"
| extend ParsedUrl = parseurl(requestUri_s)
| summarize
    Calls  = count(),
    AvgMs  = round(avg(todouble(timeTaken_s)), 1),
    P95Ms  = round(percentile(todouble(timeTaken_s), 95), 1),
    MaxMs  = max(todouble(timeTaken_s))
  by Path = tostring(ParsedUrl.Path)
| order by P95Ms desc
