From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/5] ACPI: pci_root: check _CRS,
	then _BBN for downstream bus number
Date: Thu, 18 Jun 2009 14:46:47 -0600
Message-ID: <20090618204647.15850.97454.stgit@bob.kio>
References: <20090618203916.15850.7977.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:3771 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbZFRUqo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 16:46:44 -0400
In-Reply-To: <20090618203916.15850.7977.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Alex Chiang <achiang@hp.com>, Shaohua Li <shaohua.li@intel.com>

To find a host bridge's downstream bus number, we currently look at _BBN
first.  If _BBN returns a bus number we've already seen, we conclude that
_BBN was wrong and look for a bus number in _CRS.

However, the spec[1] (figure 5-5 and the example in sec 9.12.1) and an ACPI
FAQ[2] suggest that the OS should use _CRS to discover the bus number
range, and that _BBN is really intended to bootstrap _CRS methods that
reference PCI opregions.

This patch makes us always look at _CRS first.  If _CRS doesn't supply a
bus number, we look at _BBN.  If _BBN doesn't exist, we default to zero.
This makes the behavior consistent regardless of device discovery order.
Previously, if A and B had duplicate _BBNs and we found A first, we'd only
look at B's _CRS, whereas if we found B first, we'd only look at A's _CRS.

I'm told that Windows discovers host bridge bus numbers using _CRS, so
it should be fairly safe to rely on this BIOS functionality.

This patch also removes two misleading messages: we printed the "Wrong _BBN
value, reboot and use option 'pci=noacpi'" message before looking at _CRS,
so we would likely find the bus number in _CRS, the system would work fine,
and the user would be confused.  The "PCI _CRS %d overrides _BBN 0" message
incorrectly assumes _BBN was zero, and it's useless anyway because we
print the segment/bus number a few lines later.

References:
    [1] http://www.acpi.info/DOWNLOADS/ACPIspec30b.pdf
    [2] http://www.acpi.info/acpi_faq.htm _BBN/_CRS discussion
    http://download.microsoft.com/download/9/8/f/98f3fe47-dfc3-4e74-92a3-088782200fe7/TWAR05005_WinHEC05.ppt (slide 17)
    http://bugzilla.kernel.org/show_bug.cgi?id=1662 ASUS PR-DLS
    http://bugzilla.kernel.org/show_bug.cgi?id=1127 ASUS PR-DLSW
    http://bugzilla.kernel.org/show_bug.cgi?id=1741 ASUS PR-DLS533

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Shaohua Li <shaohua.li@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   54 ++++++++++++++---------------------------------
 1 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f341b07..7847732 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -470,12 +470,12 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_pci_root *root = NULL;
-	struct acpi_pci_root *tmp;
 	acpi_status status = AE_OK;
 	unsigned long long value = 0;
 	acpi_handle handle = NULL;
 	struct acpi_device *child;
 	u32 flags, base_flags;
+	int bus;
 
 
 	if (!device)
@@ -523,46 +523,24 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	/* 
 	 * Bus
 	 * ---
-	 * Obtained via _BBN, if exists, otherwise assumed to be zero (0).
+	 * Check _CRS first, then _BBN.  If no _BBN, default to zero.
 	 */
-	status = acpi_evaluate_integer(device->handle, METHOD_NAME__BBN, NULL,
-				       &value);
-	switch (status) {
-	case AE_OK:
-		root->id.bus = (u16) value;
-		break;
-	case AE_NOT_FOUND:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Assuming bus 0 (no _BBN)\n"));
-		root->id.bus = 0;
-		break;
-	default:
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BBN"));
-		result = -ENODEV;
-		goto end;
-	}
-
-	/* Some systems have wrong _BBN */
-	list_for_each_entry(tmp, &acpi_pci_roots, node) {
-		if ((tmp->id.segment == root->id.segment)
-		    && (tmp->id.bus == root->id.bus)) {
-			int bus = 0;
-			acpi_status status;
-
-			printk(KERN_ERR PREFIX
-				    "Wrong _BBN value, reboot"
-				    " and use option 'pci=noacpi'\n");
-
-			status = try_get_root_bridge_busnr(device->handle, &bus);
-			if (ACPI_FAILURE(status))
-				break;
-			if (bus != root->id.bus) {
-				printk(KERN_INFO PREFIX
-				       "PCI _CRS %d overrides _BBN 0\n", bus);
-				root->id.bus = bus;
-			}
-			break;
+	status = try_get_root_bridge_busnr(device->handle, &bus);
+	if (ACPI_SUCCESS(status))
+		root->id.bus = bus;
+	else {
+		status = acpi_evaluate_integer(device->handle, METHOD_NAME__BBN,					       NULL, &value);
+		if (ACPI_SUCCESS(status))
+			root->id.bus = (u16) value;
+		else if (status == AE_NOT_FOUND)
+			root->id.bus = 0;
+		else {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BBN"));
+			result = -ENODEV;
+			goto end;
 		}
 	}
+
 	/*
 	 * Device & Function
 	 * -----------------

