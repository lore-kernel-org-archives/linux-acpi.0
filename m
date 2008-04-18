From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 53/53] PNP: dont sort by type in /sys/.../resources
Date: Fri, 18 Apr 2008 14:50:48 -0600
Message-ID: <20080418205057.946054260@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763434AbYDRVOl@vger.kernel.org>
Content-Disposition: inline; filename=pnp-unsort-proc-resources
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Rather than stepping through all IO resources, then stepping through
all MMIO resources, etc. (and traversing the list every time), we
can just iterate over the resource list once directly.

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
just lists them in the order we found them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/interface.c
===================================================================
--- work8.orig/drivers/pnp/interface.c	2008-04-18 11:22:35.000000000 -0600
+++ work8/drivers/pnp/interface.c	2008-04-18 11:52:53.000000000 -0600
@@ -243,16 +243,30 @@
 
 static DEVICE_ATTR(options, S_IRUGO, pnp_show_options, NULL);
 
-#define set(flags)      ((flags & IORESOURCE_UNSET) == 0)
+static char *pnp_resource_type_name(struct resource *res)
+{
+	switch (pnp_resource_type(res)) {
+	case IORESOURCE_IO:
+		return "io";
+	case IORESOURCE_MEM:
+		return "mem";
+	case IORESOURCE_IRQ:
+		return "irq";
+	case IORESOURCE_DMA:
+		return "dma";
+	}
+	return NULL;
+}
 
 static ssize_t pnp_show_current_resources(struct device *dmdev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_resource *pnp_res;
 	struct resource *res;
-	int i, ret;
 	pnp_info_buffer_t *buffer;
+	int ret;
 
 	if (!dev)
 		return -EINVAL;
@@ -264,54 +278,36 @@
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
 
-	pnp_printf(buffer, "state = ");
-	if (dev->active)
-		pnp_printf(buffer, "active\n");
-	else
-		pnp_printf(buffer, "disabled\n");
-
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
-		if (set(res->flags)) {
-			pnp_printf(buffer, "io");
-			if (res->flags & IORESOURCE_DISABLED)
-				pnp_printf(buffer, " disabled\n");
-			else
-				pnp_printf(buffer, " 0x%llx-0x%llx\n",
-					   (unsigned long long) res->start,
-					   (unsigned long long) res->end);
-		}
-	}
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_MEM, i)); i++) {
-		if (set(res->flags)) {
-			pnp_printf(buffer, "mem");
-			if (res->flags & IORESOURCE_DISABLED)
-				pnp_printf(buffer, " disabled\n");
-			else
-				pnp_printf(buffer, " 0x%llx-0x%llx\n",
-					   (unsigned long long) res->start,
-					   (unsigned long long) res->end);
-		}
-	}
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IRQ, i)); i++) {
-		if (set(res->flags)) {
-			pnp_printf(buffer, "irq");
-			if (res->flags & IORESOURCE_DISABLED)
-				pnp_printf(buffer, " disabled\n");
-			else
-				pnp_printf(buffer, " %lld\n",
-					   (unsigned long long) res->start);
+	pnp_printf(buffer, "state = %s\n", dev->active ? "active" : "disabled");
+
+	list_for_each_entry(pnp_res, &dev->resources, list) {
+		res = &pnp_res->res;
+		if (res->flags & IORESOURCE_UNSET)
+			continue;
+
+		pnp_printf(buffer, pnp_resource_type_name(res));
+
+		if (res->flags & IORESOURCE_DISABLED) {
+			pnp_printf(buffer, " disabled\n");
+			continue;
 		}
-	}
-	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_DMA, i)); i++) {
-		if (set(res->flags)) {
-			pnp_printf(buffer, "dma");
-			if (res->flags & IORESOURCE_DISABLED)
-				pnp_printf(buffer, " disabled\n");
-			else
-				pnp_printf(buffer, " %lld\n",
-					   (unsigned long long) res->start);
+
+		switch (pnp_resource_type(res)) {
+		case IORESOURCE_IO:
+		case IORESOURCE_MEM:
+			pnp_printf(buffer, " 0x%llx-0x%llx\n",
+				   (unsigned long long) res->start,
+				   (unsigned long long) res->end);
+			break;
+		case IORESOURCE_IRQ:
+		case IORESOURCE_DMA:
+			pnp_printf(buffer, " %lld\n",
+				   (unsigned long long) res->start);
+			break;
 		}
+
 	}
+
 	ret = (buffer->curr - buf);
 	kfree(buffer);
 	return ret;

-- 
