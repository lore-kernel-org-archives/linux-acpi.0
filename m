From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/10] ACPICA: Events: Reduce source code difference for the ACPI_EVENT_FLAG_HANDLE support.
Date: Fri, 10 Oct 2014 10:39:57 +0800
Message-ID: <458ce1e4694f90fbacc8f53c8296174cea622db2.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2833 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaJJCkL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:40:11 -0400
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
This commit back ports ACPI_EVENT_FLAG_HANDLE from Linux upstream to the
ACPICA, the flag along with its support code currently can only be found in
the Linux upstream and is used by the ACPI sysfs GPE interfaces and the
ACPI bus scanning support.

When the Linux support of ACPI_EVENT_FLAG_HANDLE is back ported to the
ACPICA, the following things are changed:
1. The coding style is changed to follow ACPICA preference.
2. The ACPI_EVENT_FLAG_HANDLE is returned from acpi_hw_get_gpe_status()
   instead of set it after invoking acpi_hw_get_gpe_status().
3. In acpi_get_event_status(), a local variable local_event_status is
   introduced to make the piece of code similar as acpi_get_gpe_status().
4. The ACPI_EVENT_FLAG_HANDLE is renamed to ACPI_EVENT_FLAG_HAS_HANDLER.
When the ACPICA commit is linuxized to form this Linux divergence reduction
patch, the following things are changed:
1. The ACPI_EVENT_FLAG_HAS_HANDLER is restored back to
   ACPI_EVENT_FLAG_HANDLE, the renaming change is split into another
   patch along with sysfs.c/scan.c updates so that this patch can be a pure
   ACPICA commit and can be less likely to have conflicts with other
   commits.

Link: https://github.com/acpica/acpica/commit/a73b66c6
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |   40 ++++++++++++++++++++++++++--------------
 drivers/acpi/acpica/evxfgpe.c  |    3 ---
 drivers/acpi/acpica/hwgpe.c    |    7 +++++++
 include/acpi/actypes.h         |    4 ++--
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index e286640..a8a077c 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -324,8 +324,9 @@ ACPI_EXPORT_SYMBOL(acpi_clear_event)
  ******************************************************************************/
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 {
-	acpi_status status = AE_OK;
-	u32 value;
+	acpi_status status;
+	acpi_event_status local_event_status = 0;
+	u32 in_byte;
 
 	ACPI_FUNCTION_TRACE(acpi_get_event_status);
 
@@ -339,29 +340,40 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the status of the requested fixed event */
+	/* Fixed event currently can be dispatched? */
+
+	if (acpi_gbl_fixed_event_handlers[event].handler) {
+		local_event_status |= ACPI_EVENT_FLAG_HANDLE;
+	}
+
+	/* Fixed event currently enabled? */
 
 	status =
 	    acpi_read_bit_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, &value);
-	if (ACPI_FAILURE(status))
+				   enable_register_id, &in_byte);
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
+	}
 
-	*event_status = value;
+	if (in_byte) {
+		local_event_status |= ACPI_EVENT_FLAG_ENABLED;
+	}
+
+	/* Fixed event currently active? */
 
 	status =
 	    acpi_read_bit_register(acpi_gbl_fixed_event_info[event].
-			      status_register_id, &value);
-	if (ACPI_FAILURE(status))
+				   status_register_id, &in_byte);
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
+	}
 
-	if (value)
-		*event_status |= ACPI_EVENT_FLAG_SET;
-
-	if (acpi_gbl_fixed_event_handlers[event].handler)
-		*event_status |= ACPI_EVENT_FLAG_HANDLE;
+	if (in_byte) {
+		local_event_status |= ACPI_EVENT_FLAG_SET;
+	}
 
-	return_ACPI_STATUS(status);
+	(*event_status) = local_event_status;
+	return_ACPI_STATUS(AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_event_status)
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 2529d3c..e889a53 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -523,9 +523,6 @@ acpi_get_gpe_status(acpi_handle gpe_device,
 
 	status = acpi_hw_get_gpe_status(gpe_event_info, event_status);
 
-	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
-		*event_status |= ACPI_EVENT_FLAG_HANDLE;
-
 unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index aa884d4..0302bc3 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -216,6 +216,13 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 		return (AE_BAD_PARAMETER);
 	}
 
+	/* GPE currently handled? */
+
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
+	    ACPI_GPE_DISPATCH_NONE) {
+		local_event_status |= ACPI_EVENT_FLAG_HANDLE;
+	}
+
 	/* Get the info block for the entire GPE register */
 
 	gpe_register_info = gpe_event_info->register_info;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ac03ec8..857830d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -721,7 +721,7 @@ typedef u32 acpi_event_type;
  *          |     | | +--- Enabled for wake?
  *          |     | +----- Set?
  *          |     +------- Has a handler?
- *          +----------- <Reserved>
+ *          +------------- <Reserved>
  */
 typedef u32 acpi_event_status;
 
@@ -729,7 +729,7 @@ typedef u32 acpi_event_status;
 #define ACPI_EVENT_FLAG_ENABLED         (acpi_event_status) 0x01
 #define ACPI_EVENT_FLAG_WAKE_ENABLED    (acpi_event_status) 0x02
 #define ACPI_EVENT_FLAG_SET             (acpi_event_status) 0x04
-#define ACPI_EVENT_FLAG_HANDLE		(acpi_event_status) 0x08
+#define ACPI_EVENT_FLAG_HANDLE          (acpi_event_status) 0x08
 
 /* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
-- 
1.7.10

