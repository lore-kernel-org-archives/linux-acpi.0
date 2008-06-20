From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/70] PNP: add pnp_resource_type_name() helper function
Date: Fri, 20 Jun 2008 03:43:44 -0400
Message-ID: <b83e0be41886567746d61968cfa6f0e9e98c218d.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40470 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYFTHor (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:47 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00ERW46H1JO2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:41 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a "pnp_resource_type_name(struct resource *)" that
returns the string resource type.  This will be used by the sysfs
"show resources" function and the debug resource dump function.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/base.h    |    1 +
 drivers/pnp/support.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 4c2a625..c913158 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -43,6 +43,7 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res);
 int pnp_check_irq(struct pnp_dev *dev, struct resource *res);
 int pnp_check_dma(struct pnp_dev *dev, struct resource *res);
 
+char *pnp_resource_type_name(struct resource *res);
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc);
 
 void pnp_init_resource(struct resource *res);
diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
index 7f594cc..eb07345 100644
--- a/drivers/pnp/support.c
+++ b/drivers/pnp/support.c
@@ -52,6 +52,21 @@ void pnp_eisa_id_to_string(u32 id, char *str)
 	str[7] = '\0';
 }
 
+char *pnp_resource_type_name(struct resource *res)
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
+
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 {
 #ifdef DEBUG
-- 
1.5.6

