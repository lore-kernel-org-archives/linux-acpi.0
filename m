From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] ACPI / PCI: Fix NULL pointer dereference in
 acpi_get_pci_dev() (rev. 2)
Date: Thu, 15 Oct 2009 00:59:39 -0400
Message-ID: <497fb54f578efd2b479727bc88d5ef942c0a1e2d.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:49071 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZJOFAv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:51 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ00BE1HVRFXM5@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 15 Oct 2009 00:00:04 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

acpi_get_pci_dev() may be called for a non-PCI device, in which case
it should return NULL.  However, it assumes that every handle it
finds in the ACPI CA name space, between given device handle and the
PCI root bridge handle, corresponds to a PCI-to-PCI bridge with an
existing secondary bus.  For this reason, when it finds a struct
pci_dev object corresponding to one of them, it doesn't check if
its 'subordinate' field is a valid pointer.  This obviously leads to
a NULL pointer dereference if acpi_get_pci_dev() is called for a
non-PCI device with a PCI parent which is not a bridge.

To fix this issue make acpi_get_pci_dev() check if pdev->subordinate
is not NULL for every device it finds on the path between the root
bridge and the device it's supposed to get to and return NULL if the
"target" device cannot be found.

http://bugzilla.kernel.org/show_bug.cgi?id=14129
(worked in 2.6.30, regression in 2.6.31)

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Danny Feng <dfeng@redhat.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
Tested-by: chepioq <chepioq@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_root.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 3112221..1af8081 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -389,6 +389,17 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 
 		pbus = pdev->subordinate;
 		pci_dev_put(pdev);
+
+		/*
+		 * This function may be called for a non-PCI device that has a
+		 * PCI parent (eg. a disk under a PCI SATA controller).  In that
+		 * case pdev->subordinate will be NULL for the parent.
+		 */
+		if (!pbus) {
+			dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
+			pdev = NULL;
+			break;
+		}
 	}
 out:
 	list_for_each_entry_safe(node, tmp, &device_list, node)
-- 
1.6.0.6

