From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNP: log PNP resources, as we do for PCI
Date: Wed, 29 Sep 2010 12:24:23 -0600
Message-ID: <201009291224.23326.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:4685 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0I2SZS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 14:25:18 -0400
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g1t0026.austin.hp.com (Postfix) with ESMTP id 14416C42D
	for <linux-acpi@vger.kernel.org>; Wed, 29 Sep 2010 18:25:18 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I fat-fingered the linux-acpi address, sorry.

----------  Forwarded Message  ----------

Subject: [PATCH] PNP: log PNP resources, as we do for PCI
Date: Wednesday, September 29, 2010, 12:23:58 pm
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
CC: linux-acpi@kernel.org, Adam Belay <abelay@mit.edu>


ACPI devices are often involved in address space conflicts with PCI devices,
so I think it's worth logging the resources they use.  Otherwise we have to
depend on lspnp or groping around in sysfs to find them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pnp/core.c     |    5 +++--
 drivers/pnp/resource.c |   10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)


diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 88b3cde..53a8f33 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -194,8 +194,9 @@ int pnp_add_device(struct pnp_dev *dev)
 	for (id = dev->id; id; id = id->next)
 		len += scnprintf(buf + len, sizeof(buf) - len, " %s", id->id);
 
-	pnp_dbg(&dev->dev, "%s device, IDs%s (%s)\n",
-		dev->protocol->name, buf, dev->active ? "active" : "disabled");
+	dev_printk(KERN_DEBUG, &dev->dev, "%s device, IDs%s (%s)\n",
+		   dev->protocol->name, buf,
+		   dev->active ? "active" : "disabled");
 	return 0;
 }
 
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index e3446ab..a925e6b 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -523,7 +523,7 @@ struct pnp_resource *pnp_add_irq_resource(struct pnp_dev *dev, int irq,
 	res->start = irq;
 	res->end = irq;
 
-	pnp_dbg(&dev->dev, "  add %pr\n", res);
+	dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
 	return pnp_res;
 }
 
@@ -544,7 +544,7 @@ struct pnp_resource *pnp_add_dma_resource(struct pnp_dev *dev, int dma,
 	res->start = dma;
 	res->end = dma;
 
-	pnp_dbg(&dev->dev, "  add %pr\n", res);
+	dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
 	return pnp_res;
 }
 
@@ -568,7 +568,7 @@ struct pnp_resource *pnp_add_io_resource(struct pnp_dev *dev,
 	res->start = start;
 	res->end = end;
 
-	pnp_dbg(&dev->dev, "  add %pr\n", res);
+	dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
 	return pnp_res;
 }
 
@@ -592,7 +592,7 @@ struct pnp_resource *pnp_add_mem_resource(struct pnp_dev *dev,
 	res->start = start;
 	res->end = end;
 
-	pnp_dbg(&dev->dev, "  add %pr\n", res);
+	dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
 	return pnp_res;
 }
 
@@ -616,7 +616,7 @@ struct pnp_resource *pnp_add_bus_resource(struct pnp_dev *dev,
 	res->start = start;
 	res->end = end;
 
-	pnp_dbg(&dev->dev, "  add %pr\n", res);
+	dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
 	return pnp_res;
 }
 


-----------------------------------------
