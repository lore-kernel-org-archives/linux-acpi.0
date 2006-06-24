From: akpm@osdl.org
Subject: [patch 08/18] acpiphp: prevent duplicate slot numbers when no _SUN
Date: Sat, 24 Jun 2006 16:36:40 -0700
Message-ID: <200606242336.k5ONaeM9008065@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:18588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751206AbWFXXol (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:44:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kristen.c.accardi@intel.com


From: Kristen Accardi <kristen.c.accardi@intel.com>

Dock bridges generally do not implement _SUN, yet show up as ejectable
slots.  If you have more than one ejectable slot that does not implement
SUN, with the current code you will get duplicate slot numbers.  So, if
there is no _SUN, use the current count of the number of slots found
instead.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pci/hotplug/acpiphp_glue.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/pci/hotplug/acpiphp_glue.c~acpiphp-prevent-duplicate-slot-numbers-when-no-_sun drivers/pci/hotplug/acpiphp_glue.c
--- devel/drivers/pci/hotplug/acpiphp_glue.c~acpiphp-prevent-duplicate-slot-numbers-when-no-_sun	2006-06-01 20:17:06.000000000 -0700
+++ devel-akpm/drivers/pci/hotplug/acpiphp_glue.c	2006-06-01 20:17:06.000000000 -0700
@@ -218,8 +218,13 @@ register_slot(acpi_handle handle, u32 lv
 		newfunc->flags |= FUNC_HAS_DCK;
 
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
-	if (ACPI_FAILURE(status))
-		sun = -1;
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * use the count of the number of slots we've found
+		 * for the number of the slot
+		 */
+		sun = bridge->nr_slots+1;
+	}
 
 	/* search for objects that share the same slot */
 	for (slot = bridge->slots; slot; slot = slot->next)
_
