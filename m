From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: update pci_link debug messages
Date: Fri, 19 Dec 2008 03:22:51 -0500
Message-ID: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
References: <1229674972-1511-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:37762 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbYLSIWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 03:22:55 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC4002TM7A5JS82@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 02:22:54 -0600 (CST)
In-reply-to: <1229674972-1511-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

debug message format/content, no functional change

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index e52ad91..595b131 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -414,7 +414,8 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 		link->irq.active = irq;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link %s set to IRQ %d\n",
+		acpi_device_bid(link->device), link->irq.active));
 
       end:
 	kfree(resource);
@@ -649,6 +650,9 @@ acpi_pci_link_allocate_irq(acpi_handle handle,
 		return -1;
 	}
 	link->refcnt++;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "Link %s is referenced %d\n",
+			  acpi_device_bid(link->device), link->refcnt));
 	mutex_unlock(&acpi_link_lock);
 
 	if (triggering)
@@ -657,9 +661,6 @@ acpi_pci_link_allocate_irq(acpi_handle handle,
 		*polarity = link->irq.polarity;
 	if (name)
 		*name = acpi_device_bid(link->device);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Link %s is referenced\n",
-			  acpi_device_bid(link->device)));
 	return (link->irq.active);
 }
 
@@ -705,10 +706,13 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 	link->refcnt--;
 #endif
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Link %s is dereferenced\n",
-			  acpi_device_bid(link->device)));
+			  "Link %s is dereferenced %d\n",
+			  acpi_device_bid(link->device), link->refcnt));
 
 	if (link->refcnt == 0) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "Link %s is disabled\n",
+			  acpi_device_bid(link->device)));
 		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
 	}
 	mutex_unlock(&acpi_link_lock);
@@ -782,13 +786,17 @@ static int acpi_pci_link_add(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_pci_link_resume(struct acpi_pci_link *link)
+static void acpi_pci_link_resume(struct acpi_pci_link *link)
 {
 
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link %s resume ref %d act %d ini %d\n",
+		acpi_device_bid(link->device), link->refcnt,
+		link->irq.active, link->irq.initialized));
+
 	if (link->refcnt && link->irq.active && link->irq.initialized)
-		return (acpi_pci_link_set(link, link->irq.active));
-	else
-		return 0;
+		acpi_pci_link_set(link, link->irq.active);
+
+	return;
 }
 
 static int irqrouter_resume(struct sys_device *dev)
-- 
1.5.6.5

