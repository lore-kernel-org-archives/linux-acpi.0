From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v2 6/7] ACPICA: Events: Fix edge-triggered GPE by disabling before acknowledging it.
Date: Sun, 15 Jun 2014 08:42:31 +0800
Message-ID: <64e7447735a1ddb0fa9d5f86e92f8bb049448da8.1402792240.git.lv.zheng@intel.com>
References: <cover.1402543079.git.lv.zheng@intel.com> <cover.1402792240.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1402792240.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Lv Zheng <lv.zheng@intel.com>

Due to ACPI specificiation 5, chapter 5.6.4 General-Purpose Event Hnadling,
OSPMs need to disable GPE before clearing the status bit for edge-triggered
GPEs.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Gareth Williams <gareth@garethwilliams.me.uk>
Tested-by: Steffen Weber <steffen.weber@gmail.com>
---
 drivers/acpi/acpica/evgpe.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 48f7001..e4ba4de 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -698,21 +698,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 	}
 
 	/*
-	 * If edge-triggered, clear the GPE status bit now. Note that
-	 * level-triggered events are cleared after the GPE is serviced.
-	 */
-	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
-	    ACPI_GPE_EDGE_TRIGGERED) {
-		status = acpi_hw_clear_gpe(gpe_event_info);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to clear GPE %02X",
-					gpe_number));
-			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
-		}
-	}
-
-	/*
 	 * Always disable the GPE so that it does not keep firing before
 	 * any asynchronous activity completes (either from the execution
 	 * of a GPE method or an asynchronous GPE handler.)
@@ -729,6 +714,23 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 	}
 
 	/*
+	 * If edge-triggered, clear the GPE status bit now. Note that
+	 * level-triggered events are cleared after the GPE is serviced.
+	 */
+	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
+	    ACPI_GPE_EDGE_TRIGGERED) {
+		status = acpi_hw_clear_gpe(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Unable to clear GPE %02X",
+					gpe_number));
+			(void)acpi_hw_low_set_gpe(gpe_event_info,
+						  ACPI_GPE_CONDITIONAL_ENABLE);
+			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
+		}
+	}
+
+	/*
 	 * Dispatch the GPE to either an installed handler or the control
 	 * method associated with this GPE (_Lxx or _Exx). If a handler
 	 * exists, we invoke it and do not attempt to run the method.
-- 
1.7.10
