AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorAccessLog"
| where requestUri_s contains "redberry.app.euccz.org"
| where toint(httpStatusCode_s) >= 400
| extend ParsedUrl = parseurl(requestUri_s)
| summarize Errors = count()
    by Path   = tostring(ParsedUrl.Path),
       Status = httpStatusCode_s
| order by Errors desc
| limit 20
