AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorWebApplicationFirewallLog"
| where requestUri_s contains "redberry.app.euccz.org"
| summarize Count = count() by Rule = ruleName_s, Action = action_s
| order by Count desc
