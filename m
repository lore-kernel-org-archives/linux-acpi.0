From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v3 08/12] ACPI: acpi_pci_unbind should clean up properly after
	acpi_pci_bind
Date: Wed, 10 Jun 2009 13:55:45 -0600
Message-ID: <20090610195545.28982.31987.stgit@bob.kio>
References: <20090610194714.28982.51363.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:47578 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761471AbZFJTzn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2009 15:55:43 -0400
In-Reply-To: <20090610194714.28982.51363.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

In acpi_pci_bind, we set device->ops.bind and device->ops.unbind, but
never clear them out.

Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/pci_bind.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 62cb383..a205769 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -109,12 +109,15 @@ static int acpi_pci_unbind(struct acpi_device *device)
 	struct pci_dev *dev;
 
 	dev = acpi_get_pci_dev(device->handle);
-	if (!dev)
-		return 0;
+	if (!dev || !dev->subordinate)
+		goto out;
 
-	if (dev->subordinate)
-		acpi_pci_irq_del_prt(dev->subordinate);
+	acpi_pci_irq_del_prt(dev->subordinate);
+
+	device->ops.bind = NULL;
+	device->ops.unbind = NULL;
 
+out:
 	pci_dev_put(dev);
 	return 0;
 }

