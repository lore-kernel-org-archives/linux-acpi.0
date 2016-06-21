From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI / EC: Remove wrong ECDT correction quirks
Date: Tue, 21 Jun 2016 17:42:12 +0800
Message-ID: <6212e8b667ffbc3dfdbf0500ca908bc1a87cbece.1466502046.git.lv.zheng@intel.com>
References: <665386f1dc0a3f6cc343b00a0cf241c6b4a143f8.1466502046.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <665386f1dc0a3f6cc343b00a0cf241c6b4a143f8.1466502046.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Our Windows probe result shows that EC._REG is evaluated after evaluating
all _INI/_STA control methods.

With boot EC always switched in acpi_ec_dsdt_probe(), we can see that as
long as there is no EC opregion accesses in the MLC (module level code, AML
code out of any control methods) and in _INI/_STA, there is no need to make
sure that ECDT must be correct.

Bugs of 9399/12461 were reported against an order issue that BAT0/1._STA
evaluations contain EC accesses while the ECDT setting is wrong.

>From the acpidump output posted on bug 9399, we can see that it is actually
a different issue. In this table, if EC._REG is not executed, EC accesses
will be done in a platform specific manner. As we've already ensured not to
execute EC._REG during the eary stage, we can remove the quirks for bug
9399.

>From the acpidump output posted on bug 12461, we can see that it still
needs the quirk. In this table, EC._REG flags a named object whose default
value is One, thus BAT1._STA surely should invoke EC accesses whatever we
invoke EC._REG or not. We have to keep the quirk for it before we can root
cause the issue.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f63a43a..b1050a0 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1530,6 +1530,11 @@ static int ec_clear_on_resume(const struct dmi_system_id *id)
 	return 0;
 }
 
+/*
+ * Some ECDTs contain wrong register addresses.
+ * MSI MS-171F
+ * https://bugzilla.kernel.org/show_bug.cgi?id=12461
+ */
 static int ec_correct_ecdt(const struct dmi_system_id *id)
 {
 	pr_debug("Detected system needing ECDT address correction.\n");
@@ -1539,16 +1544,6 @@ static int ec_correct_ecdt(const struct dmi_system_id *id)
 
 static struct dmi_system_id ec_dmi_table[] __initdata = {
 	{
-	ec_correct_ecdt, "Asus L4R", {
-	DMI_MATCH(DMI_BIOS_VERSION, "1008.006"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),
-	DMI_MATCH(DMI_BOARD_NAME, "L4R") }, NULL},
-	{
-	ec_correct_ecdt, "Asus M6R", {
-	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "M6R"),
-	DMI_MATCH(DMI_BOARD_NAME, "M6R") }, NULL},
-	{
 	ec_correct_ecdt, "MSI MS-171F", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),}, NULL},
@@ -1590,12 +1585,6 @@ int __init acpi_ec_ecdt_probe(void)
 
 	pr_info("EC description table is found, configuring boot EC\n");
 	if (EC_FLAGS_CORRECT_ECDT) {
-		/*
-		 * Asus L4R, Asus M6R
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=9399
-		 * MSI MS-171F
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=12461
-		 */
 		ec->command_addr = ecdt_ptr->data.address;
 		ec->data_addr = ecdt_ptr->control.address;
 	} else {
-- 
1.7.10
