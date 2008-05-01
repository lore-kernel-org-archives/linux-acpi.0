From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: PNP: set IRQ index in sysfs "set irq" interface
Date: Thu, 1 May 2008 15:39:57 -0600
Message-ID: <200805011539.58705.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:17799 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761482AbYEAVkT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 May 2008 17:40:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

We have to set the ISAPNP register index when setting an IRQ via
the sysfs interface.  We already do it for IO, MEM, and DMA
resources; I just missed the IRQ one.

This needs to be in 2.6.26.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/interface.c
===================================================================
--- work10.orig/drivers/pnp/interface.c	2008-05-01 15:26:28.000000000 -0600
+++ work10/drivers/pnp/interface.c	2008-05-01 15:26:39.000000000 -0600
@@ -424,7 +424,7 @@
 				start = simple_strtoul(buf, &buf, 0);
 				pnp_res = pnp_add_irq_resource(dev, start, 0);
 				if (pnp_res)
-					nirq++;
+					pnp_res->index = nirq++;
 				continue;
 			}
 			if (!strnicmp(buf, "dma", 3)) {
