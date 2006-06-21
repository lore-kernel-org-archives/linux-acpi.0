From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [Ubuntu PATCH] disable ACPI on some Phoenix BIOS
Date: Tue, 20 Jun 2006 22:32:51 -0700
Message-ID: <4498DA03.2020001@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:35281 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751090AbWFUFbZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 01:31:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm <akpm@osdl.org>

Disable ACPI on some Phoenix BIOS, or the system will freeze.

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=8ae54aeedb4b33a74ba5d811abef07d83f1838f4


---
 arch/i386/kernel/acpi/boot.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- linux-2617-pv.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2617-pv/arch/i386/kernel/acpi/boot.c
@@ -928,7 +928,15 @@ static struct dmi_system_id __initdata a
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



