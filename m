From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable when unused
Date: Fri, 19 Dec 2008 03:22:52 -0500
Message-ID: <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
References: <1229674972-1511-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:25542 "EHLO
	vms173009.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753172AbYLSIWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 03:22:55 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KC4005QP72NDU92@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 02:18:23 -0600 (CST)
In-reply-to: <1229674972-1511-1-git-send-email-lenb@kernel.org>
In-reply-to: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

We start the system off with disabled links.
Here we enable the reference counting
on the links so that when drivers free IRQs
the links can return to the disabled state.

Drivers free their IRQ and reference on a link
when they unload.  They may also do so upon
suspend.  However, if they don't, irqrouter_resume()
will still resume any links that were
not disabled before suspend.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 595b131..7d12762 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -693,6 +693,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 		printk(KERN_ERR PREFIX "Link isn't initialized\n");
 		return -1;
 	}
+<<<<<<< HEAD:drivers/acpi/pci_link.c
 #ifdef	FUTURE_USE
 	/*
 	 * The Link reference count allows us to _DISable an unused link
@@ -703,8 +704,9 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 	 * to prevent duplicate acpi_pci_link_set()
 	 * which would harm some systems
 	 */
+=======
+>>>>>>> 683984a... ACPI: PCI Interrupt Links -- disable when unused:drivers/acpi/pci_link.c
 	link->refcnt--;
-#endif
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Link %s is dereferenced %d\n",
 			  acpi_device_bid(link->device), link->refcnt));
-- 
1.5.6.5

