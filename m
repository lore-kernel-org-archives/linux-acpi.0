From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 02/55] ISAPNP: move config register addresses out of isapnp.h
Date: Mon, 28 Apr 2008 16:33:49 -0600
Message-ID: <20080428223616.791330438@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:36743 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbYD1WgY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:36:24 -0400
Content-Disposition: inline; filename=isapnp-remove-register-addrs-from-header
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

These are used only in drivers/pnp/isapnp/core.c, so no need to
expose them to the world.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/isapnp/core.c
===================================================================
--- work10.orig/drivers/pnp/isapnp/core.c	2008-04-28 15:57:04.000000000 -0600
+++ work10/drivers/pnp/isapnp/core.c	2008-04-28 16:09:07.000000000 -0600
@@ -88,6 +88,14 @@
 #define _LTAG_MEM32RANGE	0x85
 #define _LTAG_FIXEDMEM32RANGE	0x86
 
+/* Logical device control and configuration registers */
+
+#define ISAPNP_CFG_ACTIVATE	0x30	/* byte */
+#define ISAPNP_CFG_MEM		0x40	/* 4 * dword */
+#define ISAPNP_CFG_PORT		0x60	/* 8 * word */
+#define ISAPNP_CFG_IRQ		0x70	/* 2 * word */
+#define ISAPNP_CFG_DMA		0x74	/* 2 * byte */
+
 /*
  * Sizes of ISAPNP logical device configuration register sets.
  * See PNP-ISA-v1.0a.pdf, Appendix A.
Index: work10/include/linux/isapnp.h
===================================================================
--- work10.orig/include/linux/isapnp.h	2008-04-28 15:57:04.000000000 -0600
+++ work10/include/linux/isapnp.h	2008-04-28 16:09:07.000000000 -0600
@@ -26,16 +26,6 @@
 #include <linux/pnp.h>
 
 /*
- *  Configuration registers (TODO: change by specification)
- */ 
-
-#define ISAPNP_CFG_ACTIVATE		0x30	/* byte */
-#define ISAPNP_CFG_MEM			0x40	/* 4 * dword */
-#define ISAPNP_CFG_PORT			0x60	/* 8 * word */
-#define ISAPNP_CFG_IRQ			0x70	/* 2 * word */
-#define ISAPNP_CFG_DMA			0x74	/* 2 * byte */
-
-/*
  *
  */
 

-- 
