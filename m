From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/94] ACPI: PCI: tweak _PRT lookup debug
Date: Fri, 09 Jan 2009 04:26:51 -0500
Message-ID: <1350487eeb616889f589e9b8c06bd5077452b7e3.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbZAIJ2k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:40 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700D4A6B1P8PI@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:13 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Print one message (either "found" or "not found") for every _PRT
search.  And add pin information to the INTx swizzling debug.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index aabf8a9..7978c97 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -395,15 +395,16 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin,
 	int ret;
 
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Searching for _PRT entry for %s[%c]\n",
-			  pci_name(dev), pin_name(pin)));
-
 	entry = acpi_pci_irq_find_prt_entry(dev, pin);
 	if (!entry) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_PRT entry not found\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No %s[%c] _PRT entry\n",
+				  pci_name(dev), pin_name(pin)));
 		return -1;
 	}
 
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
+			  pci_name(dev), pin_name(pin)));
+
 	ret = func(entry, triggering, polarity, link);
 	return ret;
 }
@@ -455,8 +456,8 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 		return -1;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive GSI %d for device %s from %s\n",
-			  irq, pci_name(dev), pci_name(bridge)));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derived GSI %d for %s INT %c from %s\n",
+			  irq, pci_name(dev), pin_name(orig_pin), pci_name(bridge)));
 
 	return irq;
 }
-- 
1.5.6.6

