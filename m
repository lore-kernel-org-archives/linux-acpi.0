From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] acpi: fix single linked list manipulation
Date: Sun, 29 Oct 2006 03:53:13 +0900
Message-ID: <20061028185313.GK9973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:63975 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932086AbWJ1Swu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Oct 2006 14:52:50 -0400
Received: by nz-out-0102.google.com with SMTP id z3so797232nzf
        for <linux-acpi@vger.kernel.org>; Sat, 28 Oct 2006 11:52:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

This patch fixes single linked list manipulation for sub_driver.
If the remving entry is not on the head of the sub_driver list,
it goes into infinate loop.

Though that infinate loop doesn't happen. Because the only user of
acpi_pci_register_dirver() is acpiphp.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/acpi/pci_root.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: work-fault-inject/drivers/acpi/pci_root.c
===================================================================
--- work-fault-inject.orig/drivers/acpi/pci_root.c
+++ work-fault-inject/drivers/acpi/pci_root.c
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
