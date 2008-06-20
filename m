From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/70] PNP: remove pnp_resource.index
Date: Fri, 20 Jun 2008 03:43:42 -0400
Message-ID: <022d064474d04bf9c3fdb8ed04ce4ade800a6dfa.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38101 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYFTHoy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:54 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00D8A46GSHO1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:41 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We used pnp_resource.index to keep track of which ISAPNP configuration
register a resource should be written to.  We needed this only to
handle the case where a register is disabled but a subsequent register
in the same set is enabled.

Rather than explicitly maintaining the pnp_resource.index, this patch
adds a resource every time we read an ISAPNP configuration register
and marks the resource as IORESOURCE_DISABLED when appropriate.  This
makes the position in the pnp_resource_table always correspond to the
config register index.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/base.h        |    1 -
 drivers/pnp/interface.c   |   20 ++--------
 drivers/pnp/isapnp/core.c |   84 +++++++++++++++-----------------------------
 drivers/pnp/manager.c     |    4 --
 4 files changed, 33 insertions(+), 76 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 886dac8..6f60097 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -57,7 +57,6 @@ struct pnp_resource *pnp_get_pnp_resource(struct pnp_dev *dev,
 
 struct pnp_resource {
 	struct resource res;
-	unsigned int index;		/* ISAPNP config register index */
 };
 
 struct pnp_resource_table {
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 5695a79..3f8007a 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -320,7 +320,6 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 			  const char *ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	struct pnp_resource *pnp_res;
 	char *buf = (void *)ubuf;
 	int retval = 0;
 	resource_size_t start, end;
@@ -368,7 +367,6 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 		goto done;
 	}
 	if (!strnicmp(buf, "set", 3)) {
-		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
 		if (dev->active)
 			goto done;
 		buf += 3;
@@ -391,10 +389,7 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 					end = simple_strtoul(buf, &buf, 0);
 				} else
 					end = start;
-				pnp_res = pnp_add_io_resource(dev, start, end,
-							      0);
-				if (pnp_res)
-					pnp_res->index = nport++;
+				pnp_add_io_resource(dev, start, end, 0);
 				continue;
 			}
 			if (!strnicmp(buf, "mem", 3)) {
@@ -411,10 +406,7 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 					end = simple_strtoul(buf, &buf, 0);
 				} else
 					end = start;
