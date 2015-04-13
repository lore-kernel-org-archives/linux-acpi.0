From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/31] ACPICA: Events: Add support to return both enable/status register values for GPE and fixed event.
Date: Mon, 13 Apr 2015 11:49:13 +0800
Message-ID: <314a606d644a9df232d55cd82bc4c2ca4e786d95.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59834 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbbDMDtQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:49:16 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit e25d791e4b3d5b9f4ead298269610cb05f89749a

There is a facility in Linux, developers can obtain GPE and fixed event
status via /sys/firmware/interrupts/. This is implemented using
acpi_get_event_status() and acpi_get_gpe_status(). Recently while debugging some
GPE race issues, it is found that the facility is lacking in the ability to
obtain real hardware register values, the confusing information makes
debugging difficult.

This patch modifies acpi_get_gpe_status() to return EN register values to fix
this gap. Then flags returned from acpi_get_event_status() and
acpi_get_gpe_status() are also cleaned up to reflect this change.

The old ACPI_EVENT_FLAG_SET is carefully kept to avoid regressions. It can
be deleted after we can make sure all its references are removed from OSPM
code. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/e25d791e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |    5 +++--
 drivers/acpi/acpica/hwgpe.c    |   13 ++++++++++++-
 include/acpi/actypes.h         |   25 ++++++++++++++-----------
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index df06a23..faad911 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -356,7 +356,8 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 	}
 
 	if (in_byte) {
-		local_event_status |= ACPI_EVENT_FLAG_ENABLED;
+		local_event_status |=
+		    (ACPI_EVENT_FLAG_ENABLED | ACPI_EVENT_FLAG_ENABLE_SET);
 	}
 
 	/* Fixed event currently active? */
@@ -369,7 +370,7 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 	}
 
 	if (in_byte) {
-		local_event_status |= ACPI_EVENT_FLAG_SET;
+		local_event_status |= ACPI_EVENT_FLAG_STATUS_SET;
 	}
 
 	(*event_status) = local_event_status;
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 84bc550..d7be3cb 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -250,6 +250,17 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 		local_event_status |= ACPI_EVENT_FLAG_WAKE_ENABLED;
 	}
 
+	/* GPE currently enabled (enable bit == 1)? */
+
+	status = acpi_hw_read(&in_byte, &gpe_register_info->enable_address);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	if (register_bit & in_byte) {
+		local_event_status |= ACPI_EVENT_FLAG_ENABLE_SET;
+	}
+
 	/* GPE currently active (status bit == 1)? */
 
 	status = acpi_hw_read(&in_byte, &gpe_register_info->status_address);
@@ -258,7 +269,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 	}
 
 	if (register_bit & in_byte) {
-		local_event_status |= ACPI_EVENT_FLAG_SET;
+		local_event_status |= ACPI_EVENT_FLAG_STATUS_SET;
 	}
 
 	/* Set return value */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 658c42e..f18b7a8 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -733,23 +733,26 @@ typedef u32 acpi_event_type;
  * The encoding of acpi_event_status is illustrated below.
  * Note that a set bit (1) indicates the property is TRUE
  * (e.g. if bit 0 is set then the event is enabled).
- * +-------------+-+-+-+-+
- * |   Bits 31:4 |3|2|1|0|
- * +-------------+-+-+-+-+
- *          |     | | | |
- *          |     | | | +- Enabled?
- *          |     | | +--- Enabled for wake?
- *          |     | +----- Set?
- *          |     +------- Has a handler?
- *          +------------- <Reserved>
+ * +-------------+-+-+-+-+-+
+ * |   Bits 31:5 |4|3|2|1|0|
+ * +-------------+-+-+-+-+-+
+ *          |     | | | | |
+ *          |     | | | | +- Enabled?
+ *          |     | | | +--- Enabled for wake?
+ *          |     | | +----- Status bit set?
+ *          |     | +------- Enable bit set?
+ *          |     +--------- Has a handler?
+ *          +--------------- <Reserved>
  */
 typedef u32 acpi_event_status;
 
 #define ACPI_EVENT_FLAG_DISABLED        (acpi_event_status) 0x00
 #define ACPI_EVENT_FLAG_ENABLED         (acpi_event_status) 0x01
 #define ACPI_EVENT_FLAG_WAKE_ENABLED    (acpi_event_status) 0x02
-#define ACPI_EVENT_FLAG_SET             (acpi_event_status) 0x04
-#define ACPI_EVENT_FLAG_HAS_HANDLER     (acpi_event_status) 0x08
+#define ACPI_EVENT_FLAG_STATUS_SET      (acpi_event_status) 0x04
+#define ACPI_EVENT_FLAG_ENABLE_SET      (acpi_event_status) 0x08
+#define ACPI_EVENT_FLAG_HAS_HANDLER     (acpi_event_status) 0x10
+#define ACPI_EVENT_FLAG_SET             ACPI_EVENT_FLAG_STATUS_SET
 
 /* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
-- 
1.7.10

