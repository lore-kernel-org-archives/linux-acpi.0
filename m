From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v2] ACPI / APEI: Suppress message if HEST not present
Date: Wed, 16 Aug 2017 12:27:53 +0100
Message-ID: <20170816112753.12085-1-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>
List-Id: linux-acpi@vger.kernel.org

According to the ACPI specification, firmware is not required to provide
the Hardware Error Source Table (HEST). When HEST is not present, the
following superfluous message is printed to the kernel boot log -

[    3.460067] GHES: HEST is not enabled!

Extend hest_disable variable to track whether the firmware provides this
table and if it is not present skip any log output. The existing
behaviour is preserved in all other cases.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c |  4 ++--
 drivers/acpi/apei/hest.c | 13 +++++++------
 include/acpi/apei.h      |  8 +++++++-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d452b238..f8685bcbeff2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1262,10 +1262,10 @@ static int __init ghes_init(void)
 {
 	int rc;
 
-	if (acpi_disabled)
+	if (acpi_disabled || hest_disable == HEST_NOT_FOUND)
 		return -ENODEV;
 
-	if (hest_disable) {
+	if (hest_disable == HEST_DISABLED) {
 		pr_info(GHES_PFX "HEST is not enabled!\n");
 		return -EINVAL;
 	}
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 456b488eb1df..9cb74115a43d 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -37,7 +37,7 @@
 
 #define HEST_PFX "HEST: "
 
-bool hest_disable;
+int hest_disable;
 EXPORT_SYMBOL_GPL(hest_disable);
 
 /* HEST table parsing */
@@ -213,7 +213,7 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
 
 static int __init setup_hest_disable(char *str)
 {
-	hest_disable = 1;
+	hest_disable = HEST_DISABLED;
 	return 0;
 }
 
@@ -232,9 +232,10 @@ void __init acpi_hest_init(void)
 
 	status = acpi_get_table(ACPI_SIG_HEST, 0,
 				(struct acpi_table_header **)&hest_tab);
-	if (status == AE_NOT_FOUND)
-		goto err;
-	else if (ACPI_FAILURE(status)) {
+	if (status == AE_NOT_FOUND) {
+		hest_disable = HEST_NOT_FOUND;
+		return;
+	} else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err(HEST_PFX "Failed to get table, %s\n", msg);
 		rc = -EINVAL;
@@ -257,5 +258,5 @@ void __init acpi_hest_init(void)
 	pr_info(HEST_PFX "Table parsing has been initialized.\n");
 	return;
 err:
-	hest_disable = 1;
+	hest_disable = HEST_DISABLED;
 }
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 76284bb560a6..c46694abea28 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -16,7 +16,13 @@
 
 #ifdef __KERNEL__
 
-extern bool hest_disable;
+enum hest_status {
+	HEST_ENABLED,
+	HEST_DISABLED,
+	HEST_NOT_FOUND,
+};
+
+extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
 extern bool ghes_disable;
-- 
2.13.2
