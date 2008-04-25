From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 04/54] PNP: make pnp_add_id() internal to PNP core
Date: Fri, 25 Apr 2008 12:38:11 -0600
Message-ID: <20080425183924.906236921@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:9664 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbYDYSja (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:39:30 -0400
Content-Disposition: inline; filename=pnp-make-pnp_add_id-internal-to-core
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

pnp_add_id() doesn't need to be exposed outside the PNP core, so
move the declaration to an internal header file.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/include/linux/pnp.h
===================================================================
--- work10.orig/include/linux/pnp.h	2008-04-25 11:12:17.000000000 -0600
+++ work10/include/linux/pnp.h	2008-04-25 11:14:45.000000000 -0600
@@ -403,7 +403,6 @@
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev *dev);
 int compare_pnp_id(struct pnp_id *pos, const char *id);
-int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
 
@@ -450,7 +449,6 @@
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev *dev) { return 0; }
 static inline int compare_pnp_id(struct pnp_id *pos, const char *id) { return -ENODEV; }
-static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 
Index: work10/drivers/pnp/base.h
===================================================================
--- work10.orig/drivers/pnp/base.h	2008-04-25 11:12:17.000000000 -0600
+++ work10/drivers/pnp/base.h	2008-04-25 11:14:45.000000000 -0600
@@ -1,5 +1,6 @@
 extern spinlock_t pnp_lock;
 void *pnp_alloc(long size);
+int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_interface_attach_device(struct pnp_dev *dev);
 void pnp_fixup_device(struct pnp_dev *dev);
 void pnp_free_option(struct pnp_option *option);
Index: work10/drivers/pnp/pnpacpi/core.c
===================================================================
--- work10.orig/drivers/pnp/pnpacpi/core.c	2008-04-25 11:14:44.000000000 -0600
+++ work10/drivers/pnp/pnpacpi/core.c	2008-04-25 11:14:45.000000000 -0600
@@ -25,6 +25,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/actypes.h>
 
+#include "../base.h"
 #include "pnpacpi.h"
 
 static int num = 0;
Index: work10/drivers/pnp/pnpbios/core.c
===================================================================
--- work10.orig/drivers/pnp/pnpbios/core.c	2008-04-25 11:12:17.000000000 -0600
+++ work10/drivers/pnp/pnpbios/core.c	2008-04-25 11:14:45.000000000 -0600
@@ -69,6 +69,7 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 
+#include "../base.h"
 #include "pnpbios.h"
 
 /*

-- 
