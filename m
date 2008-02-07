From: Len Brown <lenb@kernel.org>
Subject: [PATCH 088/112] ACPI: acpi_pci_irq_find_prt_entry(): use list_for_each_entry() instead of list_for_each()
Date: Thu,  7 Feb 2008 04:34:50 -0500
Message-ID: <1a3b77ae60f19fa85f4cdc34b6c09efb1a18372c.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757528AbYBGJgu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:50 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 62010c2..76d9c66 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -51,10 +51,8 @@ static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(int segment,
 							  int bus,
 							  int device, int pin)
 {
-	struct list_head *node = NULL;
 	struct acpi_prt_entry *entry = NULL;
 
-
 	if (!acpi_prt.count)
 		return NULL;
 
@@ -64,8 +62,7 @@ static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(int segment,
 	 *
 	 */
 	spin_lock(&acpi_prt_lock);
-	list_for_each(node, &acpi_prt.entries) {
-		entry = list_entry(node, struct acpi_prt_entry, node);
+	list_for_each_entry(entry, &acpi_prt.entries, node) {
 		if ((segment == entry->id.segment)
 		    && (bus == entry->id.bus)
 		    && (device == entry->id.device)
-- 
1.5.4.23.gef5b9

