From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 5/6] PNP: remove MODULE infrastructure
Date: Wed, 15 Aug 2007 10:32:12 -0600
Message-ID: <20070815163432.953074179@ldl.fc.hp.com>
References: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:51584 "EHLO
	tayrelbas04.tay.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbXHOQx6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Aug 2007 12:53:58 -0400
Content-Disposition: inline; filename=pnp-remove-unused-module-stuff
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

We don't support building any part of PNP as a module (*drivers* can be
modules, of course, but the PNP infrastructure itself can not).  Since
MODULE will never be defined, remove the ifdefs and dead code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/pnpbios/core.c
===================================================================
--- w.orig/drivers/pnp/pnpbios/core.c	2007-08-14 10:36:03.000000000 -0600
+++ w/drivers/pnp/pnpbios/core.c	2007-08-14 10:37:28.000000000 -0600
@@ -419,7 +419,6 @@
 static int pnpbios_disabled;
 int pnpbios_dont_use_current_config;
 
-#ifndef MODULE
 static int __init pnpbios_setup(char *str)
 {
 	int invert;
@@ -443,7 +442,6 @@
 }
 
 __setup("pnpbios=", pnpbios_setup);
-#endif
 
 /* PnP BIOS signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
@@ -607,48 +605,7 @@
 	return 0;
 }
 
-#ifndef MODULE
-
-/* init/main.c calls pnpbios_init early */
-
 /* Start the kernel thread later: */
 module_init(pnpbios_thread_init);
 
-#else
-
-/*
- * N.B.: Building pnpbios as a module hasn't been fully implemented
- */
-
-MODULE_LICENSE("GPL");
-
-static int __init pnpbios_init_all(void)
-{
-	int r;
-
-	r = pnpbios_init();
-	if (r)
-		return r;
-	r = pnpbios_thread_init();
-	if (r)
-		return r;
-	return 0;
-}
-
-static void __exit pnpbios_exit(void)
-{
-#ifdef CONFIG_HOTPLUG
-	unloading = 1;
-	wait_for_completion(&unload_sem);
-#endif
-	pnpbios_proc_exit();
-	/* We ought to free resources here */
-	return;
-}
-
-module_init(pnpbios_init_all);
-module_exit(pnpbios_exit);
-
-#endif
-
 EXPORT_SYMBOL(pnpbios_protocol);
Index: w/drivers/pnp/isapnp/proc.c
===================================================================
--- w.orig/drivers/pnp/isapnp/proc.c	2007-08-14 10:38:56.000000000 -0600
+++ w/drivers/pnp/isapnp/proc.c	2007-08-14 10:39:12.000000000 -0600
@@ -112,33 +112,6 @@
 	return 0;
 }
 
-#ifdef MODULE
-static int __exit isapnp_proc_detach_device(struct pnp_dev *dev)
-{
-	struct pnp_card *bus = dev->card;
-	struct proc_dir_entry *de;
-	char name[16];
-
-	if (!(de = bus->procdir))
-		return -EINVAL;
-	sprintf(name, "%02x", dev->number);
-	remove_proc_entry(name, de);
-	return 0;
-}
-
-static int __exit isapnp_proc_detach_bus(struct pnp_card *bus)
-{
-	struct proc_dir_entry *de;
-	char name[16];
-
-	if (!(de = bus->procdir))
-		return -EINVAL;
-	sprintf(name, "%02x", bus->number);
-	remove_proc_entry(name, isapnp_proc_bus_dir);
-	return 0;
-}
-#endif				/* MODULE */
-
 int __init isapnp_proc_init(void)
 {
 	struct pnp_dev *dev;
@@ -149,21 +122,3 @@
 	}
 	return 0;
 }
-
-#ifdef MODULE
-int __exit isapnp_proc_done(void)
-{
-	struct pnp_dev *dev;
-	struct pnp_bus *card;
-
-	isapnp_for_each_dev(dev) {
-		isapnp_proc_detach_device(dev);
-	}
-	isapnp_for_each_card(card) {
-		isapnp_proc_detach_bus(card);
-	}
-	if (isapnp_proc_bus_dir)
-		remove_proc_entry("isapnp", proc_bus);
-	return 0;
-}
-#endif				/* MODULE */

--
