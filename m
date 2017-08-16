From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI: EC: Fix a regression related to wrong ECDT initialization order
Date: Wed, 16 Aug 2017 15:29:49 +0800
Message-ID: <756461e045cbddb16418685a1b12c3c9a491d328.1502868457.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:61077 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdHPH3x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 03:29:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The following commit is bisected out to be a regression culprit:
 Commit: c712bb58d8278465b1a91f362a08f5c79ad077e4
 Subject: ACPI / EC: Add support to skip boot stage DSDT probe
However the problem is actually originated from the following commit:
 Commit: 2a5708409e4e05446eb1a89ecb48641d6fd5d5a9
 Subject: ACPI / EC: Fix a gap that ECDT EC cannot handle EC events

Commit 2a570840 introduces acpi_ec_ecdt_start(), but invokes it too early:
earlier before acpi_ec_query_init(). Thus when EC event is flagged after
boot, ec_query_wq is not valid, resulting in a kernel warning:
 [    3.580017] BUG: unable to handle kernel NULL pointer dereference at 0000000000000102
 ...
 [    4.380005] Workqueue: events acpi_ec_event_handler
 [    4.380005] task: ffff9f539790dac0 task.stack: ffffb437c0e10000
 [    4.380005] RIP: 0010:__queue_work+0x32/0x430

Normally DSDT EC should always be valid. Thus acpi_ec_ecdt_start() is
actually a no-op in most of the cases. While the commit c712bb58 skips
probing DSDT EC as boot EC when ECDT EC is valid, making this bug
surfaced.

This patch fixes this issue by invoking acpi_ec_ecdt_start() after
acpi_ec_query_init() in acpi_ec_init().

Link: https://jira01.devtools.intel.com/browse/LCK-4348
Fixes: 2a5708409e4e ("ACPI / EC: Fix a gap that ECDT EC cannot handle EC events")
Fixes: c712bb58d827 ("ACPI / EC: Add support to skip boot stage DSDT probe")
Reported-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c       | 17 +++++++----------
 drivers/acpi/internal.h |  1 -
 drivers/acpi/scan.c     |  1 -
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 62068a5..ae3d6d1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1741,7 +1741,7 @@ int __init acpi_ec_dsdt_probe(void)
  * functioning ECDT EC first in order to handle the events.
  * https://bugzilla.kernel.org/show_bug.cgi?id=115021
  */
-int __init acpi_ec_ecdt_start(void)
+static int __init acpi_ec_ecdt_start(void)
 {
 	acpi_handle handle;
 
@@ -2003,20 +2003,17 @@ static inline void acpi_ec_query_exit(void)
 int __init acpi_ec_init(void)
 {
 	int result;
+	int ecdt_fail, dsdt_fail;
 
 	/* register workqueue for _Qxx evaluations */
 	result = acpi_ec_query_init();
 	if (result)
-		goto err_exit;
-	/* Now register the driver for the EC */
-	result = acpi_bus_register_driver(&acpi_ec_driver);
-	if (result)
-		goto err_exit;
+		return result;
 
-err_exit:
-	if (result)
-		acpi_ec_query_exit();
-	return result;
+	/* Drivers must be started after acpi_ec_query_init() */
+	ecdt_fail = acpi_ec_ecdt_start();
+	dsdt_fail = acpi_bus_register_driver(&acpi_ec_driver);
+	return ecdt_fail && dsdt_fail ? -ENODEV : 0;
 }
 
 /* EC driver currently not unloadable */
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 58dd7ab..3f5af4d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -185,7 +185,6 @@ typedef int (*acpi_ec_query_func) (void *data);
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
-int acpi_ec_ecdt_start(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 33897298..70fd550 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2084,7 +2084,6 @@ int __init acpi_scan_init(void)
 
 	acpi_gpe_apply_masked_gpes();
 	acpi_update_all_gpes();
-	acpi_ec_ecdt_start();
 
 	acpi_scan_initialized = true;
 
-- 
2.7.4

