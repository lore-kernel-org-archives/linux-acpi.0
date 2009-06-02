From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 10/10] ACPI: acpi_pci_unbind should clean up properly after
	acpi_pci_bind
Date: Tue, 02 Jun 2009 09:25:27 -0600
Message-ID: <20090602152527.7346.97494.stgit@bob.kio>
References: <20090602152351.7346.48697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:8158 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758028AbZFBPZY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jun 2009 11:25:24 -0400
In-Reply-To: <20090602152351.7346.48697.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

In acpi_pci_bind, we add _PRT information for non-bridge devices, but
we never delete that information in acpi_pci_unbind.

We also set device->ops.bind and device->ops.unbind, but never clear
them out.

Let's make acpi_pci_unbind clean up what we did in acpi_pci_bind.

Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/pci_bind.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 9185b54..c507e37 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -120,14 +120,21 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 
 static int acpi_pci_unbind(struct acpi_device *device)
 {
+	struct pci_bus *bus;
 	struct pci_dev *dev;
 
 	dev = acpi_get_pci_dev(device->handle);
 	if (!dev)
 		return 0;
 
-	if (dev->subordinate)
-		acpi_pci_irq_del_prt(dev->subordinate);
+	if (dev->subordinate) {
+		bus = dev->subordinate;
+		device->ops.bind = NULL;
+		device->ops.unbind = NULL;
+	 } else
+		bus = dev->bus;
+
+	acpi_pci_irq_del_prt(bus);
 
 	return 0;
 }

