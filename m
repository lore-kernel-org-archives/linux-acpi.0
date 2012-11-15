From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / PM: Add check preventing transitioning to non-D0 state from D3.
Date: Thu, 15 Nov 2012 12:25:01 +0800
Message-ID: <e4ec829902580af84cddbba6e98ef54b33052b85.1352953283.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27244 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933326Ab2KOEZJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2012 23:25:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

No power transitioning from D3 state to a non-D0 state is allowed.
This patch also cleans up device power updating code in the
acpi_device_set_power() as it should already been updated in the
acpi_power_transition().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/bus.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07a20ee..12c1b51 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -293,6 +293,12 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 			      " state than parent\n");
 		return -ENODEV;
 	}
+	if (device->parent->power.state >= ACPI_STATE_D3_HOT &&
+	    state != ACPI_STATE_D0) {
+		printk(KERN_WARNING PREFIX
+			      "Cannot transition to non-D0 state from D3\n");
+		return -ENODEV;
+	}
 
 	/* For D3cold we should execute _PS3, not _PS4. */
 	if (state == ACPI_STATE_D3_COLD)
@@ -341,7 +347,6 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 			      "Device [%s] failed to transition to %s\n",
 			      device->pnp.bus_id, state_string(state));
 	else {
-		device->power.state = state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device [%s] transitioned to %s\n",
 				  device->pnp.bus_id, state_string(state)));
-- 
1.7.10

