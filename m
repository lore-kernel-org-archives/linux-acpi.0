From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 4/6] ACPI/EC: Fix a code path that global lock is not held
Date: Fri, 19 Dec 2014 13:59:55 +0800
Message-ID: <60bd5b5b53ea2de2a6738c17cfe377e474fff48e.1418966602.git.lv.zheng@intel.com>
References: <cover.1418966602.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27965 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbaLSGAF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2014 01:00:05 -0500
In-Reply-To: <cover.1418966602.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Currently QR_EC is queued up on CPU 0 to be safe with SMM because there is
no global lock held for acpi_ec_gpe_query(). As we are about to move QR_EC
to a non CPU 0 bound work queue to avoid invoking kmalloc() in
advance_transaction(), we have to acquire global lock for the new QR_EC
work item to avoid regressions.

Known issue:
1. Global lock for acpi_ec_clear().
   This is an existing issue that acpi_ec_clear() which invokes
   acpi_ec_sync_query() also suffers from the same issue. But this patch's
   target is only the code to invoke acpi_ec_sync_query() in a CPU 0 bound
   work queue item, and the acpi_ec_clear() can be automatically fixed by
   further patch that merges the redundant code, so it is left unchanged.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a94ee9f..3c97122 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -690,11 +690,21 @@ static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 static void acpi_ec_gpe_query(void *ec_cxt)
 {
 	struct acpi_ec *ec = ec_cxt;
+	acpi_status status;
+	u32 glk;
 
 	if (!ec)
 		return;
 	mutex_lock(&ec->mutex);
+	if (ec->global_lock) {
+		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
+		if (ACPI_FAILURE(status))
+			goto unlock;
+	}
 	acpi_ec_sync_query(ec, NULL);
+	if (ec->global_lock)
+		acpi_release_global_lock(glk);
+unlock:
 	mutex_unlock(&ec->mutex);
 }
 
-- 
1.7.10

