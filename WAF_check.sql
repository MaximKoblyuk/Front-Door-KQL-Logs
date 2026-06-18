AzureDiagnostics
| where ResourceProvider == "MICROSOFT.CDN"
    and Category == "FrontDoorWebApplicationFirewallLog"
| where action_s == "Block"
| project TimeGenerated,
    ClientIP   = clientIP_s,
    URI        = requestUri_s,
    Rule       = ruleName_s,
    Reason     = details_msg_s,
    Data       = details_data_s,
    PolicyMode = policyMode_s,
    Ref        = trackingReference_s
| order by TimeGenerated desc
