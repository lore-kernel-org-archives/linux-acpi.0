From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/4] ACPI: pci_link: remove unnecessary null pointer checks
Date: Tue, 17 Feb 2009 14:00:50 -0700
Message-ID: <20090217210050.4506.23513.stgit@bob.kio>
References: <20090217205906.4506.95815.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:6275 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbZBQVAy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 16:00:54 -0500
In-Reply-To: <20090217205906.4506.95815.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

