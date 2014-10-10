From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/10] ACPICA: Events: Reduce source code difference for the ACPI_EVENT_FLAG_HANDLE renaming.
Date: Fri, 10 Oct 2014 10:40:05 +0800
Message-ID: <eaac611d379e88eb87368d0c5207baf0c32012dc.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54247 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaJJCkT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:40:19 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch is a partial linuxized result of the following ACPICA commit:
  ACPICA commit: a73b66c6aa1846d055bb6390d9c9b9902f7d804d
  Subject: Add "has handler" flag to event/gpe status interfaces.
  This change adds a new flag, ACPI_EVENT_FLAGS_HAS_HANDLER to the
  acpi_get_event_status and acpi_get_gpe_status external interfaces. It
  is set if the event/gpe currently has a handler associated with it.
This patch contains the code to rename ACPI_EVENT_FLAG_HANDLE to
ACPI_EVENT_FLAG_HAS_HANDLER, and the corresponding updates of its usages.

Link: https://github.com/acpica/acpica/commit/a73b66c6
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |    2 +-
 drivers/acpi/acpica/hwgpe.c    |    2 +-
 drivers/acpi/scan.c            |    2 +-
 drivers/acpi/sysfs.c           |    4 ++--
 include/acpi/actypes.h         |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index a8a077c..bb8cbf5 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -343,7 +343,7 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 	/* Fixed event currently can be dispatched? */
 
 	if (acpi_gbl_fixed_event_handlers[event].handler) {
-		local_event_status |= ACPI_EVENT_FLAG_HANDLE;
+		local_event_status |= ACPI_EVENT_FLAG_HAS_HANDLER;
 	}
 
 	/* Fixed event currently enabled? */
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 0302bc3..48ac7b7 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -220,7 +220,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
 	    ACPI_GPE_DISPATCH_NONE) {
-		local_event_status |= ACPI_EVENT_FLAG_HANDLE;
+		local_event_status |= ACPI_EVENT_FLAG_HAS_HANDLER;
 	}
 
 	/* Get the info block for the entire GPE register */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ae44d86..f1d96e7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1470,7 +1470,7 @@ static void acpi_wakeup_gpe_init(struct acpi_device *device)
 	if (ACPI_FAILURE(status))
 		return;
 
-	wakeup->flags.run_wake = !!(event_status & ACPI_EVENT_FLAG_HANDLE);
+	wakeup->flags.run_wake = !!(event_status & ACPI_EVENT_FLAG_HAS_HANDLER);
 }
 
 static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 38cb978..13e577c 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -537,7 +537,7 @@ static ssize_t counter_show(struct kobject *kobj,
 	if (result)
 		goto end;
 
-	if (!(status & ACPI_EVENT_FLAG_HANDLE))
+	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
 		size += sprintf(buf + size, "   invalid");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
 		size += sprintf(buf + size, "   enabled");
@@ -581,7 +581,7 @@ static ssize_t counter_set(struct kobject *kobj,
 	if (result)
 		goto end;
 
-	if (!(status & ACPI_EVENT_FLAG_HANDLE)) {
+	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER)) {
 		printk(KERN_WARNING PREFIX
 		       "Can not change Invalid GPE/Fixed Event status\n");
 		return -EINVAL;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 857830d..7000e66 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -729,7 +729,7 @@ typedef u32 acpi_event_status;
 #define ACPI_EVENT_FLAG_ENABLED         (acpi_event_status) 0x01
 #define ACPI_EVENT_FLAG_WAKE_ENABLED    (acpi_event_status) 0x02
 #define ACPI_EVENT_FLAG_SET             (acpi_event_status) 0x04
-#define ACPI_EVENT_FLAG_HANDLE          (acpi_event_status) 0x08
+#define ACPI_EVENT_FLAG_HAS_HANDLER     (acpi_event_status) 0x08
 
 /* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
-- 
1.7.10

