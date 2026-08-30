# Cost controls

Creates a monthly AWS account budget with notifications at 50%, 80% and 100%.
The 50% alert uses forecasted spend, while the higher thresholds use actual spend.

AWS Budgets alerts are warnings, not automatic service shutdowns. The operator
must investigate the alert and run the documented teardown procedure when needed.