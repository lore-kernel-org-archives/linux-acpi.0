From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] fix warning in pci_slot
Date: Tue, 22 Jul 2008 12:37:17 -0600
Message-ID: <20080722183717.GF7337@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:42517 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbYGVShe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2008 14:37:34 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org


I get warnings about 'device' possibly being used uninitialised.  While I
can deduce this is not true, it seems that GCC can't.  This patch changes
`check_slot' to return device on success and -1 on error, which shuts
GCC up.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

I couldn't say I've tested this in any meaningful way.

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index b9ab030..61bac61 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -76,9 +76,9 @@ static struct acpi_pci_driver acpi_pci_slot_driver = {
 };
 
 static int
-check_slot(acpi_handle handle, int *device, unsigned long *sun)
+check_slot(acpi_handle handle, unsigned long *sun)
 {
-	int retval = 0;
+	int device = -1;
 	unsigned long adr, sta;
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -89,32 +89,27 @@ check_slot(acpi_handle handle, int *device, unsigned long *sun)
 	if (check_sta_before_sun) {
 		/* If SxFy doesn't have _STA, we just assume it's there */
 		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-		if (ACPI_SUCCESS(status) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
-			retval = -1;
+		if (ACPI_SUCCESS(status) && !(sta & ACPI_STA_DEVICE_PRESENT))
 			goto out;
-		}
 	}
 
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 	if (ACPI_FAILURE(status)) {
 		dbg("_ADR returned %d on %s\n", status, (char *)buffer.pointer);
-		retval = -1;
 		goto out;
 	}
 
-	*device = (adr >> 16) & 0xffff;
-
 	/* No _SUN == not a slot == bail */
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, sun);
 	if (ACPI_FAILURE(status)) {
 		dbg("_SUN returned %d on %s\n", status, (char *)buffer.pointer);
-		retval = -1;
 		goto out;
 	}
 
+	device = (adr >> 16) & 0xffff;
 out:
 	kfree(buffer.pointer);
-	return retval;
+	return device;
 }
 
 struct callback_args {
@@ -144,7 +139,8 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	struct callback_args *parent_context = context;
 	struct pci_bus *pci_bus = parent_context->pci_bus;
 
-	if (check_slot(handle, &device, &sun))
+	device = check_slot(handle, &sun);
+	if (device < 0)
 		return AE_OK;
 
 	slot = kmalloc(sizeof(*slot), GFP_KERNEL);

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
