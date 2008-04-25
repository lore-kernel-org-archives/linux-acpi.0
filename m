From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 28/54] PNP: remove pnp_mem_flags() as an lvalue
Date: Fri, 25 Apr 2008 12:38:35 -0600
Message-ID: <20080425183929.810950397@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:9754 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764567AbYDYSkI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:08 -0400
Content-Disposition: inline; filename=pnp-remove-accessor-lvalues
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

A future change will change pnp_mem_flags() from a "#define that
simplifies to an lvalue" to "an inline function that returns the
flags value."

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/quirks.c
===================================================================
--- work10.orig/drivers/pnp/quirks.c	2008-04-25 11:12:16.000000000 -0600
+++ work10/drivers/pnp/quirks.c	2008-04-25 11:15:01.000000000 -0600
@@ -114,6 +114,7 @@
 static void quirk_system_pci_resources(struct pnp_dev *dev)
 {
 	struct pci_dev *pdev = NULL;
+	struct resource *res;
 	resource_size_t pnp_start, pnp_end, pci_start, pci_end;
 	int i, j;
 
@@ -173,7 +174,8 @@
 					pci_name(pdev), i,
 					(unsigned long long) pci_start,
 					(unsigned long long) pci_end);
-				pnp_mem_flags(dev, j) = 0;
+				res = pnp_get_resource(dev, IORESOURCE_MEM, j);
+				res->flags = 0;
 			}
 		}
 	}

-- 
