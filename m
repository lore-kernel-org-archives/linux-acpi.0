From: akpm@osdl.org
Subject: [patch 16/18] disable ACPI on some Phoenix BIOS
Date: Sat, 24 Jun 2006 16:37:18 -0700
Message-ID: <200606242337.k5ONbJQp008104@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:29596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbWFXXo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:44:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, randy.dunlap@oracle.com, mjg59@srcf.ucam.org


From: Randy Dunlap <randy.dunlap@oracle.com>

Disable ACPI on some Phoenix BIOS, or the system will freeze.

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=8ae54aeedb4b33a74ba5d811abef07d83f1838f4

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/acpi/boot.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/acpi/boot.c~disable-acpi-on-some-phoenix-bios arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c~disable-acpi-on-some-phoenix-bios
+++ a/arch/i386/kernel/acpi/boot.c
@@ -991,7 +991,15 @@ static struct dmi_system_id __initdata a
 		     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
 		     },
 	 },
-
+	 {
+	  .callback = dmi_disable_acpi,
+	  .ident = "Phoenix Technologies",
+	  .matches = {
+	  	      DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies, LTD"),
+		      DMI_MATCH(DMI_BIOS_VERSION, "6.00 PG"),
+		      DMI_MATCH(DMI_BIOS_DATE, "11/05/2003"),
+	  	     },
+	 },
 	/*
 	 * Boxes that need acpi=ht
 	 */
_
