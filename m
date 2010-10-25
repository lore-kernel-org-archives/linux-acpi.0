From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/60] PNP: log PNP resources, as we do for PCI
Date: Mon, 25 Oct 2010 02:20:23 -0400
Message-ID: <c1f3f2819667a238585c65bba96c8b16af39a442.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:10 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:09 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI devices are often involved in address space conflicts with PCI devices,
so I think it's worth logging the resources they use.  Otherwise we have to
depend on lspnp or groping around in sysfs to find them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
 
-- 
1.7.3.2.90.gd4c43

