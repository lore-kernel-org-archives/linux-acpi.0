From: donald.d.dugger@intel.com
Subject: [PATCH] Fix possible null ptr dereference
Date: Fri, 17 Oct 2008 07:49:50 -0700
Message-ID: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7968 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbYJQO5L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Oct 2008 10:57:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: bjorn.helgaas@hp.com, akpm@linux-foundation.org, astarikovskiy@suse.de, lenb@kernel.org

Code in `pci_link.c' is calling the internal routine `acpi_ut_evaluate_object'
which is dangerous given that it is passing a NULL pointer when it should
be passing a pointer to a real object.  The patch corrects the issue by
having the code call the external routine `acpi_evaluate_object', which
correctly handles a NULL pointer.

Signed-off-by: Don Dugger <donald.d.dugger@intel.com>


----- cut here for patch.d/acpi_null-1017.patch -----
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index cf47805..65bf4fa 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -709,7 +709,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 			  acpi_device_bid(link->device)));
 
 	if (link->refcnt == 0) {
-		acpi_ut_evaluate_object(link->device->handle, "_DIS", 0, NULL);
+		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
 	}
 	mutex_unlock(&acpi_link_lock);
 	return (link->irq.active);
@@ -773,7 +773,7 @@ static int acpi_pci_link_add(struct acpi_device *device)
 
       end:
 	/* disable all links -- to be activated on use */
-	acpi_ut_evaluate_object(device->handle, "_DIS", 0, NULL);
+	acpi_evaluate_object(device->handle, "_DIS", NULL, NULL);
 	mutex_unlock(&acpi_link_lock);
 
 	if (result)
