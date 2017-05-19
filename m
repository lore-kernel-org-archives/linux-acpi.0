From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/3] ACPI / EC: Fix media keys not working problem on some Asus laptops
Date: Fri, 19 May 2017 15:07:55 +0800
Message-ID: <e707d22144582aeff624c451dbb32b3e3324271b.1495176440.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com> <cover.1495176440.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495176440.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Chris Chiu <chiu@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

Some Asus laptops (verified on X550VXK/FX502VD/FX502VE) get no
interrupts when pressing media keys thus the corresponding functions
are not invoked. It's due to the _GPE defines in DSDT for EC returns
differnt value compared to the GPE Number in ECDT. Confirmed with Asus
that the vale in ECDT is the correct one. This commit use a DMI quirk
to prevent calling _GPE when doing ec_parse_device() and keep the ECDT
GPE number setting for the EC device.

Link: https://phabricator.endlessm.com/T16033
      https://phabricator.endlessm.com/T16722
Link: https://bugzilla.kernel.org/show_bug.cgi?id=195651
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e232a1c..b6d28ef 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -190,6 +190,7 @@ static struct workqueue_struct *ec_query_wq;
 
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
 static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
+static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction setting */
 
 /* --------------------------------------------------------------------------
  *                           Logging/Debugging
@@ -1371,12 +1372,21 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	if (ec->data_addr == 0 || ec->command_addr == 0)
 		return AE_OK;
 
-	/* Get GPE bit assignment (EC events). */
-	/* TODO: Add support for _GPE returning a package */
-	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-	ec->gpe = tmp;
+	if (boot_ec && EC_FLAGS_IGNORE_DSDT_GPE) {
+		/*
+		 * First boot_ec is always ECDT EC.
+		 * Always inherit the GPE number setting from the first
+		 * boot_ec.
+		 */
+		ec->gpe = boot_ec->gpe;
+	} else {
+		/* Get GPE bit assignment (EC events). */
+		/* TODO: Add support for _GPE returning a package */
+		status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return status;
+		ec->gpe = tmp;
+	}
 	/* Use the global lock for all EC transactions? */
 	tmp = 0;
 	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
@@ -1769,11 +1779,39 @@ static int ec_correct_ecdt(const struct dmi_system_id *id)
 	return 0;
 }
 
+/*
+ * Some DSDTs contain wrong GPE setting.
+ * Asus FX502VD/VE, X550VXK, X580VD
+ * Link: https://bugzilla.kernel.org/show_bug.cgi?id=195651
+ */
+static int ec_honor_ecdt_gpe(const struct dmi_system_id *id)
+{
+	pr_debug("Detected system needing ignore DSDT GPE setting.\n");
+	EC_FLAGS_IGNORE_DSDT_GPE = 1;
+	return 0;
+}
+
 static struct dmi_system_id ec_dmi_table[] __initdata = {
 	{
 	ec_correct_ecdt, "MSI MS-171F", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUS FX502VD", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "FX502VD"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUS FX502VE", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "FX502VE"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUS X550VXK", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "X550VXK"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUS X580VD", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "X580VD"),}, NULL},
 	{},
 };
 
-- 
2.7.4
