From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH] ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations.
Date: Thu, 11 Jun 2015 13:43:23 +0800
Message-ID: <d2029b78c1e914d0c05b28c406a88057858b8a42.1434001323.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24104 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbbFKFn5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2015 01:43:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is proven that Windows evaluates _Qxx handlers in a parallel way. This
patch follows this fact, changes _Qxx evaluations to be queued up on the
NOTIFY queue as its behavior is proven to be quite different from the
_Lxx/_Exx handlers, and convert the NOTIFY queue into the parallel style.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c  |    5 ++---
 drivers/acpi/osl.c |   20 ++++++++++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9d4761d..30f582f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1023,9 +1023,8 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 			handler = acpi_ec_get_query_handler(handler);
 			ec_dbg_evt("Query(0x%02x) scheduled",
 				   handler->query_bit);
-			status = acpi_os_execute((handler->func) ?
-				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
-				acpi_ec_run, handler);
+			status = acpi_os_execute(OSL_NOTIFY_HANDLER,
+						 acpi_ec_run, handler);
 			if (ACPI_FAILURE(status))
 				result = -EBUSY;
 			break;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index db14a66..c354754 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1159,20 +1159,20 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		ret = queue_work(queue, &dpc->work);
 	} else {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		/*
+		 * On some machines, a software-initiated SMI causes
+		 * corruption unless the SMI runs on CPU 0.  An SMI can be
+		 * initiated by any AML, but typically it's done in
+		 * GPE-related methods that are run via workqueues, so we
+		 * can avoid the known corruption cases by always queueing
+		 * on CPU 0.
+		 */
+		ret = queue_work_on(0, queue, &dpc->work);
 	}
-
-	/*
-	 * On some machines, a software-initiated SMI causes corruption unless
-	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
-	 * typically it's done in GPE-related methods that are run via
-	 * workqueues, so we can avoid the known corruption cases by always
-	 * queueing on CPU 0.
-	 */
-	ret = queue_work_on(0, queue, &dpc->work);
-
 	if (!ret) {
 		printk(KERN_ERR PREFIX
 			  "Call to queue_work() failed.\n");
-- 
1.7.10

