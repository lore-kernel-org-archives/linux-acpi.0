From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/10] ACPICA: Events: Remove duplicated sanity check in acpi_ev_enable_gpe().
Date: Thu,  5 Feb 2015 15:19:54 +0800
Message-ID: <a313e233a49f4b7c45a03e29aea163ef377baa97.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit ca10324788bc9bdaf47fa9e51145129c1299144d

This patch deletes a sanity check from acpi_ev_enable_gpe().

This kind of check is already done in
acpi_enable_gpe()/acpi_remove_gpe_handler()/acpi_update_all_gpes() before invoking
acpi_ev_enable_gpe():
1. acpi_enable_gpe(): same check (skip if DISPATCH_NONE) is now implemented.
2. acpi_remove_gpe_handler(): a more strict check (skip if !DISPATCH_HANDLER)
                           is implemented.
3. acpi_update_all_gpes(): a more strict check (skip if DISPATCH_NONE ||
                        DISPATCH_HANDLER || CAN_WAKE)
4. acpi_set_gpe(): since it is invoked by the OSPM driver where the GPE
                 handler is known to be available, such check isn't needed.
So we can simply remove this duplicated check from acpi_ev_enable_gpe().
Lv Zheng.

Link: https://github.com/acpica/acpica/commit/ca103247
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evgpe.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index aa70154..b2e63e7 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -114,17 +114,6 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
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
 	/* Clear the GPE (of stale events) */
 
 	status = acpi_hw_clear_gpe(gpe_event_info);
-- 
1.7.10
