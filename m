From: Len Brown <len.brown@intel.com>
Subject: [PATCH 22/25] PNP: remove MODULE infrastructure
Date: Fri, 24 Aug 2007 03:21:09 -0400
Message-ID: <11879400984017-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
 <1187940094867-git-send-email-len.brown@intel.com>
 <11879400951708-git-send-email-len.brown@intel.com>
 <11879400963954-git-send-email-len.brown@intel.com>
 <11879400972603-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23132 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763584AbXHXHVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:40 -0400
In-Reply-To: <11879400972603-git-send-email-len.brown@intel.com>
Message-Id: <4f0217e30249ac0eb13b65ef64f2aee627465da2.1187939443.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We don't support building any part of PNP as a module (*drivers* can be
modules, of course, but the PNP infrastructure itself can not).  Since
MODULE will never be defined, remove the ifdefs and dead code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Adam Belay <abelay@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/isapnp/proc.c  |   45 --------------------------------------------
 drivers/pnp/pnpbios/core.c |   43 ------------------------------------------
 2 files changed, 0 insertions(+), 88 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index 3fbc0f9..560ccb6 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -112,33 +112,6 @@ static int isapnp_proc_attach_device(struct pnp_dev *dev)
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
@@ -149,21 +122,3 @@ int __init isapnp_proc_init(void)
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
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 9892a6a..0691f47 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -419,7 +419,6 @@ static void __init build_devlist(void)
 static int pnpbios_disabled;
 int pnpbios_dont_use_current_config;
 
-#ifndef MODULE
 static int __init pnpbios_setup(char *str)
 {
 	int invert;
@@ -443,7 +442,6 @@ static int __init pnpbios_setup(char *str)
 }
 
 __setup("pnpbios=", pnpbios_setup);
-#endif
 
 /* PnP BIOS signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
@@ -607,48 +605,7 @@ static int __init pnpbios_thread_init(void)
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
-- 
1.5.3.rc6.17.g1911