-				pnp_res = pnp_add_mem_resource(dev, start, end,
-							       0);
-				if (pnp_res)
-					pnp_res->index = nmem++;
+				pnp_add_mem_resource(dev, start, end, 0);
 				continue;
 			}
 			if (!strnicmp(buf, "irq", 3)) {
@@ -422,9 +414,7 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 				while (isspace(*buf))
 					++buf;
 				start = simple_strtoul(buf, &buf, 0);
-				pnp_res = pnp_add_irq_resource(dev, start, 0);
-				if (pnp_res)
-					pnp_res->index = nirq++;
+				pnp_add_irq_resource(dev, start, 0);
 				continue;
 			}
 			if (!strnicmp(buf, "dma", 3)) {
@@ -432,9 +422,7 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 				while (isspace(*buf))
 					++buf;
 				start = simple_strtoul(buf, &buf, 0);
-				pnp_res = pnp_add_dma_resource(dev, start, 0);
-				if (pnp_res)
-					pnp_res->index = ndma++;
+				pnp_add_dma_resource(dev, start, 0);
 				continue;
 			}
 			break;
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index f1bccdb..752b51f 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -928,7 +928,6 @@ EXPORT_SYMBOL(isapnp_write_byte);
 
 static int isapnp_get_resources(struct pnp_dev *dev)
 {
-	struct pnp_resource *pnp_res;
 	int i, ret;
 
 	dev_dbg(&dev->dev, "get resources\n");
@@ -940,35 +939,23 @@ static int isapnp_get_resources(struct pnp_dev *dev)
 
 	for (i = 0; i < ISAPNP_MAX_PORT; i++) {
 		ret = isapnp_read_word(ISAPNP_CFG_PORT + (i << 1));
-		if (ret) {
-			pnp_res = pnp_add_io_resource(dev, ret, ret, 0);
-			if (pnp_res)
-				pnp_res->index = i;
-		}
+		pnp_add_io_resource(dev, ret, ret,
+				    ret == 0 ? IORESOURCE_DISABLED : 0);
 	}
 	for (i = 0; i < ISAPNP_MAX_MEM; i++) {
 		ret = isapnp_read_word(ISAPNP_CFG_MEM + (i << 3)) << 8;
-		if (ret) {
-			pnp_res = pnp_add_mem_resource(dev, ret, ret, 0);
-			if (pnp_res)
-				pnp_res->index = i;
-		}
+		pnp_add_mem_resource(dev, ret, ret,
+				     ret == 0 ? IORESOURCE_DISABLED : 0);
 	}
 	for (i = 0; i < ISAPNP_MAX_IRQ; i++) {
 		ret = isapnp_read_word(ISAPNP_CFG_IRQ + (i << 1)) >> 8;
-		if (ret) {
-			pnp_res = pnp_add_irq_resource(dev, ret, 0);
-			if (pnp_res)
-				pnp_res->index = i;
-		}
+		pnp_add_irq_resource(dev, ret,
+				     ret == 0 ? IORESOURCE_DISABLED : 0);
 	}
 	for (i = 0; i < ISAPNP_MAX_DMA; i++) {
 		ret = isapnp_read_byte(ISAPNP_CFG_DMA + i);
-		if (ret != 4) {
-			pnp_res = pnp_add_dma_resource(dev, ret, 0);
-			if  (pnp_res)
-				pnp_res->index = i;
-		}
+		pnp_add_dma_resource(dev, ret,
+				     ret == 4 ? IORESOURCE_DISABLED : 0);
 	}
 
 __end:
@@ -978,62 +965,49 @@ __end:
 
 static int isapnp_set_resources(struct pnp_dev *dev)
 {
-	struct pnp_resource *pnp_res;
 	struct resource *res;
-	int tmp, index;
+	int tmp;
 
 	dev_dbg(&dev->dev, "set resources\n");
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
 	for (tmp = 0; tmp < ISAPNP_MAX_PORT; tmp++) {
-		pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_IO, tmp);
-		if (!pnp_res)
-			continue;
-		res = &pnp_res->res;
-		if (pnp_resource_valid(res)) {
-			index = pnp_res->index;
+		res = pnp_get_resource(dev, IORESOURCE_IO, tmp);
+		if (res && pnp_resource_valid(res) &&
+		    !(res->flags & IORESOURCE_DISABLED)) {
 			dev_dbg(&dev->dev, "  set io  %d to %#llx\n",
-				index, (unsigned long long) res->start);
-			isapnp_write_word(ISAPNP_CFG_PORT + (index << 1),
+				tmp, (unsigned long long) res->start);
+			isapnp_write_word(ISAPNP_CFG_PORT + (tmp << 1),
 					  res->start);
 		}
 	}
 	for (tmp = 0; tmp < ISAPNP_MAX_IRQ; tmp++) {
-		pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_IRQ, tmp);
-		if (!pnp_res)
-			continue;
-		res = &pnp_res->res;
-		if (pnp_resource_valid(res)) {
+		res = pnp_get_resource(dev, IORESOURCE_IRQ, tmp);
+		if (res && pnp_resource_valid(res) &&
+		    !(res->flags & IORESOURCE_DISABLED)) {
 			int irq = res->start;
 			if (irq == 2)
 				irq = 9;
-			index = pnp_res->index;
-			dev_dbg(&dev->dev, "  set irq %d to %d\n", index, irq);
-			isapnp_write_byte(ISAPNP_CFG_IRQ + (index << 1), irq);
+			dev_dbg(&dev->dev, "  set irq %d to %d\n", tmp, irq);
+			isapnp_write_byte(ISAPNP_CFG_IRQ + (tmp << 1), irq);
 		}
 	}
 	for (tmp = 0; tmp < ISAPNP_MAX_DMA; tmp++) {
-		pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_DMA, tmp);
-		if (!pnp_res)
-			continue;
-		res = &pnp_res->res;
-		if (pnp_resource_valid(res)) {
-			index = pnp_res->index;
+		res = pnp_get_resource(dev, IORESOURCE_DMA, tmp);
+		if (res && pnp_resource_valid(res) &&
+		    !(res->flags & IORESOURCE_DISABLED)) {
 			dev_dbg(&dev->dev, "  set dma %d to %lld\n",
-				index, (unsigned long long) res->start);
-			isapnp_write_byte(ISAPNP_CFG_DMA + index, res->start);
+				tmp, (unsigned long long) res->start);
+			isapnp_write_byte(ISAPNP_CFG_DMA + tmp, res->start);
 		}
 	}
 	for (tmp = 0; tmp < ISAPNP_MAX_MEM; tmp++) {
-		pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_MEM, tmp);
-		if (!pnp_res)
-			continue;
-		res = &pnp_res->res;
-		if (pnp_resource_valid(res)) {
-			index = pnp_res->index;
+		res = pnp_get_resource(dev, IORESOURCE_MEM, tmp);
+		if (res && pnp_resource_valid(res) &&
+		    !(res->flags & IORESOURCE_DISABLED)) {
 			dev_dbg(&dev->dev, "  set mem %d to %#llx\n",
-				index, (unsigned long long) res->start);
-			isapnp_write_word(ISAPNP_CFG_MEM + (index << 3),
+				tmp, (unsigned long long) res->start);
+			isapnp_write_word(ISAPNP_CFG_MEM + (tmp << 3),
 					  (res->start >> 8) & 0xffff);
 		}
 	}
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index bea0914..90bd9cb 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -40,7 +40,6 @@ static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 	}
 
 	/* set the initial values */
-	pnp_res->index = idx;
 	res->flags |= rule->flags | IORESOURCE_IO;
 	res->flags &= ~IORESOURCE_UNSET;
 
@@ -90,7 +89,6 @@ static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 	}
 
 	/* set the initial values */
-	pnp_res->index = idx;
 	res->flags |= rule->flags | IORESOURCE_MEM;
 	res->flags &= ~IORESOURCE_UNSET;
 
@@ -155,7 +153,6 @@ static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 	}
 
 	/* set the initial values */
-	pnp_res->index = idx;
 	res->flags |= rule->flags | IORESOURCE_IRQ;
 	res->flags &= ~IORESOURCE_UNSET;
 
@@ -214,7 +211,6 @@ static void pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 	}
 
 	/* set the initial values */
-	pnp_res->index = idx;
 	res->flags |= rule->flags | IORESOURCE_DMA;
 	res->flags &= ~IORESOURCE_UNSET;
 
-- 
1.5.6

