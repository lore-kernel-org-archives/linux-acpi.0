From: Len Brown <lenb@kernel.org>
Subject: [PATCH 58/84] PNP: add pnp_resource_type() internal interface
Date: Sat, 28 Jun 2008 01:44:02 -0400
Message-ID: <1e37ae3999afb7e6b713c95cbc0ddc5c4e277333.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50650 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbYF1Fph (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:37 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500GPDRZRIGI4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:28 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Given a struct resource, this returns the type (IO, MEM, IRQ, DMA).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/base.h     |    1 +
 drivers/pnp/resource.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 6f60097..4c2a625 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -46,6 +46,7 @@ int pnp_check_dma(struct pnp_dev *dev, struct resource *res);
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc);
 
 void pnp_init_resource(struct resource *res);
+int pnp_resource_type(struct resource *res);
 
 struct pnp_resource *pnp_get_pnp_resource(struct pnp_dev *dev,
 					  unsigned int type, unsigned int num);
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 390b500..cce341f 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -499,6 +499,12 @@ int pnp_check_dma(struct pnp_dev *dev, struct resource *res)
 #endif
 }
 
+int pnp_resource_type(struct resource *res)
+{
+	return res->flags & (IORESOURCE_IO  | IORESOURCE_MEM |
+			     IORESOURCE_IRQ | IORESOURCE_DMA);
+}
+
 struct pnp_resource *pnp_get_pnp_resource(struct pnp_dev *dev,
 					  unsigned int type, unsigned int num)
 {
-- 
1.5.6.1.89.gd544

