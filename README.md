# Front-Door-KQL-Logs

Quick guide on which to use:

Start every debug session with "All traffic" → see what's hitting Front Door
Something is broken → "All 4xx/5xx errors" → grab the TrackingRef → run "Trace by tracking reference"
App feels slow → "Slowest requests" + "Avg latency per endpoint"
Users getting 403 → "All WAF blocked requests" → check Rule and Reason columns
Debugging one user → "Trace by client IP"
Query throws a column error → always run "Discover available columns" first
