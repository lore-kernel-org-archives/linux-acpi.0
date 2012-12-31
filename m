From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/27] ACPICA: Update ACPICA initialization messages.
Date: Mon, 31 Dec 2012 08:07:13 +0800
Message-ID: <949c5d829b22e16edc318c0b0a7a75a5fbc8cbcb.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10694 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAHW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:22 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Clarify messages, indent if appropriate. Change a couple
appropriate messages to ACPI_INFO so they will appear even if
debug output is disabled.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evgpeblk.c  |   22 ++++++++++++----------
 drivers/acpi/acpica/evgpeinit.c |    3 +++
 drivers/acpi/acpica/nsinit.c    |    6 +++---
 drivers/acpi/acpica/tbxfload.c  |    2 +-
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 1571a61..78db9f5 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -405,13 +405,13 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 		(*return_gpe_block) = gpe_block;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
-			  "GPE %02X to %02X [%4.4s] %u regs on int 0x%X\n",
-			  (u32) gpe_block->block_base_number,
-			  (u32) (gpe_block->block_base_number +
-				(gpe_block->gpe_count - 1)),
-			  gpe_device->name.ascii, gpe_block->register_count,
-			  interrupt_number));
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
+			      "    Initialized GPE %02X to %02X [%4.4s] %u regs on interrupt 0x%X\n",
+			      (u32)gpe_block->block_base_number,
+			      (u32)(gpe_block->block_base_number +
+				    (gpe_block->gpe_count - 1)),
+			      gpe_device->name.ascii, gpe_block->register_count,
+			      interrupt_number));
 
 	/* Update global count of currently available GPEs */
 
@@ -496,9 +496,11 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	}
 
 	if (gpe_enabled_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INIT,
-				  "Enabled %u GPEs in this block\n",
-				  gpe_enabled_count));
+		ACPI_INFO((AE_INFO,
+			   "Enabled %u GPEs in block %02X to %02X",
+			   gpe_enabled_count, (u32)gpe_block->block_base_number,
+			   (u32)(gpe_block->block_base_number +
+				 (gpe_block->gpe_count - 1))));
 	}
 
 	gpe_block->initialized = TRUE;
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index da0add8..8ac86b0 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -86,6 +86,9 @@ acpi_status acpi_ev_gpe_initialize(void)
 
 	ACPI_FUNCTION_TRACE(ev_gpe_initialize);
 
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
+			      "Initializing General Purpose Events (GPEs):\n"));
+
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 59cd5b4..0f8de6e 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -102,7 +102,7 @@ acpi_status acpi_ns_initialize_objects(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Initialized %u/%u Regions %u/%u Fields %u/%u "
+			      "    Initialized %u/%u Regions %u/%u Fields %u/%u "
 			      "Buffers %u/%u Packages (%u nodes)\n",
 			      info.op_region_init, info.op_region_count,
 			      info.field_init, info.field_count,
@@ -149,7 +149,7 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
 			      "Initializing Device/Processor/Thermal objects "
-			      "and executing _INI methods:\n"));
+			      "and executing _INI/_STA methods:\n"));
 
 	/* Tree analysis: find all subtrees that contain _INI methods */
 
@@ -207,7 +207,7 @@ acpi_status acpi_ns_initialize_devices(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Executed %u _INI methods requiring %u _STA executions "
+			      "    Executed %u _INI methods requiring %u _STA executions "
 			      "(examined %u objects)\n",
 			      info.num_INI, info.num_STA, info.device_count));
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index a5e1e4e..7feaafd 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -192,7 +192,7 @@ static acpi_status acpi_tb_load_namespace(void)
 		(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INIT, "ACPI Tables successfully acquired\n"));
+	ACPI_INFO((AE_INFO, "All ACPI Tables successfully acquired"));
 
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-- 
1.7.10

