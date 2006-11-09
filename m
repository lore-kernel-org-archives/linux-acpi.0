From: akpm@osdl.org
Subject: [patch 2/2] acpi: fix single linked list manipulation
Date: Wed, 08 Nov 2006 19:44:47 -0800
Message-ID: <200611090344.kA93ilOY003450@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:4013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932497AbWKIDpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Nov 2006 22:45:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, akinobu.mita@gmail.com, len.brown@intel.com

From: Akinobu Mita <akinobu.mita@gmail.com>

Fix single linked list manipulation for sub_driver.  If the remving entry
is not on the head of the sub_driver list, it goes into infinate loop.

Though that infinite loop doesn't happen.  Because the only user of
acpi_pci_register_dirver() is acpiphp.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/pci_root.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/pci_root.c~acpi-fix-single-linked-list-manipulation drivers/acpi/pci_root.c
--- a/drivers/acpi/pci_root.c~acpi-fix-single-linked-list-manipulation
+++ a/drivers/acpi/pci_root.c
@@ -98,11 +98,12 @@ void acpi_pci_unregister_driver(struct a
 
 	struct acpi_pci_driver **pptr = &sub_driver;
 	while (*pptr) {
-		if (*pptr != driver)
-			continue;
-		*pptr = (*pptr)->next;
-		break;
+		if (*pptr == driver)
+			break;
+		pptr = &(*pptr)->next;
 	}
+	BUG_ON(!*pptr);
+	*pptr = (*pptr)->next;
 
 	if (!driver->remove)
 		return;
_
