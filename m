From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 1/8] PNP: set IRQ index in sysfs "set irq" interface
Date: Mon, 05 May 2008 16:36:31 -0600
Message-ID: <20080505223958.851331042@ldl.fc.hp.com>
References: <20080505223630.682082986@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:19927 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760629AbYEEWj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2008 18:39:58 -0400
Content-Disposition: inline; filename=pnp-interface-fixup
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

We have to set the ISAPNP register index when setting an IRQ via
the sysfs interface.  We already do it for IO, MEM, and DMA
resources; I just missed the IRQ one.

This should be in 2.6.26.

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

-- 
