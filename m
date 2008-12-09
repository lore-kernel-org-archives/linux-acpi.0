From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 11/20] ACPI: PCI: tweak _PRT lookup debug
Date: Mon, 08 Dec 2008 21:30:56 -0700
Message-ID: <20081209043056.26415.59637.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:11207 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYLIEa5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:57 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Print one message (either "found" or "not found") for every _PRT
search.  And add pin information to the INTx swizzling debug.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 6f4c5f3..c8246c2 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -397,15 +397,16 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin,
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
@@ -457,8 +458,8 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 		return -1;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive GSI %d for device %s from %s\n",
-			  irq, pci_name(dev), pci_name(bridge)));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derived GSI %d for %s INT %c from %s\n",
+			  irq, pci_name(dev), pin_name(orig_pin), pci_name(bridge)));
 
 	return irq;
 }

