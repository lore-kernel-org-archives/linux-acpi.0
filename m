From: Len Brown <lenb@kernel.org>
Subject: ACPI reboot
Date: Thu, 16 Oct 2008 20:08:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161958460.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:36347 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYJQAIt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 20:08:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8U00663WEDVNI2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 16 Oct 2008 19:08:38 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: linux-acpi@vger.kernel.org

Yakui,
I think your patch below from
http://bugzilla.kernel.org/show_bug.cgi?id=11481
is close, but not quite right.

"reboot=a" should not be necessary, as reboot_type = BOOT_ACPI
by default, yes?

Re: DMI to ignore a missing (acpi_gbl_FADT.flags & 
ACPI_FADT_RESET_REGISTER)....

If we need DMI,
it should be checked at _boot_ time, not at _reboot_ 
time, and the table should be marked _initdata.

But the real question is if we should be checking this bit
at all.  The fact that we are adding DMI to ignore it suggest
that we should think about ignoring it by default, and instead
perhaps sanity checking acpi_gbl_FADT.reset_register
and basing our decision to use it on that?

thanks,
-Len
-----------

Subject: ACPI: Add the DMI check table to support ACPI reboot
From: Zhao Yakui <yakui.zhao@intel.com>

On some broken laptops the system can't be rebooted after it is resumed from
S3. The system can be rebooted by writting RESET_VALUE to 
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
 
