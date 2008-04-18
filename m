From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 01/53] ISAPNP: move config register addresses out of isapnp.h
Date: Fri, 18 Apr 2008 14:49:56 -0600
Message-ID: <20080418205047.236350695@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761426AbYDRUwr@vger.kernel.org>
Content-Disposition: inline; filename=isapnp-remove-register-addrs-from-header
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

These are used only in drivers/pnp/isapnp/core.c, so no need to
expose them to the world.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work7/drivers/pnp/isapnp/core.c
===================================================================
--- work7.orig/drivers/pnp/isapnp/core.c	2008-03-21 11:52:12.000000000 -0600
+++ work7/drivers/pnp/isapnp/core.c	2008-03-21 11:53:24.000000000 -0600
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
Index: work7/include/linux/isapnp.h
===================================================================
--- work7.orig/include/linux/isapnp.h	2008-03-21 11:45:41.000000000 -0600
+++ work7/include/linux/isapnp.h	2008-03-21 11:52:39.000000000 -0600
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
