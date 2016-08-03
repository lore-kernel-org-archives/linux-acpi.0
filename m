From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI / EC: Fix a regression by reducing parallel _Qxx evaluations
Date: Wed,  3 Aug 2016 09:00:14 +0800
Message-ID: <b11ce5ce4eecd7a17124a9f2585cdc933bb7f7d1.1470185958.git.lv.zheng@intel.com>
References: <ca8220945184c65f3cd16418de5cfd34bf0b31ab.1469608346.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57275 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756821AbcHCBAc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 21:00:32 -0400
In-Reply-To: <ca8220945184c65f3cd16418de5cfd34bf0b31ab.1469608346.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Wei Yongjun <weiyj.lk@gmail.com>

A regression is caused by the following commit:
  Commit: 02b771b64b73226052d6e731a0987db3b47281e9
  Subject: ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations
In this commit, using system workqueue causes that the maximum parallel
executions of _Qxx can exceed 255. This violates the method reentrancy
limit in ACPICA and generates the following error log:
  ACPI Error: Method reached maximum reentrancy limit (255) (20150818/dsmethod-341)

This patch creates a seperate workqueue and limits the number of parallel
_Qxx evaluations down to a configurable value (can be tuned against number
of online CPUs).

Since EC events are handled after driver probe, we can create the workqueue
in acpi_ec_init().

Fixes: 02b771b64b73 (ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations)
Cc: <stable@vger.kernel.org> # 4.3+
Reported-and-tested-by: Helen Buus <ubuntu@hbuus.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/acpi/ec.c |   41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 999a109..e7bd57c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -101,6 +101,7 @@ enum ec_command {
 #define ACPI_EC_UDELAY_POLL	550	/* Wait 1ms for EC transaction polling */
 #define ACPI_EC_CLEAR_MAX	100	/* Maximum number of events to query
 					 * when trying to clear the EC */
+#define ACPI_EC_MAX_QUERIES	16	/* Maximum number of parallel queries */
 
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
@@ -121,6 +122,10 @@ static unsigned int ec_delay __read_mostly = ACPI_EC_DELAY;
 module_param(ec_delay, uint, 0644);
 MODULE_PARM_DESC(ec_delay, "Timeout(ms) waited until an EC command completes");
 
+static unsigned int ec_max_queries __read_mostly = ACPI_EC_MAX_QUERIES;
+module_param(ec_max_queries, uint, 0644);
+MODULE_PARM_DESC(ec_max_queries, "Maximum parallel _Qxx evaluations");
+
 static bool ec_busy_polling __read_mostly;
 module_param(ec_busy_polling, bool, 0644);
 MODULE_PARM_DESC(ec_busy_polling, "Use busy polling to advance EC transaction");
@@ -174,6 +179,7 @@ static void acpi_ec_event_processor(struct work_struct *work);
 
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
+static struct workqueue_struct *ec_query_wq;
 
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
@@ -1098,7 +1104,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 	 * work queue execution.
 	 */
 	ec_dbg_evt("Query(0x%02x) scheduled", value);
-	if (!schedule_work(&q->work)) {
+	if (!queue_work(ec_query_wq, &q->work)) {
 		ec_dbg_evt("Query(0x%02x) overlapped", value);
 		result = -EBUSY;
 	}
@@ -1660,15 +1666,41 @@ static struct acpi_driver acpi_ec_driver = {
 		},
 };
 
+static inline int acpi_ec_query_init(void)
+{
+	if (!ec_query_wq) {
+		ec_query_wq = alloc_workqueue("kec_query", 0,
+					      ec_max_queries);
+		if (!ec_query_wq)
+			return -ENODEV;
+	}
+	return 0;
+}
+
+static inline void acpi_ec_query_exit(void)
+{
+	if (ec_query_wq) {
+		destroy_workqueue(ec_query_wq);
+		ec_query_wq = NULL;
+	}
+}
+
 int __init acpi_ec_init(void)
 {
-	int result = 0;
+	int result;
 
+	/* register workqueue for _Qxx evaluations */
+	result = acpi_ec_query_init();
+	if (result)
+		goto err_exit;
 	/* Now register the driver for the EC */
 	result = acpi_bus_register_driver(&acpi_ec_driver);
-	if (result < 0)
-		return -ENODEV;
+	if (result)
+		goto err_exit;
 
+err_exit:
+	if (result)
+		acpi_ec_query_exit();
 	return result;
 }
 
@@ -1678,5 +1710,6 @@ static void __exit acpi_ec_exit(void)
 {
 
 	acpi_bus_unregister_driver(&acpi_ec_driver);
+	acpi_ec_query_exit();
 }
 #endif	/* 0 */
-- 
1.7.10

