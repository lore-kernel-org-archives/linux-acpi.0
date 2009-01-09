From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/94] ACPI: EC: Add some basic check for ECDT data
Date: Fri, 09 Jan 2009 04:26:03 -0500
Message-ID: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:62823 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZAIJ17 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700MYI6A39N11@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:41 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

One more ASUS comes with empty ECDT, add a guard for it...

http://bugzilla.kernel.org/show_bug.cgi?id=11880

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index cf41f9f..3ba034f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -977,7 +977,6 @@ static const struct acpi_device_id ec_device_ids[] = {
 
 int __init acpi_ec_ecdt_probe(void)
 {
-	int ret;
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
@@ -1005,30 +1004,32 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->gpe = ecdt_ptr->gpe;
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
-	} else {
-		/* This workaround is needed only on some broken machines,
-		 * which require early EC, but fail to provide ECDT */
-		acpi_handle x;
-		printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
-		status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
-						boot_ec, NULL);
-		/* Check that acpi_get_devices actually find something */
-		if (ACPI_FAILURE(status) || !boot_ec->handle)
-			goto error;
-		/* We really need to limit this workaround, the only ASUS,
-		 * which needs it, has fake EC._INI method, so use it as flag.
-		 * Keep boot_ec struct as it will be needed soon.
-		 */
-		if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &x)))
-			return -ENODEV;
+		/* Add some basic check against completely broken table */
+		if (boot_ec->data_addr != boot_ec->command_addr)
+			goto install;
+	/* fall through */
 	}
-
-	ret = ec_install_handlers(boot_ec);
-	if (!ret) {
+	/* This workaround is needed only on some broken machines,
+	 * which require early EC, but fail to provide ECDT */
+	acpi_handle x;
+	printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
+	status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
+					boot_ec, NULL);
+	/* Check that acpi_get_devices actually find something */
+	if (ACPI_FAILURE(status) || !boot_ec->handle)
+		goto error;
+	/* We really need to limit this workaround, the only ASUS,
+	 * which needs it, has fake EC._INI method, so use it as flag.
+	 * Keep boot_ec struct as it will be needed soon.
+	 */
+	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &x)))
+		return -ENODEV;
+install:
+	if (!ec_install_handlers(boot_ec)) {
 		first_ec = boot_ec;
 		return 0;
 	}
-      error:
+error:
 	kfree(boot_ec);
 	boot_ec = NULL;
 	return -ENODEV;
-- 
1.5.6.6

