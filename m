From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/8] ACPI: Delete Intel Customer Reference Board (CRB) from OSI(Linux) DMI list
Date: Wed, 23 Jan 2008 21:32:44 -0500
Message-ID: <7ce95ce5c6dbbc3f70933f04537860ffd9dbe17e.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:60148 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751984AbYAXCdj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:39 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Linux does not want BIOS writers to invoke _OSI(Linux) -
for in the field it causes more Windows incompatibility problems
than it solves.

So when it is seen in the BIOS for an Intel Customer Reference Board,
Linux should ignore its effect by default, and should complain loudly.
Otherwise, the reference BIOS will go unfixed, and the bad BIOS
will spread to the field.

Users of this board can get the old behavior with "acpi_osi=Linux"

As this was the only entry, delete acpi_osl_dmi_table[].

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 2203153..15f095e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -79,10 +79,6 @@ static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
 static int osi_linux;		/* disable _OSI(Linux) by default */
 
-#ifdef CONFIG_DMI
-static struct __initdata dmi_system_id acpi_osl_dmi_table[];
-#endif
-
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
@@ -133,7 +129,6 @@ device_initcall(acpi_reserve_resources);
 
 acpi_status __init acpi_os_initialize(void)
 {
-	dmi_check_system(acpi_osl_dmi_table);
 	return AE_OK;
 }
 
@@ -1232,28 +1227,4 @@ acpi_os_validate_address (
     return AE_OK;
 }
 
-#ifdef CONFIG_DMI
-static int dmi_osi_linux(const struct dmi_system_id *d)
-{
-	printk(KERN_NOTICE "%s detected: enabling _OSI(Linux)\n", d->ident);
-	enable_osi_linux(1);
-	return 0;
-}
-
-static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
-	/*
-	 * Boxes that need _OSI(Linux)
-	 */
-	{
-	 .callback = dmi_osi_linux,
-	 .ident = "Intel Napa CRB",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
-		     },
-	 },
-	{}
-};
-#endif /* CONFIG_DMI */
-
 #endif
-- 
1.5.4.rc4.14.g6fc74

