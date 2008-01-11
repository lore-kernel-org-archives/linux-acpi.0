From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/8] ACPI: EC: Enable boot EC before bus_scan
Date: Fri, 11 Jan 2008 15:11:28 -0500
Message-ID: <c04209a7948b95e8c52084e8595e74e9428653d3.1200082104.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:42738 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759945AbYAKUkd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:33 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Some _STA methods called during bus_scan() might require EC region handler,
which might be enabled later in the scan.
Enable it explicitly before scan to avoid errors.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9627

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c   |   14 +++++++++++++-
 drivers/acpi/scan.c |    6 ++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d411017..97dc161 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -892,6 +892,17 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 	return 0;
 }
 
+int __init acpi_boot_ec_enable(void)
+{
+	if (!boot_ec || boot_ec->handlers_installed)
+		return 0;
+	if (!ec_install_handlers(boot_ec)) {
+		first_ec = boot_ec;
+		return 0;
+	}
+	return -EFAULT;
+}
+
 int __init acpi_ec_ecdt_probe(void)
 {
 	int ret;
@@ -924,9 +935,10 @@ int __init acpi_ec_ecdt_probe(void)
 			goto error;
 		/* We really need to limit this workaround, the only ASUS,
 		 * which needs it, has fake EC._INI method, so use it as flag.
+		 * Keep boot_ec struct as it will be needed soon.
 		 */
 		if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &x)))
-			goto error;
+			return -ENODEV;
 	}
 
 	ret = ec_install_handlers(boot_ec);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b4d462..cbfe9ae 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1449,6 +1449,8 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
 	return result;
 }
 
+int __init acpi_boot_ec_enable(void);
+
 static int __init acpi_scan_init(void)
 {
 	int result;
@@ -1480,6 +1482,10 @@ static int __init acpi_scan_init(void)
 	 * Enumerate devices in the ACPI namespace.
 	 */
 	result = acpi_bus_scan_fixed(acpi_root);
+
+	/* EC region might be needed at bus_scan, so enable it now */
+	acpi_boot_ec_enable();
+
 	if (!result)
 		result = acpi_bus_scan(acpi_root, &ops);
 
-- 
1.5.4.rc2.84.gf85fd

