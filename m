From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] ACPICA: Introduce acpi_mark_gpe_for_wake()
Date: Mon, 14 Jul 2014 22:40:11 +0200
Message-ID: <2373468.3XZjTiDJHZ@vostro.rjw.lan>
References: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55790 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756540AbaGNUXe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 16:23:34 -0400
In-Reply-To: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Lan Tianyu <tianyu.lan@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some callers of acpi_setup_gpe_for_wake() know in advance that there
won't be any notify handlers installed for device wake notifications
from the given GPEs (one example is button GPEs in Linux).  For those
cases, introduce acpi_mark_gpe_for_wake() to be called instead of
acpi_setup_gpe_for_wake() that will only set the ACPI_GPE_CAN_WAKE
flag for the GPE without trying to set up implicit wake notification
for it if there's no handler method.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |   32 ++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |    5 +++++
 2 files changed, 37 insertions(+)

Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -314,6 +314,38 @@ ACPI_EXPORT_SYMBOL(acpi_setup_gpe_for_wa
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_mark_gpe_for_wake
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Mark a GPE as having the ability to wake the system.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_mark_gpe_for_wake(acpi_handle gpe_device, u32 gpe_number)
+{
+	acpi_status status = AE_BAD_PARAMETER;
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (gpe_event_info) {
+		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+		status = AE_OK;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_mark_gpe_for_wake)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_set_gpe_wake_mask
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -662,6 +662,11 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 							parent_device,
 							acpi_handle gpe_device,
 							u32 gpe_number))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_mark_gpe_for_wake(acpi_handle gpe_device,
+							u32 gpe_number))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_set_gpe_wake_mask(acpi_handle gpe_device,
 							u32 gpe_number,

