From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/6] ACPI/EC: Fix returning values in acpi_ec_sync_query()
Date: Fri, 19 Dec 2014 13:59:49 +0800
Message-ID: <c37b8ff3760cd38e584728d7087fe7892dc38c06.1418966602.git.lv.zheng@intel.com>
References: <cover.1418966602.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31340 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbaLSF77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2014 00:59:59 -0500
In-Reply-To: <cover.1418966602.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The returning value of acpi_os_execute() is erroneously handled as errno.
This patch corrects it by returning EBUSY to indicate the work queue item
creation failure.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 87b9911..a94ee9f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -660,14 +660,15 @@ static void acpi_ec_run(void *cxt)
 static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 {
 	u8 value = 0;
-	int status;
+	int result;
+	acpi_status status;
 	struct acpi_ec_query_handler *handler;
 
-	status = acpi_ec_query_unlocked(ec, &value);
+	result = acpi_ec_query_unlocked(ec, &value);
 	if (data)
 		*data = value;
-	if (status)
-		return status;
+	if (result)
+		return result;
 
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
@@ -675,12 +676,15 @@ static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 			handler = acpi_ec_get_query_handler(handler);
 			pr_debug("##### Query(0x%02x) scheduled #####\n",
 				 handler->query_bit);
-			return acpi_os_execute((handler->func) ?
+			status = acpi_os_execute((handler->func) ?
 				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
 				acpi_ec_run, handler);
+			if (ACPI_FAILURE(status))
+				result = -EBUSY;
+			break;
 		}
 	}
-	return 0;
+	return result;
 }
 
 static void acpi_ec_gpe_query(void *ec_cxt)
-- 
1.7.10

