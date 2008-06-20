From: Len Brown <lenb@kernel.org>
Subject: [PATCH 47/70] PNP: dont sort by type in /sys/.../resources
Date: Fri, 20 Jun 2008 03:43:49 -0400
Message-ID: <342ab1e0f604477373fcfe9459cb3236203bf5e3.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:35177 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbYFTHot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:49 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00I8Q46J75H1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:44 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Rather than stepping through all IO resources, then stepping through
all MMIO resources, etc., we can just iterate over the resource list
once directly.

This can change the order in /sys, e.g.,

    # cat /sys/devices/pnp0/00:07/resources     # OLD
    state = active
    io 0x3f8-0x3ff
    irq 4

    # cat /sys/devices/pnp0/00:07/resources     # NEW
    state = active
    irq 4
    io 0x3f8-0x3ff

The old code artificially sorted resources by type; the new code
just lists them in the order we read them from the ISAPNP hardware
or the BIOS.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/interface.c |   56 ++++++++++++++++++----------------------------
 1 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 7fc86bb..674e8ba 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -248,8 +248,9 @@ static ssize_t pnp_show_current_resources(struct device *dmdev,
 					  char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_resource *pnp_res;
 	struct resource *res;
-	int i, ret;
+	int ret;
 	pnp_info_buffer_t *buffer;
 
 	if (!dev)
@@ -262,46 +263,33 @@ static ssize_t pnp_show_current_resources(struct device *dmdev,
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
 
-	pnp_printf(buffer, "state = ");
-	if (dev->active)
-		pnp_printf(buffer, "active\n");
-	else
-		pnp_printf(buffer, "disabled\n");
+	pnp_printf(buffer, "state = %s\n", dev->active ? "active" : "disabled");
 
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
-		pnp_printf(buffer, "io");
-		if (res->flags & IORESOURCE_DISABLED)
-			pnp_printf(buffer, " disabled\n");
-		else
-			pnp_printf(buffer, " 0x%llx-0x%llx\n",
-				   (unsigned long long) res->start,
-				   (unsigned long long) res->end);
-	}
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_MEM, i)); i++) {
-		pnp_printf(buffer, "mem");
-		if (res->flags & IORESOURCE_DISABLED)
+	list_for_each_entry(pnp_res, &dev->resources, list) {
+		res = &pnp_res->res;
+
+		pnp_printf(buffer, pnp_resource_type_name(res));
+
+		if (res->flags & IORESOURCE_DISABLED) {
 			pnp_printf(buffer, " disabled\n");
-		else
-			pnp_printf(buffer, " 0x%llx-0x%llx\n",
+			continue;
+		}
+
+		switch (pnp_resource_type(res)) {
+		case IORESOURCE_IO:
+		case IORESOURCE_MEM:
+			pnp_printf(buffer, " %#llx-%#llx\n",
 				   (unsigned long long) res->start,
 				   (unsigned long long) res->end);
-	}
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IRQ, i)); i++) {
-		pnp_printf(buffer, "irq");
-		if (res->flags & IORESOURCE_DISABLED)
-			pnp_printf(buffer, " disabled\n");
-		else
-			pnp_printf(buffer, " %lld\n",
-				   (unsigned long long) res->start);
-	}
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_DMA, i)); i++) {
-		pnp_printf(buffer, "dma");
-		if (res->flags & IORESOURCE_DISABLED)
-			pnp_printf(buffer, " disabled\n");
-		else
+			break;
+		case IORESOURCE_IRQ:
+		case IORESOURCE_DMA:
 			pnp_printf(buffer, " %lld\n",
 				   (unsigned long long) res->start);
+			break;
+		}
 	}
+
 	ret = (buffer->curr - buf);
 	kfree(buffer);
 	return ret;
-- 
1.5.6

