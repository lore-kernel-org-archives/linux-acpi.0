From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Tables: Remove a hidden logic related to acpi_tb_install_standard_table()
Date: Thu, 19 Jan 2017 15:21:34 +0800
Message-ID: <49ac3d4571a728ae5348a6b2e93da3d45f76cd38.1484810262.git.lv.zheng@intel.com>
References: <2435796.hnfxsDQFWV@fractal.fi.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:41627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdASHVj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Jan 2017 02:21:39 -0500
In-Reply-To: <2435796.hnfxsDQFWV@fractal.fi.intel.com>
In-Reply-To: <20170112015256.GB19308@yexl-desktop>
References: <20170112015256.GB19308@yexl-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Tomi Sarvela <tomi.p.sarvela@intel.com>, Ye Xiaolong <xiaolong.ye@intel.com>

There is a hidden logic for acpi_tb_install_standard_table() as it can be
invoked from boot stage and during runtime.
1. When it is invoked from the OS boot stage, ACPICA mutex may not be
   available, and thus no acpi_ut_acquire_mutex()/acpi_ut_release_mutex() are
   invoked in these code paths:
   acpi_initialize_tables
     acpi_tb_parse_root_table
       acpi_tb_install_standard_table (4 invocations)
   acpi_install_table
       acpi_tb_install_standard_table
2. When it is invoked during the runtime, ACPICA mutex is correctly used:
   acpi_ex_load_op
     acpi_tb_install_and_load_table
       acpi_tb_install_standard_table
   acpi_load_table
     acpi_tb_install_and_load_table
       acpi_tb_install_standard_table
So the mutex is now used in acpi_tb_install_and_load_table(), while it actually
should be in acpi_tb_install_standard_table().

This introduces another problem in acpi_tb_install_standard_table() where
acpi_gbl_table_handler is invoked from and the lock contexts are thus not
consistent for the table handlers. This triggers a regression when
acpi_get_table()/acpi_put_table() start to hold table mutex during runtime.

The regression is noticed by LKP as new errors reported by ACPICA mutex
debugging facility.
[    2.043693] ACPI Error: Mutex [ACPI_MTX_Tables] already acquired by this thread [497483776] (20160930/utmutex-254)
[    2.054084] ACPI Error: Mutex [0x2] is not acquired, cannot release (20160930/utmutex-326)

And it triggers a dead lock:
[  247.066214] INFO: task swapper/0:1 blocked for more than 120 seconds.
...
[  247.091271] Call Trace:
...
[  247.121523]  down_timeout+0x47/0x50
[  247.125065]  acpi_os_wait_semaphore+0x47/0x62
[  247.129475]  acpi_ut_acquire_mutex+0x43/0x81
[  247.133798]  acpi_get_table+0x2d/0x84
[  247.137513]  acpi_table_attr_init+0xcd/0x100
[  247.146590]  acpi_sysfs_table_handler+0x5d/0xb8
[  247.151174]  acpi_bus_table_handler+0x23/0x2a
[  247.155583]  acpi_tb_install_standard_table+0xe0/0x213
[  247.164489]  acpi_tb_install_and_load_table+0x3a/0x82
[  247.169592]  acpi_ex_load_op+0x194/0x201
...
[  247.200108]  acpi_ns_evaluate+0x1bb/0x247
[  247.204170]  acpi_evaluate_object+0x178/0x274
[  247.213249]  acpi_processor_set_pdc+0x154/0x17b
...
The table mutex is held in acpi_tb_install_and_load_table() and is re-visited by
acpi_get_table().

Noticing that the early mutex requirement actually belongs to the OSL layer
and has already been handled in Linux
acpi_os_wait_semaphore()/acpi_os_signal_semaphore(). This patch then can
fix the regression by removing this hidden logic from ACPICA core and
leaving it to OSPMs. A documentation update should also be required.

Fixes: 174cc7187e6f ('ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel')
Reported-by: Tomi Sarvela <tomi.p.sarvela@intel.com>
Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
Cc: Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbdata.c   |  9 ++-------
 drivers/acpi/acpica/tbinstal.c | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 82b0b57..b0399e8 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -852,23 +852,18 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 
 	ACPI_FUNCTION_TRACE(tb_install_and_load_table);
 
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-
 	/* Install the table and load it into the namespace */
 
 	status = acpi_tb_install_standard_table(address, flags, TRUE,
 						override, &i);
 	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
+		goto exit;
 	}
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	status = acpi_tb_load_table(i, acpi_gbl_root_node);
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-unlock_and_exit:
+exit:
 	*table_index = i;
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 5fdf251..01e1b3d 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -217,6 +217,10 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 		goto release_and_exit;
 	}
 
+	/* Acquire the table lock */
+
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
 	if (reload) {
 		/*
 		 * Validate the incoming table signature.
@@ -244,7 +248,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 					 new_table_desc.signature.integer));
 
 			status = AE_BAD_SIGNATURE;
-			goto release_and_exit;
+			goto unlock_and_exit;
 		}
 
 		/* Check if table is already registered */
@@ -279,7 +283,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 				/* Table is still loaded, this is an error */
 
 				status = AE_ALREADY_EXISTS;
-				goto release_and_exit;
+				goto unlock_and_exit;
 			} else {
 				/*
 				 * Table was unloaded, allow it to be reloaded.
@@ -290,6 +294,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 				 * indicate the re-installation.
 				 */
 				acpi_tb_uninstall_table(&new_table_desc);
+				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 				*table_index = i;
 				return_ACPI_STATUS(AE_OK);
 			}
@@ -303,11 +308,19 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	/* Invoke table handler if present */
 
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (acpi_gbl_table_handler) {
 		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_INSTALL,
 					     new_table_desc.pointer,
 					     acpi_gbl_table_handler_context);
 	}
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+unlock_and_exit:
+
+	/* Release the table lock */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 
 release_and_exit:
 
-- 
2.7.4

