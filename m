From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/2] ACPI: EC: Add a quirk for CLEVO M720T/M730T laptop
Date: Fri, 28 Sep 2012 15:22:01 +0800
Message-ID: <1348816921-2637-2-git-send-email-feng.tang@intel.com>
References: <1348816921-2637-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16437 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab2I1H2l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2012 03:28:41 -0400
In-Reply-To: <1348816921-2637-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Francesco <trentini@dei.unipd.it>, Feng Tang <feng.tang@intel.com>

By enlarging the GPE storm threshold back to 20, that laptop's
EC works fine with interrupt mode instead of polling mode.

This solves the bug https://bugzilla.kernel.org/show_bug.cgi?id=45151

Reported-and-Tested-by: Francesco <trentini@dei.unipd.it>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/acpi/ec.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 615264c..a51df96 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -930,6 +930,17 @@ static int ec_flag_msi(const struct dmi_system_id *id)
 	return 0;
 }
 
+/*
+ * Clevo M720 notebook actually works ok with IRQ mode, if we lifted
+ * the GPE storm threshold back to 20
+ */
+static int ec_enlarge_storm_threshold(const struct dmi_system_id *id)
+{
+	pr_debug("Setting the EC GPE storm threshold to 20\n");
+	ec_storm_threshold  = 20;
+	return 0;
+}
+
 static struct dmi_system_id __initdata ec_dmi_table[] = {
 	{
 	ec_skip_dsdt_scan, "Compal JFL92", {
@@ -961,10 +972,13 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	{
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc.") }, NULL},
+	{
+	ec_enlarge_storm_threshold, "CLEVO hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "M720T/M730T"),}, NULL},
 	{},
 };
 
-
 int __init acpi_ec_ecdt_probe(void)
 {
 	acpi_status status;
-- 
1.7.1

