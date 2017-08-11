From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPICA: Events: Dispatch GPEs after enabling for the first time
Date: Fri, 11 Aug 2017 13:57:39 +0800
Message-ID: <bfa3079aa97c45c7e983260b45647839f0831ae2.1502430636.git.lv.zheng@intel.com>
References: <cover.1502430636.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502430636.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

After being enabled for the first time, the GPEs may have STS bits already
set. Setting EN bits is not sufficient to trigger the GPEs again, so this
patch polls GPEs after enabling them for the first time.
This is a simpler version on top of the "GPE clear" fix generated according
to Mika's report and Rafael's original Linux based fix. Based on Linux
commit originated from Rafael J. Wysocki, fixed by Lv Zheng, tested by Mika
Westerberg.

Original-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpica/evxfgpe.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 57718a3..d8be21d 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -97,6 +97,14 @@ acpi_status acpi_update_all_gpes(void)
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 
+	/*
+	 * Poll GPEs to handle already triggered events.
+	 * It is not sufficient to trigger edge-triggered GPE with specific
+	 * GPE chips, software need to poll once after enabling.
+	 */
+	if (acpi_gbl_all_gpes_initialized) {
+		acpi_ev_gpe_detect(acpi_gbl_gpe_xrupt_list_head);
+	}
 	return_ACPI_STATUS(status);
 }
 
@@ -120,6 +128,7 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
+	u8 poll_gpes = FALSE;
 
 	ACPI_FUNCTION_TRACE(acpi_enable_gpe);
 
@@ -135,12 +144,25 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
 		    ACPI_GPE_DISPATCH_NONE) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info);
+			if (ACPI_SUCCESS(status) &&
+			    gpe_event_info->runtime_count == 1) {
+				poll_gpes = TRUE;
+			}
 		} else {
 			status = AE_NO_HANDLER;
 		}
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	/*
+	 * Poll GPEs to handle already triggered events.
+	 * It is not sufficient to trigger edge-triggered GPE with specific
+	 * GPE chips, software need to poll once after enabling.
+	 */
+	if (poll_gpes && acpi_gbl_all_gpes_initialized) {
+		acpi_ev_gpe_detect(acpi_gbl_gpe_xrupt_list_head);
+	}
 	return_ACPI_STATUS(status);
 }
 ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
-- 
2.7.4
