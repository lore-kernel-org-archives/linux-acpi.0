From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/27] ACPICA: Utilities: Cleanup obsoleted global variables.
Date: Wed, 30 Apr 2014 10:03:33 +0800
Message-ID: <4035eaafd075f309cb2ca54ff0e68731be38ac7d.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37681 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbaD3CDl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2014 22:03:41 -0400
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch deletes global variable declarations that are no longer used by
ACPICA.  No functional changes.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 1f60290..e7d73eb 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -279,7 +279,6 @@ ACPI_GLOBAL(acpi_exception_handler, acpi_gbl_exception_handler);
 ACPI_GLOBAL(acpi_init_handler, acpi_gbl_init_handler);
 ACPI_GLOBAL(acpi_table_handler, acpi_gbl_table_handler);
 ACPI_GLOBAL(void *, acpi_gbl_table_handler_context);
-ACPI_GLOBAL(struct acpi_walk_state *, acpi_gbl_breakpoint_walk);
 ACPI_GLOBAL(acpi_interface_handler, acpi_gbl_interface_handler);
 ACPI_GLOBAL(struct acpi_sci_handler_info *, acpi_gbl_sci_handler_list);
 
@@ -296,7 +295,6 @@ ACPI_GLOBAL(u8, acpi_gbl_reg_methods_executed);
 /* Misc */
 
 ACPI_GLOBAL(u32, acpi_gbl_original_mode);
-ACPI_GLOBAL(u32, acpi_gbl_rsdp_original_location);
 ACPI_GLOBAL(u32, acpi_gbl_ns_lookup_count);
 ACPI_GLOBAL(u32, acpi_gbl_ps_find_count);
 ACPI_GLOBAL(u16, acpi_gbl_pm1_enable_register_save);
@@ -483,11 +481,6 @@ ACPI_GLOBAL(u16, acpi_gbl_node_type_count_misc);
 ACPI_GLOBAL(u32, acpi_gbl_num_nodes);
 ACPI_GLOBAL(u32, acpi_gbl_num_objects);
 
-ACPI_GLOBAL(u32, acpi_gbl_size_of_parse_tree);
-ACPI_GLOBAL(u32, acpi_gbl_size_of_method_trees);
-ACPI_GLOBAL(u32, acpi_gbl_size_of_node_entries);
-ACPI_GLOBAL(u32, acpi_gbl_size_of_acpi_objects);
-
 #endif				/* ACPI_DEBUGGER */
 
 /*****************************************************************************
-- 
1.7.10

