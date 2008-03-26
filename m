From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 03/37] PNP: make pnp_add_id() internal to PNP core
Date: Wed, 26 Mar 2008 11:11:01 -0600
Message-ID: <20080326171223.895009251@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:41038 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210AbYCZRIa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:08:30 -0400
Content-Disposition: inline; filename=pnp-make-pnp_add_id-internal-to-core
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

pnp_add_id() doesn't need to be exposed outside the PNP core, so
move the declaration to an internal header file.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/include/linux/pnp.h
===================================================================
--- work7.orig/include/linux/pnp.h	2008-03-21 13:31:06.000000000 -0600
+++ work7/include/linux/pnp.h	2008-03-21 13:31:08.000000000 -0600
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
 
Index: work7/drivers/pnp/base.h
===================================================================
--- work7.orig/drivers/pnp/base.h	2008-03-21 13:31:06.000000000 -0600
+++ work7/drivers/pnp/base.h	2008-03-21 13:31:39.000000000 -0600
@@ -1,5 +1,6 @@
 extern spinlock_t pnp_lock;
 void *pnp_alloc(long size);
+int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_interface_attach_device(struct pnp_dev *dev);
 void pnp_fixup_device(struct pnp_dev *dev);
 void pnp_free_option(struct pnp_option *option);
Index: work7/drivers/pnp/pnpacpi/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/core.c	2008-03-21 13:31:06.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/core.c	2008-03-21 13:31:08.000000000 -0600
@@ -25,6 +25,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/actypes.h>
 
+#include "../base.h"
 #include "pnpacpi.h"
 
 static int num = 0;
Index: work7/drivers/pnp/pnpbios/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpbios/core.c	2008-03-21 13:31:06.000000000 -0600
+++ work7/drivers/pnp/pnpbios/core.c	2008-03-21 13:31:08.000000000 -0600
@@ -69,6 +69,7 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 
+#include "../base.h"
 #include "pnpbios.h"
 
 /*

-- 
