From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/94] ACPI: EC: fix compilation warning
Date: Fri, 09 Jan 2009 04:26:04 -0500
Message-ID: <3e54048691bce3f323fd5460695273be379803b9.1231492607.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbZAIJ2H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD7000UT6A5Q6DD@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:41 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Hannes Eder <hannes@hanneseder.net>, Len Brown <len.brown@intel.com>

From: Hannes Eder <hannes@hanneseder.net>

Fix the warning introduced in commit c5279dee26c0e8d7c4200993bfc4b540d2469598,
and give the dummy variable a more verbose name.

  drivers/acpi/ec.c: In function 'acpi_ec_ecdt_probe':
  drivers/acpi/ec.c:1015: warning: ISO C90 forbids mixed declarations and code

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3ba034f..6276e5c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -979,6 +979,7 @@ int __init acpi_ec_ecdt_probe(void)
 {
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
+	acpi_handle dummy;
 
 	boot_ec = make_acpi_ec();
 	if (!boot_ec)
@@ -1011,7 +1012,6 @@ int __init acpi_ec_ecdt_probe(void)
 	}
 	/* This workaround is needed only on some broken machines,
 	 * which require early EC, but fail to provide ECDT */
-	acpi_handle x;
 	printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
 	status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
 					boot_ec, NULL);
@@ -1022,7 +1022,7 @@ int __init acpi_ec_ecdt_probe(void)
 	 * which needs it, has fake EC._INI method, so use it as flag.
 	 * Keep boot_ec struct as it will be needed soon.
 	 */
-	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &x)))
+	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
 		return -ENODEV;
 install:
 	if (!ec_install_handlers(boot_ec)) {
-- 
1.5.6.6

