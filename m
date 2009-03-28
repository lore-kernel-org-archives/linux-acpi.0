From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/98] ACPI: pci_link: remove unnecessary null pointer checks
Date: Sat, 28 Mar 2009 00:30:44 -0400
Message-ID: <6eca4b4ca168981d7648be371945c2a21f463a45.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZC1Ecm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700DOG8M2IREV@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:27 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index b59f59e..dd9ebb9 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -179,9 +179,6 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 {
 	acpi_status status;
 
-	if (!link)
-		return -EINVAL;
-
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
 	if (ACPI_FAILURE(status)) {
@@ -259,9 +256,6 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 	acpi_status status;
 	int irq = 0;
 
-	if (!link)
-		return -EINVAL;
-
 	link->irq.active = 0;
 
 	/* in practice, status disabled is meaningless, ignore it */
@@ -314,7 +308,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 	} *resource;
 	struct acpi_buffer buffer = { 0, NULL };
 
-	if (!link || !irq)
+	if (!irq)
 		return -EINVAL;
 
 	resource = kzalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
@@ -712,9 +706,6 @@ static int acpi_pci_link_add(struct acpi_device *device)
 	int i;
 	int found = 0;
 
-	if (!device)
-		return -EINVAL;
-
 	link = kzalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
@@ -795,9 +786,6 @@ static int acpi_pci_link_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_link *link;
 
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	link = acpi_driver_data(device);
 
 	mutex_lock(&acpi_link_lock);
-- 
1.6.0.6

