From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 09/19] ACPICA: Update initialization codes.
Date: Wed, 19 Dec 2012 13:37:41 +0800
Message-ID: <fa1bb6b31021e1aca91c0a8a06e49ff8564f6805.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58931 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab2LSFhs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:37:48 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch decreases 18 lines of 20121018 divergence.diff.

This patch updates initialization codes as they are already been updated in
ACPICA. This can also help to reduce source code differences between Linux
and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Divergences fixing result:
  Before applying: 1982 Lines, 70.5 Kbytes
  After applying: 1964 Lines, 70.0 Kbytes
---
 drivers/acpi/acpica/utglobal.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index c083611..7b4dd21 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -293,11 +293,11 @@ acpi_status acpi_ut_init_globals(void)
 
 	/* GPE support */
 
+	acpi_gbl_all_gpes_initialized = FALSE;
 	acpi_gbl_gpe_xrupt_list_head = NULL;
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
 	acpi_current_gpe_count = 0;
-	acpi_gbl_all_gpes_initialized = FALSE;
 
 	acpi_gbl_global_event_handler = NULL;
 
@@ -367,6 +367,7 @@ acpi_status acpi_ut_init_globals(void)
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 	acpi_gbl_display_final_mem_stats = FALSE;
+	acpi_gbl_disable_mem_tracking = FALSE;
 #endif
 
 	return_ACPI_STATUS(AE_OK);
-- 
1.7.10

