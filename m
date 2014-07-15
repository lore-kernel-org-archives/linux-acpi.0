From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 6/9] ACPICA: Events: Fix an issue that status of GPEs are unexpectedly cleared.
Date: Tue, 15 Jul 2014 11:07:50 +0800
Message-ID: <879158e9aa39144c118003f469d1fda29e5126b4.1405306438.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1405306438.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37020 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757751AbaGODHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 23:07:55 -0400
In-Reply-To: <cover.1405306438.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The stale GPE indication is not a problem. Drivers should always check the
underlying hardware status and be ready to handle invalid status.

The GPE clearing implemented in acpi_ev_enable_gpe() on the contrary
introduces issues for acpi_enable_gpe() logic. When the usage count of GPE is
increased by suspend/resume code, GPE status shouldn't be cleared, or a GPE
loss could happen when the driver relies on the interrupt mode.

With previous cleanup, all acpi_ev_enable_gpe() usages are removed, this patch
also removes this internal API. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evgpe.c |   46 +++----------------------------------------
 1 file changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index d629a21..64f6d41 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -98,48 +98,6 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_enable_gpe
- *
- * PARAMETERS:  gpe_event_info          - GPE to enable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Clear a GPE of stale events and enable it.
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_enable_gpe);
-
-	/*
-	 * We will only allow a GPE to be enabled if it has either an associated
-	 * method (_Lxx/_Exx) or a handler, or is using the implicit notify
-	 * feature. Otherwise, the GPE will be immediately disabled by
-	 * acpi_ev_gpe_dispatch the first time it fires.
-	 */
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
-	    ACPI_GPE_DISPATCH_NONE) {
-		return_ACPI_STATUS(AE_NO_HANDLER);
-	}
-
-	/* Clear the GPE (of stale events) */
-
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Enable the requested GPE */
-
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ev_add_gpe_reference
  *
  * PARAMETERS:  gpe_event_info          - Add a reference to this GPE
@@ -169,7 +127,9 @@ acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
 
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
-			status = acpi_ev_enable_gpe(gpe_event_info);
+			status =
+			    acpi_hw_low_set_gpe(gpe_event_info,
+						ACPI_GPE_ENABLE);
 		}
 
 		if (ACPI_FAILURE(status)) {
-- 
1.7.10

