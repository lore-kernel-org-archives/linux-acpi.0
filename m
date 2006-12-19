From: akpm@osdl.org
Subject: [patch 02/19] acpi: fix single linked list manipulation
Date: Tue, 19 Dec 2006 12:56:09 -0800
Message-ID: <200612192056.kBJKuAIb010011@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34451 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942AbWLSU4v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 15:56:51 -0500
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
 1 files changed, 5 insertions(+), 4 deletions(-)

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
