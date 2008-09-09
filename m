From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]: Add the DMI check table to support ACPI reboot
Date: Tue, 09 Sep 2008 11:38:48 +0800
Message-ID: <1220931528.3989.15.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30928 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbYIIDYT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Sep 2008 23:24:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Add the DMI check table to support ACPI reboot
From: Zhao Yakui <yakui.zhao@intel.com>

On some laptops the system can't be rebooted after it is resumed from
S3. The system can be rebooted by writing RESET_VALUE to 
RESET_REGISTER although the ACPI_FADT_RESET_REGISTER bit in the FADT flag 
indicates that ACPI reboot mechanism is not supported.

Maybe it is appropriate that the acpi_reboot DMI checkt table is added so that
the ACPI reboot is used forcibly on some broken laptops in case of adding
the boot option of "reboot=a".

http://bugzilla.kernel.org/show_bug.cgi?id=7299
http://bugzilla.kernel.org/show_bug.cgi?id=11481

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/reboot.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/reboot.c
===================================================================
--- linux-2.6.orig/drivers/acpi/reboot.c
+++ linux-2.6/drivers/acpi/reboot.c
@@ -3,6 +3,22 @@
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
 
+const static struct dmi_system_id reboot_dmi_table[] = {
+	{
+	NULL, "Asus M3N board", {
+	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
+	DMI_MATCH(DMI_BIOS_DATE, "03/16/2004"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "M3N"),
+	DMI_MATCH(DMI_BOARD_NAME, "M3N") }, NULL},
+	{
+	NULL, "Asus M6NE board", {
+	DMI_MATCH(DMI_BIOS_VERSION, "0208"),
+	DMI_MATCH(DMI_BIOS_DATE, "03/28/2005"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "M6Ne"),
+	DMI_MATCH(DMI_BOARD_NAME, "M6Ne") }, NULL},
+	{},
+};
+
 void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
@@ -16,7 +32,14 @@ void acpi_reboot(void)
 	rr = &acpi_gbl_FADT.reset_register;
 
 	/* Is the reset register supported? */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
+	if (dmi_check_system(reboot_dmi_table)) {
+		/*
+		 * If the laptop falls into the DMI check table, the
+		 * ACPI reboot mechanism will be used forcibly regardless of
+		 * the ACPI_FADT_RESET_REGISTER bit flag.
+		 */
+		printk(KERN_DEBUG "ACPI reboot mechanism will be used\n");
+	} else if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
 	    rr->bit_width != 8 || rr->bit_offset != 0)
 		return;
 


