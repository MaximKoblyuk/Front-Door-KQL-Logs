AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorWebApplicationFirewallLog"
| summarize Count = count() by Rule = ruleName_s, Action = action_s
| order by Count desc
