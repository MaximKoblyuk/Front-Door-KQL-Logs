let ref = "PASTE-X-Azure-Ref-VALUE-HERE";
AzureDiagnostics
| where trackingReference_s == ref
    or trackingReference_s contains ref
| project TimeGenerated, Category,
    URI      = requestUri_s,
    Status   = httpStatusCode_s,
    DurMs    = timeTaken_s,
    Rule     = column_ifexists("ruleName_s", ""),
    Reason   = column_ifexists("details_msg_s", ""),
    Action   = column_ifexists("action_s", ""),
    Origin   = column_ifexists("originName_s", ""),
    ClientIP = column_ifexists("clientIp_s", "")
| order by TimeGenerated asc
