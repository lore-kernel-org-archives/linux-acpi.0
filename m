From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0045/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:47 +0800
Message-ID: <20160802103647.16769-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51941 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656AbcHBLPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/ec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 73c76d6..15b0964 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -118,15 +118,15 @@ enum {
 
 /* ec.c is compiled in acpi namespace so this shows up as acpi.ec_delay param */
 static unsigned int ec_delay __read_mostly = ACPI_EC_DELAY;
-module_param(ec_delay, uint, 0644);
+module_param(ec_delay, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ec_delay, "Timeout(ms) waited until an EC command completes");
 
 static bool ec_busy_polling __read_mostly;
-module_param(ec_busy_polling, bool, 0644);
+module_param(ec_busy_polling, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ec_busy_polling, "Use busy polling to advance EC transaction");
 
 static unsigned int ec_polling_guard __read_mostly = ACPI_EC_UDELAY_POLL;
-module_param(ec_polling_guard, uint, 0644);
+module_param(ec_polling_guard, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ec_polling_guard, "Guard time(us) between EC accesses in polling modes");
 
 static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_QUERY;
@@ -137,7 +137,7 @@ static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_QUERY;
  * will disable the GPE for normal transaction.
  */
 static unsigned int ec_storm_threshold  __read_mostly = 8;
-module_param(ec_storm_threshold, uint, 0644);
+module_param(ec_storm_threshold, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
 
 struct acpi_ec_query_handler {
@@ -1636,7 +1636,7 @@ static int param_get_event_clearing(char *buffer, struct kernel_param *kp)
 }
 
 module_param_call(ec_event_clearing, param_set_event_clearing, param_get_event_clearing,
-		  NULL, 0644);
+		  NULL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ec_event_clearing, "Assumed SCI_EVT clearing timing");
 
 static struct acpi_driver acpi_ec_driver = {
-- 
2.9.2

