From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/2] acpi/einj: Convert EINJ_PFX to proper pr_fmt
Date: Mon, 23 May 2016 10:28:03 +0200
Message-ID: <1463992084-10012-1-git-send-email-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35812 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbcEWI2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 May 2016 04:28:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>

From: Borislav Petkov <bp@suse.de>

... and remove it from the pr_* calls.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/einj.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 559c1173de1c..4ba41855799f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -33,7 +33,8 @@
 
 #include "apei-internal.h"
 
-#define EINJ_PFX "EINJ: "
+#undef pr_fmt
+#define pr_fmt(fmt) "EINJ: " fmt
 
 #define SPIN_UNIT		100			/* 100ns */
 /* Firmware should respond within 1 milliseconds */
@@ -179,8 +180,7 @@ static int einj_get_available_error_type(u32 *type)
 static int einj_timedout(u64 *t)
 {
 	if ((s64)*t < SPIN_UNIT) {
-		pr_warning(FW_WARN EINJ_PFX
-			   "Firmware does not respond in time\n");
+		pr_warning(FW_WARN "Firmware does not respond in time\n");
 		return 1;
 	}
 	*t -= SPIN_UNIT;
@@ -307,8 +307,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
-		pr_err(EINJ_PFX
-	"Can not request [mem %#010llx-%#010llx] for Trigger table\n",
+		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
 			    sizeof(*trigger_tab) - 1);
@@ -316,13 +315,12 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	}
 	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
 	if (!trigger_tab) {
-		pr_err(EINJ_PFX "Failed to map trigger table!\n");
+		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
 	rc = einj_check_trigger_header(trigger_tab);
 	if (rc) {
-		pr_warning(FW_BUG EINJ_PFX
-			   "The trigger error action table is invalid\n");
+		pr_warning(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
@@ -336,8 +334,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 			       table_size - sizeof(*trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
-		pr_err(EINJ_PFX
-"Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
+		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
 		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
@@ -345,7 +342,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	iounmap(trigger_tab);
 	trigger_tab = ioremap_cache(trigger_paddr, table_size);
 	if (!trigger_tab) {
-		pr_err(EINJ_PFX "Failed to map trigger table!\n");
+		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
 	trigger_entry = (struct acpi_whea_header *)
@@ -704,13 +701,13 @@ static int __init einj_init(void)
 		return -ENODEV;
 	else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
-		pr_err(EINJ_PFX "Failed to get table, %s\n", msg);
+		pr_err("Failed to get table, %s\n", msg);
 		return -EINVAL;
 	}
 
 	rc = einj_check_table(einj_tab);
 	if (rc) {
-		pr_warning(FW_BUG EINJ_PFX "EINJ table is invalid\n");
+		pr_warning(FW_BUG "EINJ table is invalid\n");
 		return -EINVAL;
 	}
 
@@ -787,7 +784,7 @@ static int __init einj_init(void)
 			goto err_unmap;
 	}
 
-	pr_info(EINJ_PFX "Error INJection is initialized.\n");
+	pr_info("Error INJection is initialized.\n");
 
 	return 0;
 
-- 
2.7.3

