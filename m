From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/6] ACPICA: Comment update
Date: Wed, 17 Jul 2013 09:48:15 +0800
Message-ID: <810b7ea4bac50621297829f685ed2b0f645129bd.1374025121.git.lv.zheng@intel.com>
References: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42171 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab3GQBs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:48:27 -0400
In-Reply-To: <cover.1374025121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

No functional change.  Add some comments concerning behavior
when the _STA method does not exist. According to the ACPI
specification, in this case the device should be assumed to be
present, functional, and enabled.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsxfname.c |    7 ++++++-
 drivers/acpi/acpica/uteval.c   |    8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index f3a4d95..21a2ef3 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -379,9 +379,14 @@ acpi_get_object_info(acpi_handle handle,
 		 * Get extra info for ACPI Device/Processor objects only:
 		 * Run the _STA, _ADR and, sx_w, and _sx_d methods.
 		 *
-		 * Note: none of these methods are required, so they may or may
+		 * Notes: none of these methods are required, so they may or may
 		 * not be present for this device. The Info->Valid bitfield is used
 		 * to indicate which methods were found and run successfully.
+		 *
+		 * For _STA, if the method does not exist, then (as per the ACPI
+		 * specification), the returned current_status flags will indicate
+		 * that the device is present/functional/enabled. Otherwise, the
+		 * current_status flags reflect the value returned from _STA.
 		 */
 
 		/* Execute the Device._STA method */
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index ee83adb..4fd6897 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -239,7 +239,8 @@ acpi_ut_evaluate_numeric_object(char *object_name,
  * RETURN:      Status
  *
  * DESCRIPTION: Executes _STA for selected device and stores results in
- *              *Flags.
+ *              *Flags. If _STA does not exist, then the device is assumed
+ *              to be present/functional/enabled (as per the ACPI spec).
  *
  *              NOTE: Internal function, no parameter validation
  *
@@ -257,6 +258,11 @@ acpi_ut_execute_STA(struct acpi_namespace_node *device_node, u32 * flags)
 					 ACPI_BTYPE_INTEGER, &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		if (AE_NOT_FOUND == status) {
+			/*
+			 * if _STA does not exist, then (as per the ACPI specification),
+			 * the returned flags will indicate that the device is present,
+			 * functional, and enabled.
+			 */
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 					  "_STA on %4.4s was not found, assuming device is present\n",
 					  acpi_ut_get_node_name(device_node)));
-- 
1.7.10

