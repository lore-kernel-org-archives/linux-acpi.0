From: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Subject: Re: linux pnp layer
Date: Tue, 15 Oct 2002 20:08:35 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021015200834.GF315@neo.rr.com>
References: <20021016010956.A1010@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XOIedfhf+7KOe/yw"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021016010956.A1010-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2002 at 01:09:56AM +0200, Dominik Brodowski wrote:
> Have you got any feedback on your pnp-layer-rewrite yet? I just tried to

Yes, and it has been positive and I have made a few changes that were suggested.

Here's a list:

The following are changes between versions 0.6 and 0.7:
1.)  Added PnP Support Debugging option
2.)  Cleanups for isapnp and pnpbios protocols
3.)  Added a global matching function for use by driver, names, quirks, and
compat
4.)  Added PnP Quirks
5.)  added several more names to the pnp name database
6.)  converted the opl3sa2 driver
7.)  converted the parport_pc driver
8.)  fixed potential bugs when PnP Support is not compiled
9.)  added pnp_alloc for memory allocation
10.) fixed a bug in the interface in which the string "INDEPENDENT:" was
displayed even when it was not needed
11.) made the function portion of matching case insensitive
12.) added compatibility functions to make it easier to convert drivers that use
the old isapnp APIs, drivers that are not converted will still compile but will
not use PnP.
13.) fixed a bug in the isapnp protocol that was the result of an incorrect sync
with 2.4.41.
14.) changed defconfig to reflect the new PnP options

The following are changes between versions 0.7 and 0.8:
1.) added isapnp lowlevel proc, should have never removed this - Thanks to
Jaroslav for pointing this out
2.) added more ids - from Thomas
3.) removed __PNP__, use CONFIG_PNP now - thanks to Greg for pointing this out.
4.) reserve system resources is no longer a compile time option because there
isn't a reason not to use it.
5.) device id cleanups
6.) disabled compile as module for pnp support, pnp support and all of its
protocols currently cannot be compiled as a module.  Eventually this may change,
but is there any reason to compile them as a module anyway?  I think it makes
more sense not to becuase most of this is needed at boot time.
7.) added some comments, more documentation is coming.

> download v0.6 - 2.5.40 from the mailing list archives at
> marc.theaimsgroup.com, but somehow it doesn't arrive here :-(

You may not be recieving it becuase of its size.  Some archives filter out large
messages.  A copy of the latest version, 0.8, is attached.  It's against 2.5.42.
If you test it be sure to enable both protocols and pnp debug.

As you suggested, I'll forward this to Andrew Grover and the ACPI mailing list.

I'm interested in your comments.

Thanks,
Adam

--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pnp8-2.5.42.patch"

diff -ur --new-file --exclude *.flags a/CREDITS b/CREDITS
--- a/CREDITS	Tue Oct 15 17:31:31 2002
+++ b/CREDITS	Tue Oct  8 17:17:58 2002
@@ -1750,6 +1750,11 @@
 S: 370 01  Ceske Budejovice
 S: Czech Republic
 
+N: Adam Belay
+E: ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
+D: Linux Plug and Play Support
+S: USA
+
 N: Bas Laarhoven
 E: sjml-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
 D: Loadable modules and ftape driver
diff -ur --new-file --exclude *.flags a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Oct 15 17:31:31 2002
+++ b/MAINTAINERS	Mon Oct 14 11:36:52 2002
@@ -1293,11 +1293,8 @@
 S:	Maintained
 
 PNP SUPPORT
-P:	Tom Lees
-M:	tom-jMAA5W8IFouX/4koqx8SDw@public.gmane.org
-L:	pnp-users-CBrNMnQbISzi2XTo7cV4XPXRex20P6io@public.gmane.org
-L:	pnp-devel-CBrNMnQbISzi2XTo7cV4XPXRex20P6io@public.gmane.org
-W:	http://www-jcr.lmh.ox.ac.uk/~pnp/
+P:	Adam Belay
+M:	ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
 S:	Maintained
 
 PPP PROTOCOL DRIVERS AND COMPRESSORS
diff -ur --new-file --exclude *.flags a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	Tue Oct 15 17:31:31 2002
+++ b/arch/i386/defconfig	Mon Oct 14 12:26:41 2002
@@ -176,8 +176,11 @@
 # Plug and Play configuration
 #
 CONFIG_PNP=y
+CONFIG_PNP_NAMES=y
+CONFIG_PNP_SYSTEM=y
+# CONFIG_PNP_DEBUG is not set
 CONFIG_ISAPNP=y
-# CONFIG_PNPBIOS is not set
+CONFIG_PNPBIOS=y
 
 #
 # Block devices
diff -ur --new-file --exclude *.flags a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	Tue Oct 15 17:31:31 2002
+++ b/drivers/parport/parport_pc.c	Tue Oct 15 17:10:08 2002
@@ -52,6 +52,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/pnp.h>
 #include <linux/sysctl.h>
 
 #include <asm/io.h>
@@ -2939,9 +2940,9 @@
 }
 
 static struct pci_driver parport_pc_pci_driver = {
-	name:		"parport_pc",
-	id_table:	parport_pc_pci_tbl,
-	probe:		parport_pc_pci_probe,
+	.name		= "parport_pc",
+	.id_table	= parport_pc_pci_tbl,
+	.probe		= parport_pc_pci_probe,
 };
 
 static int __init parport_pc_init_superio (int autoirq, int autodma)
@@ -2968,6 +2969,25 @@
 static int __init parport_pc_init_superio(int autoirq, int autodma) {return 0;}
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_PNP
+static const struct pnp_id pnp_dev_table[] = {
+	/* Standard LPT Printer Port */
+	{.id = "PNP0400", .driver_data = 0},
+	/* ECP Printer Port */
+	{.id = "PNP0401", .driver_data = 0},
+	{.id = ""}
+};
+
+/* we only need the pnp layer to activate the device, at least for now */
+static struct pnp_driver parport_pc_pnp_driver = {
+	.name		= "parport_pc",
+	.card_id_table	= NULL,
+	.id_table	= pnp_dev_table,
+};
+#else
+static const struct pnp_driver parport_pc_pnp_driver;
+#endif
+
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
 static int __init __attribute__((unused))
 parport_pc_find_isa_ports (int autoirq, int autodma)
@@ -3020,6 +3040,8 @@
 
 int __init parport_pc_init (int *io, int *io_hi, int *irq, int *dma)
 {
+	/* try to activate any PnP parports first */
+	pnp_register_driver(&parport_pc_pnp_driver);
 	int count = 0, i = 0;
 
 	if (io && *io) {
@@ -3133,5 +3155,6 @@
 
 		p = tmp;
 	}
+	pnp_unregister_driver (&parport_pc_pnp_driver);
 }
 #endif
diff -ur --new-file --exclude *.flags a/drivers/pnp/Config.help b/drivers/pnp/Config.help
--- a/drivers/pnp/Config.help	Tue Oct 15 17:31:31 2002
+++ b/drivers/pnp/Config.help	Tue Oct 15 15:37:08 2002
@@ -6,15 +6,22 @@
   or using a user-space utility.
 
   Say Y here if you would like Linux to configure your Plug and Play
-  devices. You should then also say Y to "ISA Plug and Play support",
-  below. Alternatively, you can say N here and configure your PnP
-  devices using the user space utilities contained in the isapnptools
-  package.
-
-  This support is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.
+  devices. You should then also say Y to all of the protocols below.
+  Alternatively, you can say N here and configure your PnP devices
+  using user space utilities such as the isapnptools package.
+
+  If unsure, say Y.
+
+CONFIG_PNP_NAMES
+  Select Y if you want the Plug and Play Layer to keep a database of
+  human readable names for your PnP devices.  It will increase the size
+  of the kernel image by around 5 KB and use 16 KB of system memory.
+
+  If unsure, say Y.
+
+CONFIG_PNP_DEBUG
+  Say Y if you want the Plug and Play Layer to print debug messages.  
+  This is useful if you are developing a PnP driver or troubleshooting.
 
 CONFIG_ISAPNP
   Say Y here if you would like support for ISA Plug and Play devices.
@@ -32,8 +39,8 @@
   Specification Version 1.0A May 5, 1994" to autodetect built-in
   mainboard resources (e.g. parallel port resources).
 
-  Other features (e.g. change resources, ESCD, event notification,
-  Docking station information, ISAPNP services) are not used.
+  Some features (e.g. event notification, docking station information,
+  ISAPNP services) are not used.
 
   Note: ACPI is expected to supersede PNPBIOS some day, currently it
   co-exists nicely.
diff -ur --new-file --exclude *.flags a/drivers/pnp/Config.in b/drivers/pnp/Config.in
--- a/drivers/pnp/Config.in	Tue Oct 15 17:31:31 2002
+++ b/drivers/pnp/Config.in	Tue Oct 15 15:49:58 2002
@@ -4,12 +4,15 @@
 mainmenu_option next_comment
 comment 'Plug and Play configuration'
 
-tristate 'Plug and Play support' CONFIG_PNP
+dep_bool 'Plug and Play support' CONFIG_PNP
 
-dep_tristate '  ISA Plug and Play support' CONFIG_ISAPNP $CONFIG_PNP
+   dep_bool '  Plug and Play device name database' CONFIG_PNP_NAMES $CONFIG_PNP
+   dep_bool '  PnP Debug Messages' CONFIG_PNP_DEBUG $CONFIG_PNP
+
+comment 'Protocols' $CONFIG_PNP
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   dep_bool '  PNPBIOS support (EXPERIMENTAL)' CONFIG_PNPBIOS $CONFIG_PNP
+   dep_bool '  ISA Plug and Play support (EXPERIMENTAL)' CONFIG_ISAPNP $CONFIG_PNP
+   dep_bool '  Plug and Play BIOS support (EXPERIMENTAL)' CONFIG_PNPBIOS $CONFIG_PNP
 fi
-
 endmenu
diff -ur --new-file --exclude *.flags a/drivers/pnp/Makefile b/drivers/pnp/Makefile
--- a/drivers/pnp/Makefile	Tue Oct 15 17:31:31 2002
+++ b/drivers/pnp/Makefile	Tue Oct 15 15:36:42 2002
@@ -1,16 +1,12 @@
 #
-# Makefile for the kernel Plug-and-Play device drivers.
+# Makefile for the Linux Plug-and-Play Support.
 #
 
-export-objs := isapnp.o pnpbios_core.o
+obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o compat.o system.o
 
-isa-pnp-proc-$(CONFIG_PROC_FS) = isapnp_proc.o
-pnpbios-proc-$(CONFIG_PROC_FS) = pnpbios_proc.o
+obj-$(CONFIG_PNPBIOS)		+= pnpbios/
+obj-$(CONFIG_ISAPNP)		+= isapnp/
 
-isa-pnp-objs := isapnp.o quirks.o $(isa-pnp-proc-y)
-pnpbios-objs := pnpbios_core.o $(pnpbios-proc-y)
-
-obj-$(CONFIG_ISAPNP) += isa-pnp.o
-obj-$(CONFIG_PNPBIOS) += pnpbios.o
+export-objs	:= core.o driver.o resource.o compat.o
 
 include $(TOPDIR)/Rules.make
diff -ur --new-file --exclude *.flags a/drivers/pnp/base.h b/drivers/pnp/base.h
--- a/drivers/pnp/base.h	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/base.h	Fri Oct 11 22:33:02 2002
@@ -0,0 +1,8 @@
+extern struct bus_type pnp_bus_type;
+extern spinlock_t pnp_lock;
+extern void *pnp_alloc(long size);
+extern int pnp_interface_attach_device(struct pnp_dev *dev);
+extern void pnp_name_device(struct pnp_dev *dev);
+extern void pnp_fixup_device(struct pnp_dev *dev);
+extern int compare_pnp_id(struct list_head * id_list, char * id);
+
diff -ur --new-file --exclude *.flags a/drivers/pnp/compat.c b/drivers/pnp/compat.c
--- a/drivers/pnp/compat.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/compat.c	Sun Oct 13 21:15:34 2002
@@ -0,0 +1,92 @@
+/*
+ * compat.c - A series of functions to make it easier to convert drivers that use
+ *            the old isapnp APIs. If possible use the new APIs instead.
+ *
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+ 
+/* TODO: see if more isapnp functions are needed here */
+
+#include <linux/pnp.h>
+#include <linux/isapnp.h>
+#include <linux/string.h>
+#include "base.h"
+
+static void pnp_convert_id(char *buf, unsigned short vendor, unsigned short device)
+{
+	sprintf(buf, "%c%c%c%x%x%x%x",
+			'A' + ((vendor >> 2) & 0x3f) - 1,
+			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+			'A' + ((vendor >> 8) & 0x1f) - 1,
+			(device >> 4) & 0x0f,
+			device & 0x0f,
+			(device >> 12) & 0x0f,
+			(device >> 8) & 0x0f);
+	return;
+}
+
+struct pnp_card *pnp_find_card(unsigned short vendor,
+				 unsigned short device,
+				 struct pnp_card *from)
+{
+	char id[7];
+	pnp_convert_id(id, vendor, device);
+	char any[7];
+	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
+
+	struct list_head *list;
+
+	list = isapnp_cards.next;
+	if (from)
+		list = from->node.next;
+
+	while (list != &isapnp_cards) {
+		struct pnp_card *card = to_pnp_card(list);
+		if (compare_pnp_id(&card->ids,id) || (memcmp(id,any,7)==0))
+			return card;
+		list = list->next;
+	}
+	return NULL;
+}
+
+struct pnp_dev *pnp_find_dev(struct pnp_card *card,
+				unsigned short vendor,
+				unsigned short function,
+				struct pnp_dev *from)
+{
+	char id[7];
+	pnp_convert_id(id, vendor, function);
+	char any[7];
+	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
+	if (card == NULL) {	/* look for a logical device from all cards */
+		struct list_head *list;
+
+		list = pnp_global.next;
+		if (from)
+			list = from->global_list.next;
+
+		while (list != &pnp_global) {
+			struct pnp_dev *dev = global_to_pnp_dev(list);
+			if (compare_pnp_id(&dev->ids,id) || (memcmp(id,any,7)==0))
+				return dev;
+			list = list->next;
+		}
+	} else {
+		struct list_head *list;
+
+		list = card->devices.next;
+		if (from) {
+			list = from->card_list.next;
+			if (from->card != card)	/* something is wrong */
+				return NULL;
+		}
+		while (list != &card->devices) {
+			struct pnp_dev *dev = card_to_pnp_dev(list);
+			if (compare_pnp_id(&dev->ids,id))
+				return dev;
+			list = list->next;
+		}
+	}
+	return NULL;
+}
diff -ur --new-file --exclude *.flags a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/core.c	Tue Oct 15 17:30:16 2002
@@ -0,0 +1,134 @@
+/*
+ * core.c - contains all core device and protocol registration functions
+ *
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+#include <linux/pnp.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include "base.h"
+
+
+LIST_HEAD(pnp_protocols);
+LIST_HEAD(pnp_global);
+spinlock_t pnp_lock = SPIN_LOCK_UNLOCKED;
+
+void *pnp_alloc(long size)
+{
+	void *result;
+
+	result = kmalloc(size, GFP_KERNEL);
+	if (!result){
+		printk(KERN_ERR "pnp: Out of Memory\n");
+		return NULL;
+	}
+	memset(result, 0, size);
+	return result;
+}
+
+/**
+ * pnp_protocol_register - adds a pnp protocol to the pnp layer
+ * @protocol: pointer to the corresponding pnp_protocol structure
+ *
+ *  Ex protocols: ISAPNP, PNPBIOS, etc
+ */
+
+int pnp_protocol_register(struct pnp_protocol *protocol)
+{
+	int nodenum;
+	struct list_head * pos;
+
+	if (!protocol)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&protocol->devices);
+	nodenum = 0;
+	spin_lock(&pnp_lock);
+
+	/* assign the lowest unused number */
+	list_for_each(pos,&pnp_protocols) {
+		struct pnp_protocol * cur = to_pnp_protocol(pos);
+		if (cur->number == nodenum){
+			pos = &pnp_protocols;
+			nodenum++;
+		}
+	}
+
+	list_add_tail(&protocol->protocol_list, &pnp_protocols);
+	spin_unlock(&pnp_lock);
+
+	protocol->number = nodenum;
+	sprintf(protocol->dev.bus_id, "pnp%d", nodenum);
+	strncpy(protocol->dev.name,protocol->name,DEVICE_NAME_SIZE);
+	return device_register(&protocol->dev);
+}
+
+/**
+ * pnp_init_device - pnp protocols should call this before adding a PnP device
+ * @dev: pointer to dev to init
+ *
+ *  for now it only inits dev->ids, more later?
+ */
+
+int pnp_init_device(struct pnp_dev *dev)
+{
+	INIT_LIST_HEAD(&dev->ids);
+	return 0;
+}
+
+/**
+ * pnp_add_device - adds a pnp device to the pnp layer
+ * @dev: pointer to dev to add
+ *
+ *  adds to driver model, name database, fixups, interface, etc.
+ */
+
+int pnp_add_device(struct pnp_dev *dev)
+{
+	int error = 0;
+	if (!dev->protocol)
+		return -EINVAL;
+	if (dev->card)
+		sprintf(dev->dev.bus_id, "%02x:%02x.%02x", dev->protocol->number,
+		  dev->card->number,dev->number);
+	else
+		sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
+		  dev->number);
+	pnp_name_device(dev);
+	pnp_fixup_device(dev);
+	strcpy(dev->dev.name,dev->name);
+	dev->dev.parent = &dev->protocol->dev;
+	dev->dev.bus = &pnp_bus_type;
+	error = device_register(&dev->dev);
+	if (error == 0){
+		spin_lock(&pnp_lock);
+		list_add_tail(&dev->global_list, &pnp_global);
+		list_add_tail(&dev->dev_list, &dev->protocol->devices);
+		spin_unlock(&pnp_lock);
+		pnp_interface_attach_device(dev);
+	}
+
+	return error;
+}
+
+
+static int __init pnp_init(void)
+{
+	printk(KERN_INFO "Linux Plug and Play Support v0.8 (c) Adam Belay\n");
+	return bus_register(&pnp_bus_type);
+}
+
+core_initcall(pnp_init);
+
+
+EXPORT_SYMBOL(pnp_protocol_register);
+EXPORT_SYMBOL(pnp_add_device);
+EXPORT_SYMBOL(pnp_init_device);
+
diff -ur --new-file --exclude *.flags a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/driver.c	Tue Oct 15 16:23:29 2002
@@ -0,0 +1,189 @@
+/*
+ * driver.c - device id matching, driver model, etc.
+ *
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/ctype.h>
+
+#ifdef CONFIG_PNP_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+
+#include <linux/pnp.h>
+
+static int compare_func(const char *ida, const char *idb)
+{
+	int i;
+	/* we only need to compare the last 4 chars */
+	for (i=3; i<7; i++)
+	{
+		if (ida[i] != 'X' &&
+		    idb[i] != 'X' &&
+		    toupper(ida[i]) != toupper(idb[i]))
+			return 0;
+	}
+	return 1;
+}
+
+int compare_pnp_id(struct list_head *id_list, const char *id)
+{
+	if (!id_list || !id || (strlen(id) != 7))
+		return 0;
+	if (memcmp(id,"ANYDEVS",7)==0)
+		return 1;
+	struct list_head *pos;
+	list_for_each(pos,id_list){
+		struct pnp_id *pnp_id = to_pnp_id(pos);
+		if (memcmp(pnp_id->id,id,3)==0)
+			if (compare_func(pnp_id->id,id)==1)
+				return 1;
+	}
+	return 0;
+}
+
+static const struct pnp_id * match_card(struct pnp_driver *drv, struct pnp_card *card)
+{
+	if (!drv)
+		return NULL;
+	if (!card)
+		return NULL;
+	const struct pnp_id *drv_card_id = drv->card_id_table;
+	while (*drv_card_id->id){
+		if (compare_pnp_id(&card->ids,drv_card_id->id))
+			return drv_card_id;
+		drv_card_id++;
+	}
+	return NULL;
+}
+
+static const struct pnp_id * match_device(struct pnp_driver *drv, struct pnp_dev *dev)
+{
+	if (!drv)
+		return NULL;
+	if (!dev)
+		return NULL;
+	const struct pnp_id *drv_id = drv->id_table;
+	while (*drv_id->id){
+		if (compare_pnp_id(&dev->ids,drv_id->id))
+			return drv_id;
+		drv_id++;
+	}
+	return NULL;
+}
+
+static int pnp_device_probe(struct device *dev)
+{
+	int error = 0;
+	struct pnp_driver *pnp_drv;
+	struct pnp_dev *pnp_dev;
+	const struct pnp_id *card_id = NULL;
+	const struct pnp_id *dev_id = NULL;
+	pnp_dev = to_pnp_dev(dev);
+	pnp_drv = to_pnp_driver(dev->driver);
+	pnp_dbg("pnp: match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
+
+	if (pnp_dev->active == 0)
+		if(pnp_activate_dev(pnp_dev)<0)
+			return 0;
+	if (pnp_drv->probe && pnp_dev->active) {
+		if (pnp_dev->card && pnp_drv->card_id_table){
+			card_id = match_card(pnp_drv, pnp_dev->card);
+			if (card_id != NULL)
+				dev_id = match_device(pnp_drv, pnp_dev);
+			if (dev_id != NULL)
+				error = pnp_drv->probe(pnp_dev, card_id, dev_id);
+		}
+		else{
+			dev_id = match_device(pnp_drv, pnp_dev);
+			if (dev_id != NULL)
+				error = pnp_drv->probe(pnp_dev, card_id, dev_id);
+		}
+		if (error >= 0){
+			pnp_dev->driver = pnp_drv;
+			error = 0;
+		}
+	}
+	return error;
+}
+
+static int pnp_device_remove(struct device *dev)
+{
+	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver * drv = pnp_dev->driver;
+
+	if (drv) {
+		if (drv->remove)
+			drv->remove(pnp_dev);
+		pnp_dev->driver = NULL;
+	}
+	pnp_disable_dev(pnp_dev);
+	return 0;
+}
+
+static int pnp_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver * pnp_drv = to_pnp_driver(drv);
+	if (pnp_dev->card && pnp_drv->card_id_table
+	    && match_card(pnp_drv, pnp_dev->card) == NULL)
+		return 0;
+	if (match_device(pnp_drv, pnp_dev) == NULL)
+		return 0;
+	return 1;
+}
+
+
+struct bus_type pnp_bus_type = {
+	name:	"pnp",
+	match:	pnp_bus_match,
+};
+
+
+int pnp_register_driver(struct pnp_driver *drv)
+{
+	pnp_dbg("the driver '%s' has been registered", drv->name);
+	int count = 0;
+
+	drv->driver.name = drv->name;
+	drv->driver.bus = &pnp_bus_type;
+	drv->driver.probe = pnp_device_probe;
+	drv->driver.remove = pnp_device_remove;
+
+	count = driver_register(&drv->driver);
+	return count ? count : 1;
+}
+
+void pnp_unregister_driver(struct pnp_driver *drv)
+{
+	pnp_dbg("the driver '%s' has been unregistered", drv->name);
+	remove_driver(&drv->driver);
+}
+
+/**
+ * pnp_add_id - adds an EISA id to the specified device
+ * @id: pointer to a pnp_id structure
+ * @dev: pointer to the desired device
+ *
+ */
+
+int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev)
+{
+	if (!id)
+		return -EINVAL;
+	if (!dev)
+		return -EINVAL;
+	list_add_tail(&id->id_list,&dev->ids);
+	return 0;
+}
+
+EXPORT_SYMBOL(pnp_register_driver);
+EXPORT_SYMBOL(pnp_unregister_driver);
+EXPORT_SYMBOL(pnp_add_id);
diff -ur --new-file --exclude *.flags a/drivers/pnp/idlist.h b/drivers/pnp/idlist.h
--- a/drivers/pnp/idlist.h	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/idlist.h	Tue Oct 15 15:31:12 2002
@@ -0,0 +1,321 @@
+ID("CSC0000", "Crystal Semiconductor CS423x sound -- SB/WSS/OPL3 emulation")
+ID("CSC0010", "Crystal Semiconductor CS423x sound -- control")
+ID("CSC0001", "Crystal Semiconductor CS423x sound -- joystick")
+ID("CSC0003", "Crystal Semiconductor CS423x sound -- MPU401")
+ID("IBM3780", "IBM pointing device")
+ID("IBM0071", "IBM infrared communications device")
+ID("IBM3760", "IBM DSP")
+ID("PNP0000", "AT Interrupt Controller")
+ID("PNP0001", "EISA Interrupt Controller")
+ID("PNP0002", "MCA Interrupt Controller")
+ID("PNP0003", "APIC")
+ID("PNP0004", "Cyrix SLiC MP Interrupt Controller")
+ID("PNP0100", "AT Timer")
+ID("PNP0101", "EISA Timer")
+ID("PNP0102", "MCA Timer")
+ID("PNP0200", "AT DMA Controller")
+ID("PNP0201", "EISA DMA Controller")
+ID("PNP0202", "MCA DMA Controller")
+ID("PNP0300", "IBM PC/XT keyboard controller (83-key)")
+ID("PNP0301", "IBM PC/AT keyboard controller (86-key)")
+ID("PNP0302", "IBM PC/XT keyboard controller (84-key)")
+ID("PNP0303", "IBM Enhanced (101/102-key, PS/2 mouse support)")
+ID("PNP0304", "Olivetti Keyboard (83-key)")
+ID("PNP0305", "Olivetti Keyboard (102-key)")
+ID("PNP0306", "Olivetti Keyboard (86-key)")
+ID("PNP0307", "Microsoft Windows(R) Keyboard")
+ID("PNP0308", "General Input Device Emulation Interface (GIDEI) legacy")
+ID("PNP0309", "Olivetti Keyboard (A101/102 key)")
+ID("PNP030a", "AT&T 302 Keyboard")
+ID("PNP0320", "Japanese 106-key keyboard A01")
+ID("PNP0321", "Japanese 101-key keyboard")
+ID("PNP0322", "Japanese AX keyboard")
+ID("PNP0323", "Japanese 106-key keyboard 002/003")
+ID("PNP0324", "Japanese 106-key keyboard 001")
+ID("PNP0325", "Japanese Toshiba Desktop keyboard")
+ID("PNP0326", "Japanese Toshiba Laptop keyboard")
+ID("PNP0327", "Japanese Toshiba Notebook keyboard")
+ID("PNP0340", "Korean 84-key keyboard")
+ID("PNP0341", "Korean 86-key keyboard")
+ID("PNP0342", "Korean Enhanced keyboard")
+ID("PNP0343", "Korean Enhanced keyboard 101b")
+ID("PNP0343", "Korean Enhanced keyboard 101c")
+ID("PNP0344", "Korean Enhanced keyboard 103")
+ID("PNP0400", "Standard LPT printer port")
+ID("PNP0401", "ECP printer port")
+ID("PNP0500", "Standard PC COM port")
+ID("PNP0501", "16550A-compatible COM port")
+ID("PNP0502", "Multiport serial device (non-intelligent 16550)")
+ID("PNP0510", "Generic IRDA-compatible device")
+ID("PNP0511", "Generic IRDA-compatible device")
+ID("PNP0600", "Generic ESDI/IDE/ATA compatible hard disk controller")
+ID("PNP0601", "Plus Hardcard II")
+ID("PNP0602", "Plus Hardcard IIXL/EZ")
+ID("PNP0603", "Generic IDE supporting Microsoft Device Bay Specification")
+ID("PNP0700", "PC standard floppy disk controller")
+ID("PNP0701", "Standard floppy controller supporting MS Device Bay Spec")
+ID("PNP0900", "VGA Compatible")
+ID("PNP0901", "Video Seven VRAM/VRAM II/1024i")
+ID("PNP0902", "8514/A Compatible")
+ID("PNP0903", "Trident VGA")
+ID("PNP0904", "Cirrus Logic Laptop VGA")
+ID("PNP0905", "Cirrus Logic VGA")
+ID("PNP0906", "Tseng ET4000")
+ID("PNP0907", "Western Digital VGA")
+ID("PNP0908", "Western Digital Laptop VGA")
+ID("PNP0909", "S3 Inc. 911/924")
+ID("PNP090a", "ATI Ultra Pro/Plus (Mach 32)")
+ID("PNP090b", "ATI Ultra (Mach 8)")
+ID("PNP090c", "XGA Compatible")
+ID("PNP090d", "ATI VGA Wonder")
+ID("PNP090e", "Weitek P9000 Graphics Adapter")
+ID("PNP090f", "Oak Technology VGA")
+ID("PNP0910", "Compaq QVision")
+ID("PNP0911", "XGA/2")
+ID("PNP0912", "Tseng Labs W32/W32i/W32p")
+ID("PNP0913", "S3 Inc. 801/928/964")
+ID("PNP0914", "Cirrus Logic 5429/5434 (memory mapped)")
+ID("PNP0915", "Compaq Advanced VGA (AVGA)")
+ID("PNP0916", "ATI Ultra Pro Turbo (Mach64)")
+ID("PNP0917", "Reserved by Microsoft")
+ID("PNP0918", "Matrox MGA")
+ID("PNP0919", "Compaq QVision 2000")
+ID("PNP091a", "Tseng W128")
+ID("PNP0930", "Chips & Technologies Super VGA")
+ID("PNP0931", "Chips & Technologies Accelerator")
+ID("PNP0940", "NCR 77c22e Super VGA")
+ID("PNP0941", "NCR 77c32blt")
+ID("PNP09ff", "Plug and Play Monitors (VESA DDC)")
+ID("PNP0a00", "ISA Bus")
+ID("PNP0a01", "EISA Bus")
+ID("PNP0a02", "MCA Bus")
+ID("PNP0a03", "PCI Bus")
+ID("PNP0a04", "VESA/VL Bus")
+ID("PNP0a05", "Generic ACPI Bus")
+ID("PNP0a06", "Generic ACPI Extended-IO Bus (EIO bus)")
+ID("PNP0800", "AT-style speaker sound")
+ID("PNP0b00", "AT Real-Time Clock")
+ID("PNP0c00", "Plug and Play BIOS (only created by the root enumerator)")
+ID("PNP0c01", "System Board")
+ID("PNP0c02", "Reserved Motherboard Resources")
+ID("PNP0c03", "Plug and Play BIOS Event Notification Interrupt")
+ID("PNP0c04", "Math Coprocessor")
+ID("PNP0c05", "APM BIOS (Version independent)")
+ID("PNP0c06", "Reserved for identification of early Plug and Play BIOS implementation.")
+ID("PNP0c07", "Reserved for identification of early Plug and Play BIOS implementation.")
+ID("PNP0c08", "ACPI system board hardware")
+ID("PNP0c09", "ACPI Embedded Controller")
+ID("PNP0c0a", "ACPI Control Method Battery")
+ID("PNP0c0b", "ACPI Fan")
+ID("PNP0c0c", "ACPI power button device")
+ID("PNP0c0d", "ACPI lid device")
+ID("PNP0c0e", "ACPI sleep button device")
+ID("PNP0c0f", "PCI interrupt link device")
+ID("PNP0c10", "ACPI system indicator device")
+ID("PNP0c11", "ACPI thermal zone")
+ID("PNP0c12", "Device Bay Controller")
+ID("PNP0c13", "Plug and Play BIOS (used when ACPI mode cannot be used)")
+ID("PNP0e00", "Intel 82365-Compatible PCMCIA Controller")
+ID("PNP0e01", "Cirrus Logic CL-PD6720 PCMCIA Controller")
+ID("PNP0e02", "VLSI VL82C146 PCMCIA Controller")
+ID("PNP0e03", "Intel 82365-compatible CardBus controller")
+ID("PNP0f00", "Microsoft Bus Mouse")
+ID("PNP0f01", "Microsoft Serial Mouse")
+ID("PNP0f02", "Microsoft InPort Mouse")
+ID("PNP0f03", "Microsoft PS/2-style Mouse")
+ID("PNP0f04", "Mouse Systems Mouse")
+ID("PNP0f05", "Mouse Systems 3-Button Mouse (COM2)")
+ID("PNP0f06", "Genius Mouse (COM1)")
+ID("PNP0f07", "Genius Mouse (COM2)")
+ID("PNP0f08", "Logitech Serial Mouse")
+ID("PNP0f09", "Microsoft BallPoint Serial Mouse")
+ID("PNP0f0a", "Microsoft Plug and Play Mouse")
+ID("PNP0f0b", "Microsoft Plug and Play BallPoint Mouse")
+ID("PNP0f0c", "Microsoft-compatible Serial Mouse")
+ID("PNP0f0d", "Microsoft-compatible InPort-compatible Mouse")
+ID("PNP0f0e", "Microsoft-compatible PS/2-style Mouse")
+ID("PNP0f0f", "Microsoft-compatible Serial BallPoint-compatible Mouse")
+ID("PNP0f10", "Texas Instruments QuickPort Mouse")
+ID("PNP0f11", "Microsoft-compatible Bus Mouse")
+ID("PNP0f12", "Logitech PS/2-style Mouse")
+ID("PNP0f13", "PS/2 Port for PS/2-style Mice")
+ID("PNP0f14", "Microsoft Kids Mouse")
+ID("PNP0f15", "Logitech bus mouse")
+ID("PNP0f16", "Logitech SWIFT device")
+ID("PNP0f17", "Logitech-compatible serial mouse")
+ID("PNP0f18", "Logitech-compatible bus mouse")
+ID("PNP0f19", "Logitech-compatible PS/2-style Mouse")
+ID("PNP0f1a", "Logitech-compatible SWIFT Device")
+ID("PNP0f1b", "HP Omnibook Mouse")
+ID("PNP0f1c", "Compaq LTE Trackball PS/2-style Mouse")
+ID("PNP0f1d", "Compaq LTE Trackball Serial Mouse")
+ID("PNP0f1e", "Microsoft Kids Trackball Mouse")
+ID("PNP8001", "Novell/Anthem NE3200")
+ID("PNP0802", "Microsoft Sound System or Compatible Device (obsolete)")
+ID("PNP8004", "Compaq NE3200")
+ID("PNP8006", "Intel EtherExpress/32")
+ID("PNP8008", "HP EtherTwist EISA LAN Adapter/32 (HP27248A)")
+ID("PNP8065", "Ungermann-Bass NIUps or NIUps/EOTP")
+ID("PNP8072", "DEC (DE211) EtherWorks MC/TP")
+ID("PNP8073", "DEC (DE212) EtherWorks MC/TP_BNC")
+ID("PNP8078", "DCA 10 Mb MCA")
+ID("PNP8074", "HP MC LAN Adapter/16 TP (PC27246)")
+ID("PNP80c9", "IBM Token Ring")
+ID("PNP80ca", "IBM Token Ring II")
+ID("PNP80cb", "IBM Token Ring II/Short")
+ID("PNP80cc", "IBM Token Ring 4/16Mbs")
+ID("PNP80d3", "Novell/Anthem NE1000")
+ID("PNP80d4", "Novell/Anthem NE2000")
+ID("PNP80d5", "NE1000 Compatible")
+ID("PNP80d6", "NE2000 Compatible")
+ID("PNP80d7", "Novell/Anthem NE1500T")
+ID("PNP80d8", "Novell/Anthem NE2100")
+ID("PNP80dd", "SMC ARCNETPC")
+ID("PNP80de", "SMC ARCNET PC100, PC200")
+ID("PNP80df", "SMC ARCNET PC110, PC210, PC250")
+ID("PNP80e0", "SMC ARCNET PC130/E")
+ID("PNP80e1", "SMC ARCNET PC120, PC220, PC260")
+ID("PNP80e2", "SMC ARCNET PC270/E")
+ID("PNP80e5", "SMC ARCNET PC600W, PC650W")
+ID("PNP80e7", "DEC DEPCA")
+ID("PNP80e8", "DEC (DE100) EtherWorks LC")
+ID("PNP80e9", "DEC (DE200) EtherWorks Turbo")
+ID("PNP80ea", "DEC (DE101) EtherWorks LC/TP")
+ID("PNP80eb", "DEC (DE201) EtherWorks Turbo/TP")
+ID("PNP80ec", "DEC (DE202) EtherWorks Turbo/TP_BNC")
+ID("PNP80ed", "DEC (DE102) EtherWorks LC/TP_BNC")
+ID("PNP80ee", "DEC EE101 (Built-In)")
+ID("PNP80ef", "DECpc 433 WS (Built-In)")
+ID("PNP80f1", "3Com EtherLink Plus")
+ID("PNP80f3", "3Com EtherLink II or IITP (8 or 16-bit)")
+ID("PNP80f4", "3Com TokenLink")
+ID("PNP80f6", "3Com EtherLink 16")
+ID("PNP80f7", "3Com EtherLink III")
+ID("PNP80f8", "3Com Generic Etherlink Plug and Play Device")
+ID("PNP80fb", "Thomas Conrad TC6045")
+ID("PNP80fc", "Thomas Conrad TC6042")
+ID("PNP80fd", "Thomas Conrad TC6142")
+ID("PNP80fe", "Thomas Conrad TC6145")
+ID("PNP80ff", "Thomas Conrad TC6242")
+ID("PNP8100", "Thomas Conrad TC6245")
+ID("PNP8105", "DCA 10 MB")
+ID("PNP8106", "DCA 10 MB Fiber Optic")
+ID("PNP8107", "DCA 10 MB Twisted Pair")
+ID("PNP8113", "Racal NI6510")
+ID("PNP811c", "Ungermann-Bass NIUpc")
+ID("PNP8120", "Ungermann-Bass NIUpc/EOTP")
+ID("PNP8123", "SMC StarCard PLUS (WD/8003S)")
+ID("PNP8124", "SMC StarCard PLUS With On Board Hub (WD/8003SH)")
+ID("PNP8125", "SMC EtherCard PLUS (WD/8003E)")
+ID("PNP8126", "SMC EtherCard PLUS With Boot ROM Socket (WD/8003EBT)")
+ID("PNP8127", "SMC EtherCard PLUS With Boot ROM Socket (WD/8003EB)")
+ID("PNP8128", "SMC EtherCard PLUS TP (WD/8003WT)")
+ID("PNP812a", "SMC EtherCard PLUS 16 With Boot ROM Socket (WD/8013EBT)")
+ID("PNP812d", "Intel EtherExpress 16 or 16TP")
+ID("PNP812f", "Intel TokenExpress 16/4")
+ID("PNP8130", "Intel TokenExpress MCA 16/4")
+ID("PNP8132", "Intel EtherExpress 16 (MCA)")
+ID("PNP8137", "Artisoft AE-1")
+ID("PNP8138", "Artisoft AE-2 or AE-3")
+ID("PNP8141", "Amplicard AC 210/XT")
+ID("PNP8142", "Amplicard AC 210/AT")
+ID("PNP814b", "Everex SpeedLink /PC16 (EV2027)")
+ID("PNP8155", "HP PC LAN Adapter/8 TP (HP27245)")
+ID("PNP8156", "HP PC LAN Adapter/16 TP (HP27247A)")
+ID("PNP8157", "HP PC LAN Adapter/8 TL (HP27250)")
+ID("PNP8158", "HP PC LAN Adapter/16 TP Plus (HP27247B)")
+ID("PNP8159", "HP PC LAN Adapter/16 TL Plus (HP27252)")
+ID("PNP815f", "National Semiconductor Ethernode *16AT")
+ID("PNP8160", "National Semiconductor AT/LANTIC EtherNODE 16-AT3")
+ID("PNP816a", "NCR Token-Ring 4 Mbs ISA")
+ID("PNP816d", "NCR Token-Ring 16/4 Mbs ISA")
+ID("PNP8191", "Olicom 16/4 Token-Ring Adapter")
+ID("PNP81c3", "SMC EtherCard PLUS Elite (WD/8003EP)")
+ID("PNP81c4", "SMC EtherCard PLUS 10T (WD/8003W)")
+ID("PNP81c5", "SMC EtherCard PLUS Elite 16 (WD/8013EP)")
+ID("PNP81c6", "SMC EtherCard PLUS Elite 16T (WD/8013W)")
+ID("PNP81c7", "SMC EtherCard PLUS Elite 16 Combo (WD/8013EW or 8013EWC)")
+ID("PNP81c8", "SMC EtherElite Ultra 16")
+ID("PNP81e4", "Pure Data PDI9025-32 (Token Ring)")
+ID("PNP81e6", "Pure Data PDI508+ (ArcNet)")
+ID("PNP81e7", "Pure Data PDI516+ (ArcNet)")
+ID("PNP81eb", "Proteon Token Ring (P1390)")
+ID("PNP81ec", "Proteon Token Ring (P1392)")
+ID("PNP81ed", "Proteon ISA Token Ring (1340)")
+ID("PNP81ee", "Proteon ISA Token Ring (1342)")
+ID("PNP81ef", "Proteon ISA Token Ring (1346)")
+ID("PNP81f0", "Proteon ISA Token Ring (1347)")
+ID("PNP81ff", "Cabletron E2000 Series DNI")
+ID("PNP8200", "Cabletron E2100 Series DNI")
+ID("PNP8209", "Zenith Data Systems Z-Note")
+ID("PNP820a", "Zenith Data Systems NE2000-Compatible")
+ID("PNP8213", "Xircom Pocket Ethernet II")
+ID("PNP8214", "Xircom Pocket Ethernet I")
+ID("PNP821d", "RadiSys EXM-10")
+ID("PNP8227", "SMC 3000 Series")
+ID("PNP8228", "SMC 91C2 controller")
+ID("PNP8231", "Advanced Micro Devices AM2100/AM1500T")
+ID("PNP8263", "Tulip NCC-16")
+ID("PNP8277", "Exos 105")
+ID("PNP828a", "Intel '595 based Ethernet")
+ID("PNP828b", "TI2000-style Token Ring")
+ID("PNP828c", "AMD PCNet Family cards")
+ID("PNP828d", "AMD PCNet32 (VL version)")
+ID("PNP8294", "IrDA Infrared NDIS driver (Microsoft-supplied)")
+ID("PNP82bd", "IBM PCMCIA-NIC")
+ID("PNP82c2", "Xircom CE10")
+ID("PNP82c3", "Xircom CEM2")
+ID("PNP8321", "DEC Ethernet (All Types)")
+ID("PNP8323", "SMC EtherCard (All Types except 8013/A)")
+ID("PNP8324", "ARCNET Compatible")
+ID("PNP8326", "Thomas Conrad (All Arcnet Types)")
+ID("PNP8327", "IBM Token Ring (All Types)")
+ID("PNP8385", "Remote Network Access Driver")
+ID("PNP8387", "RNA Point-to-point Protocol Driver")
+ID("PNP8388", "Reserved for Microsoft Networking components")
+ID("PNP8389", "Peer IrLAN infrared driver (Microsoft-supplied)")
+ID("PNP8390", "Generic network adapter")
+ID("PNPa002", "Future Domain 16-700 compatible controller")
+ID("PNPa003", "Panasonic proprietary CD-ROM adapter (SBPro/SB16)")
+ID("PNPa01b", "Trantor 128 SCSI Controller")
+ID("PNPa01d", "Trantor T160 SCSI Controller")
+ID("PNPa01e", "Trantor T338 Parallel SCSI controller")
+ID("PNPa01f", "Trantor T348 Parallel SCSI controller")
+ID("PNPa020", "Trantor Media Vision SCSI controller")
+ID("PNPa022", "Always IN-2000 SCSI controller")
+ID("PNPa02b", "Sony proprietary CD-ROM controller")
+ID("PNPa02d", "Trantor T13b 8-bit SCSI controller")
+ID("PNPa02f", "Trantor T358 Parallel SCSI controller")
+ID("PNPa030", "Mitsumi LU-005 Single Speed CD-ROM controller + drive")
+ID("PNPa031", "Mitsumi FX-001 Single Speed CD-ROM controller + drive")
+ID("PNPa032", "Mitsumi FX-001 Double Speed CD-ROM controller + drive")
+ID("PNPb000", "Sound Blaster 1.5 sound device")
+ID("PNPb001", "Sound Blaster 2.0 sound device")
+ID("PNPb002", "Sound Blaster Pro sound device")
+ID("PNPb003", "Sound Blaster 16 sound device")
+ID("PNPb004", "Thunderboard-compatible sound device")
+ID("PNPb005", "Adlib-compatible FM synthesizer device")
+ID("PNPb006", "MPU401 compatible")
+ID("PNPb007", "Microsoft Windows Sound System-compatible sound device")
+ID("PNPb008", "Compaq Business Audio")
+ID("PNPb009", "Plug and Play Microsoft Windows Sound System Device")
+ID("PNPb00a", "MediaVision Pro Audio Spectrum (Trantor SCSI enabled, Thunder Chip Disabled)")
+ID("PNPb00b", "MediaVision Pro Audio 3D")
+ID("PNPb00c", "MusicQuest MQX-32M")
+ID("PNPb00d", "MediaVision Pro Audio Spectrum Basic (No Trantor SCSI, Thunder Chip Enabled)")
+ID("PNPb00e", "MediaVision Pro Audio Spectrum (Trantor SCSI enabled, Thunder Chip Enabled)")
+ID("PNPb00f", "MediaVision Jazz-16 chipset (OEM Versions)")
+ID("PNPb010", "Auravision VxP500 chipset - Orchid Videola")
+ID("PNPb018", "MediaVision Pro Audio Spectrum 8-bit")
+ID("PNPb019", "MediaVision Pro Audio Spectrum Basic (no Trantor SCSI, Thunder chip Disabled)")
+ID("PNPb020", "Yamaha OPL3-compatible FM synthesizer device")
+ID("PNPb02f", "Joystick/Game port")
+ID("PNPb000", "Compaq 14400 Modem (TBD)")
+ID("PNPc001", "Compaq 2400/9600 Modem (TBD)")
+ID("PNP0XXX", "Unknown System Device")
+ID("PNP8XXX", "Unknown Network Adapter")
+ID("PNPaXXX", "Unknown SCSI, Proprietary CD Adapter")
+ID("PNPbXXX", "Unknown Multimedia Device")
+ID("PNPcXXX", "Unknown Modem")
+
+#undef ID
diff -ur --new-file --exclude *.flags a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/interface.c	Sat Oct 12 12:15:55 2002
@@ -0,0 +1,342 @@
+/*
+ * interface.c - contains everything related to the user interface
+ *
+ * Some code is based on isapnp_proc.c (c) Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+#include <linux/pnp.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+
+#include "base.h"
+
+struct pnp_info_buffer {
+	char *buffer;		/* pointer to begin of buffer */
+	char *curr;		/* current position in buffer */
+	unsigned long size;	/* current size */
+	unsigned long len;	/* total length of buffer */
+	int stop;		/* stop flag */
+	int error;		/* error code */
+};
+
+typedef struct pnp_info_buffer pnp_info_buffer_t;
+
+int pnp_printf(pnp_info_buffer_t * buffer, char *fmt,...)
+{
+	va_list args;
+	int res;
+	char sbuffer[512];
+
+	if (buffer->stop || buffer->error)
+		return 0;
+	va_start(args, fmt);
+	res = vsprintf(sbuffer, fmt, args);
+	va_end(args);
+	if (buffer->size + res >= buffer->len) {
+		buffer->stop = 1;
+		return 0;
+	}
+	strcpy(buffer->curr, sbuffer);
+	buffer->curr += res;
+	buffer->size += res;
+	return res;
+}
+
+static void pnp_print_port(pnp_info_buffer_t *buffer, char *space, struct pnp_port *port)
+{
+	pnp_printf(buffer, "%sport 0x%x-0x%x, align 0x%x, size 0x%x, %i-bit address decoding\n",
+			space, port->min, port->max, port->align ? (port->align-1) : 0, port->size,
+			port->flags & PNP_PORT_FLAG_16BITADDR ? 16 : 10);
+}
+
+static void pnp_print_irq(pnp_info_buffer_t *buffer, char *space, struct pnp_irq *irq)
+{
+	int first = 1, i;
+
+	pnp_printf(buffer, "%sirq ", space);
+	for (i = 0; i < 16; i++)
+		if (irq->map & (1<<i)) {
+			if (!first) {
+				pnp_printf(buffer, ",");
+			} else {
+				first = 0;
+			}
+			if (i == 2 || i == 9)
+				pnp_printf(buffer, "2/9");
+			else
+				pnp_printf(buffer, "%i", i);
+		}
+	if (!irq->map)
+		pnp_printf(buffer, "<none>");
+	if (irq->flags & IORESOURCE_IRQ_HIGHEDGE)
+		pnp_printf(buffer, " High-Edge");
+	if (irq->flags & IORESOURCE_IRQ_LOWEDGE)
+		pnp_printf(buffer, " Low-Edge");
+	if (irq->flags & IORESOURCE_IRQ_HIGHLEVEL)
+		pnp_printf(buffer, " High-Level");
+	if (irq->flags & IORESOURCE_IRQ_LOWLEVEL)
+		pnp_printf(buffer, " Low-Level");
+	pnp_printf(buffer, "\n");
+}
+
+static void pnp_print_dma(pnp_info_buffer_t *buffer, char *space, struct pnp_dma *dma)
+{
+	int first = 1, i;
+	char *s;
+
+	pnp_printf(buffer, "%sdma ", space);
+	for (i = 0; i < 8; i++)
+		if (dma->map & (1<<i)) {
+			if (!first) {
+				pnp_printf(buffer, ",");
+			} else {
+				first = 0;
+			}
+			pnp_printf(buffer, "%i", i);
+		}
+	if (!dma->map)
+		pnp_printf(buffer, "<none>");
+	switch (dma->flags & IORESOURCE_DMA_TYPE_MASK) {
+	case IORESOURCE_DMA_8BIT:
+		s = "8-bit";
+		break;
+	case IORESOURCE_DMA_8AND16BIT:
+		s = "8-bit&16-bit";
+		break;
+	default:
+		s = "16-bit";
+	}
+	pnp_printf(buffer, " %s", s);
+	if (dma->flags & IORESOURCE_DMA_MASTER)
+		pnp_printf(buffer, " master");
+	if (dma->flags & IORESOURCE_DMA_BYTE)
+		pnp_printf(buffer, " byte-count");
+	if (dma->flags & IORESOURCE_DMA_WORD)
+		pnp_printf(buffer, " word-count");
+	switch (dma->flags & IORESOURCE_DMA_SPEED_MASK) {
+	case IORESOURCE_DMA_TYPEA:
+		s = "type-A";
+		break;
+	case IORESOURCE_DMA_TYPEB:
+		s = "type-B";
+		break;
+	case IORESOURCE_DMA_TYPEF:
+		s = "type-F";
+		break;
+	default:
+		s = "compatible";
+		break;
+	}
+	pnp_printf(buffer, " %s\n", s);
+}
+
+static void pnp_print_mem(pnp_info_buffer_t *buffer, char *space, struct pnp_mem *mem)
+{
+	char *s;
+
+	pnp_printf(buffer, "%sMemory 0x%x-0x%x, align 0x%x, size 0x%x",
+			space, mem->min, mem->max, mem->align, mem->size);
+	if (mem->flags & IORESOURCE_MEM_WRITEABLE)
+		pnp_printf(buffer, ", writeable");
+	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
+		pnp_printf(buffer, ", cacheable");
+	if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
+		pnp_printf(buffer, ", range-length");
+	if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
+		pnp_printf(buffer, ", shadowable");
+	if (mem->flags & IORESOURCE_MEM_EXPANSIONROM)
+		pnp_printf(buffer, ", expansion ROM");
+	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
+	case IORESOURCE_MEM_8BIT:
+		s = "8-bit";
+		break;
+	case IORESOURCE_MEM_8AND16BIT:
+		s = "8-bit&16-bit";
+		break;
+	default:
+		s = "16-bit";
+	}
+	pnp_printf(buffer, ", %s\n", s);
+}
+
+static void pnp_print_mem32(pnp_info_buffer_t *buffer, char *space, struct pnp_mem32 *mem32)
+{
+	int first = 1, i;
+
+	pnp_printf(buffer, "%s32-bit memory ", space);
+	for (i = 0; i < 17; i++) {
+		if (first) {
+			first = 0;
+		} else {
+			pnp_printf(buffer, ":");
+		}
+		pnp_printf(buffer, "%02x", mem32->data[i]);
+	}
+}
+
+static void pnp_print_resources(pnp_info_buffer_t *buffer, char *space, struct pnp_resources *res, int dep)
+{
+	char *s;
+	struct pnp_port *port;
+	struct pnp_irq *irq;
+	struct pnp_dma *dma;
+	struct pnp_mem *mem;
+	struct pnp_mem32 *mem32;
+
+	switch (res->priority) {
+	case PNP_RES_PRIORITY_PREFERRED:
+		s = "preferred";
+		break;
+	case PNP_RES_PRIORITY_ACCEPTABLE:
+		s = "acceptable";
+		break;
+	case PNP_RES_PRIORITY_FUNCTIONAL:
+		s = "functional";
+		break;
+	default:
+		s = "invalid";
+	}
+	if (dep > 0)
+		pnp_printf(buffer, "Dependent: %02i - Priority %s\n",dep, s);
+	for (port = res->port; port; port = port->next)
+		pnp_print_port(buffer, space, port);
+	for (irq = res->irq; irq; irq = irq->next)
+		pnp_print_irq(buffer, space, irq);
+	for (dma = res->dma; dma; dma = dma->next)
+		pnp_print_dma(buffer, space, dma);
+	for (mem = res->mem; mem; mem = mem->next)
+		pnp_print_mem(buffer, space, mem);
+	for (mem32 = res->mem32; mem32; mem32 = mem32->next)
+		pnp_print_mem32(buffer, space, mem32);
+}
+
+static ssize_t pnp_show_possible_resources(struct device *dmdev, char *buf, size_t count, loff_t off)
+{
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_resources * res = dev->res;
+	int dep = 0;
+	pnp_info_buffer_t *buffer;
+	if (off)
+		return 0;
+	buffer = (pnp_info_buffer_t *) pnp_alloc(sizeof(pnp_info_buffer_t));
+	if (!buffer)
+		return -ENOMEM;
+	buffer->len = PAGE_SIZE;
+	buffer->buffer = buf;
+	buffer->curr = buffer->buffer;
+	while (res){
+		if (dep == 0)
+			pnp_print_resources(buffer, "", res, dep);
+		else
+			pnp_print_resources(buffer, "   ", res, dep);
+		res = res->dep;
+		dep++;
+	}
+	return (buffer->curr - buf);
+}
+
+static DEVICE_ATTR(possible,S_IRUGO,pnp_show_possible_resources,NULL);
+
+static ssize_t pnp_show_current_resources(struct device *dmdev, char *buf, size_t count, loff_t off)
+{
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	char *str = buf;
+	int i;
+	if (off)
+		return 0;
+	if (!dev->active){
+		str += sprintf(str,"DISABLED\n");
+		goto done;
+	}
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (dev->resource[i].flags & IORESOURCE_IO){
+				str += sprintf(str,"io");
+				str += sprintf(str," 0x%lx-0x%lx \n",
+					       dev->resource[i].start,
+					       dev->resource[i].end);
+			}
+			if (dev->resource[i].flags & IORESOURCE_MEM){
+				str += sprintf(str,"mem");
+				str += sprintf(str," 0x%lx-0x%lx \n",
+					       dev->resource[i].start,
+					       dev->resource[i].end);
+			}
+	}
+	for (i = 0; i < DEVICE_COUNT_IRQ && dev->irq_resource[i].flags
+			 & IORESOURCE_IRQ; i++) {
+			str += sprintf(str,"irq");
+			str += sprintf(str," %ld \n", dev->irq_resource[i].start);
+	}
+	for (i = 0; i < DEVICE_COUNT_DMA && dev->dma_resource[i].flags
+			 & IORESOURCE_DMA; i++) {
+			str += sprintf(str,"dma");
+			str += sprintf(str," %ld \n", dev->dma_resource[i].start);
+	}
+	done:
+	return (str - buf);
+}
+
+static ssize_t
+pnp_set_current_resources(struct device * dmdev, const char * buf, size_t count, loff_t off)
+{
+	if (off)
+		return 0;
+
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	char	command[20];
+	char	type[20];
+	int	num_args;
+	int	error = 0;
+	int	depnum, mode = 0;
+	num_args = sscanf(buf,"%10s %i %10s",command,&depnum,type);
+	if (!num_args)
+		goto done;
+	if (!strnicmp(command,"disable",7)) {
+		error = pnp_disable_dev(dev);
+		goto done;
+	}
+	if (!strnicmp(command,"auto",4)) {
+		error = pnp_activate_dev(dev);
+		goto done;
+	}
+	if (!strnicmp(command,"manual",6)) {
+		if (num_args != 3)
+			goto done;
+		if (!strnicmp(type,"static",6))
+			mode = PNP_STATIC;
+		error = pnp_raw_set_dev(dev,depnum,mode);
+		goto done;
+	}
+ done:
+	return error < 0 ? error : count;
+}
+
+static DEVICE_ATTR(resources,S_IRUGO | S_IWUSR,
+		   pnp_show_current_resources,pnp_set_current_resources);
+
+static ssize_t pnp_show_current_ids(struct device *dmdev, char *buf, size_t count, loff_t off)
+{
+	if (off)
+		return 0;
+	char *str = buf;
+	struct list_head * pos;
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	list_for_each(pos,&dev->ids) {
+		struct pnp_id * cur = to_pnp_id(pos);
+		str += sprintf(str,"%s\n", cur->id);
+	}
+	return (str - buf);
+}
+
+static DEVICE_ATTR(id,S_IRUGO,pnp_show_current_ids,NULL);
+
+int pnp_interface_attach_device(struct pnp_dev *dev)
+{
+	device_create_file(&dev->dev,&dev_attr_possible);
+	device_create_file(&dev->dev,&dev_attr_resources);
+	device_create_file(&dev->dev,&dev_attr_id);
+	return 0;
+}
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
--- a/drivers/pnp/isapnp/Makefile	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/isapnp/Makefile	Tue Oct 15 15:07:47 2002
@@ -0,0 +1,11 @@
+#
+# Makefile for the kernel ISAPNP driver.
+#
+
+export-objs := core.o
+
+isapnp-proc-$(CONFIG_PROC_FS) = proc.o
+
+obj-y := core.o $(isapnp-proc-y)
+
+include $(TOPDIR)/Rules.make
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/isapnp/core.c	Tue Oct 15 15:11:55 2002
@@ -0,0 +1,1193 @@
+/*
+ *  ISA Plug & Play support
+ *  Copyright (c) by Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Changelog:
+ *  2000-01-01	Added quirks handling for buggy hardware
+ *		Peter Denison <peterd-ELNARaTYPWWHCRyBVyKX4rVCufUGDwFn@public.gmane.org>
+ *  2000-06-14	Added isapnp_probe_devs() and isapnp_activate_dev()
+ *		Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
+ *  2001-06-03  Added release_region calls to correspond with
+ *		request_region calls when a failure occurs.  Also
+ *		added KERN_* constants to printk() calls.
+ *  2001-11-07  Added isapnp_{,un}register_driver calls along the lines
+ *              of the pci driver interface
+ *              Kai Germaschewski <kai.germaschewski-Mmb7MZpHnFY@public.gmane.org>
+ *  2002-06-06  Made the use of dma channel 0 configurable
+ *              Gerald Teschl <gerald.teschl-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
+ *  2002-10-06  Ported to PnP Layer - Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/isapnp.h>
+#include <linux/pnp.h>
+
+LIST_HEAD(isapnp_cards);
+LIST_HEAD(isapnp_devices);
+
+#if 0
+#define ISAPNP_REGION_OK
+#endif
+#if 0
+#define ISAPNP_DEBUG
+#endif
+
+int isapnp_disable;			/* Disable ISA PnP */
+int isapnp_rdp;				/* Read Data Port */
+int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
+int isapnp_skip_pci_scan;		/* skip PCI resource scanning */
+int isapnp_verbose = 1;			/* verbose mode */
+
+MODULE_AUTHOR("Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>");
+MODULE_DESCRIPTION("Generic ISA Plug & Play support");
+MODULE_PARM(isapnp_disable, "i");
+MODULE_PARM_DESC(isapnp_disable, "ISA Plug & Play disable");
+MODULE_PARM(isapnp_rdp, "i");
+MODULE_PARM_DESC(isapnp_rdp, "ISA Plug & Play read data port");
+MODULE_PARM(isapnp_reset, "i");
+MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
+MODULE_PARM(isapnp_allow_dma0, "i");
+MODULE_PARM(isapnp_skip_pci_scan, "i");
+MODULE_PARM_DESC(isapnp_skip_pci_scan, "ISA Plug & Play skip PCI resource scanning");
+MODULE_PARM(isapnp_verbose, "i");
+MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
+MODULE_LICENSE("GPL");
+
+#define _PIDXR		0x279
+#define _PNPWRP		0xa79
+
+/* short tags */
+#define _STAG_PNPVERNO		0x01
+#define _STAG_LOGDEVID		0x02
+#define _STAG_COMPATDEVID	0x03
+#define _STAG_IRQ		0x04
+#define _STAG_DMA		0x05
+#define _STAG_STARTDEP		0x06
+#define _STAG_ENDDEP		0x07
+#define _STAG_IOPORT		0x08
+#define _STAG_FIXEDIO		0x09
+#define _STAG_VENDOR		0x0e
+#define _STAG_END		0x0f
+/* long tags */
+#define _LTAG_MEMRANGE		0x81
+#define _LTAG_ANSISTR		0x82
+#define _LTAG_UNICODESTR	0x83
+#define _LTAG_VENDOR		0x84
+#define _LTAG_MEM32RANGE	0x85
+#define _LTAG_FIXEDMEM32RANGE	0x86
+
+static unsigned char isapnp_checksum_value;
+static DECLARE_MUTEX(isapnp_cfg_mutex);
+static int isapnp_detected;
+
+/* some prototypes */
+
+static int isapnp_config_prepare(struct pnp_dev *dev);
+
+static inline void write_data(unsigned char x)
+{
+	outb(x, _PNPWRP);
+}
+
+static inline void write_address(unsigned char x)
+{
+	outb(x, _PIDXR);
+	udelay(20);
+}
+
+static inline unsigned char read_data(void)
+{
+	unsigned char val = inb(isapnp_rdp);
+	return val;
+}
+
+unsigned char isapnp_read_byte(unsigned char idx)
+{
+	write_address(idx);
+	return read_data();
+}
+
+unsigned short isapnp_read_word(unsigned char idx)
+{
+	unsigned short val;
+
+	val = isapnp_read_byte(idx);
+	val = (val << 8) + isapnp_read_byte(idx+1);
+	return val;
+}
+
+unsigned int isapnp_read_dword(unsigned char idx)
+{
+	unsigned int val;
+
+	val = isapnp_read_byte(idx);
+	val = (val << 8) + isapnp_read_byte(idx+1);
+	val = (val << 8) + isapnp_read_byte(idx+2);
+	val = (val << 8) + isapnp_read_byte(idx+3);
+	return val;
+}
+
+void isapnp_write_byte(unsigned char idx, unsigned char val)
+{
+	write_address(idx);
+	write_data(val);
+}
+
+void isapnp_write_word(unsigned char idx, unsigned short val)
+{
+	isapnp_write_byte(idx, val >> 8);
+	isapnp_write_byte(idx+1, val);
+}
+
+void isapnp_write_dword(unsigned char idx, unsigned int val)
+{
+	isapnp_write_byte(idx, val >> 24);
+	isapnp_write_byte(idx+1, val >> 16);
+	isapnp_write_byte(idx+2, val >> 8);
+	isapnp_write_byte(idx+3, val);
+}
+
+void *isapnp_alloc(long size)
+{
+	void *result;
+
+	result = kmalloc(size, GFP_KERNEL);
+	if (!result)
+		return NULL;
+	memset(result, 0, size);
+	return result;
+}
+
+static void isapnp_key(void)
+{
+	unsigned char code = 0x6a, msb;
+	int i;
+
+	mdelay(1);
+	write_address(0x00);
+	write_address(0x00);
+
+	write_address(code);
+
+	for (i = 1; i < 32; i++) {
+		msb = ((code & 0x01) ^ ((code & 0x02) >> 1)) << 7;
+		code = (code >> 1) | msb;
+		write_address(code);
+	}
+}
+
+/* place all pnp cards in wait-for-key state */
+static void isapnp_wait(void)
+{
+	isapnp_write_byte(0x02, 0x02);
+}
+
+void isapnp_wake(unsigned char csn)
+{
+	isapnp_write_byte(0x03, csn);
+}
+
+void isapnp_device(unsigned char logdev)
+{
+	isapnp_write_byte(0x07, logdev);
+}
+
+void isapnp_activate(unsigned char logdev)
+{
+	isapnp_device(logdev);
+	isapnp_write_byte(ISAPNP_CFG_ACTIVATE, 1);
+	udelay(250);
+}
+
+void isapnp_deactivate(unsigned char logdev)
+{
+	isapnp_device(logdev);
+	isapnp_write_byte(ISAPNP_CFG_ACTIVATE, 0);
+	udelay(500);
+}
+
+static void __init isapnp_peek(unsigned char *data, int bytes)
+{
+	int i, j;
+	unsigned char d=0;
+
+	for (i = 1; i <= bytes; i++) {
+		for (j = 0; j < 20; j++) {
+			d = isapnp_read_byte(0x05);
+			if (d & 1)
+				break;
+			udelay(100);
+		}
+		if (!(d & 1)) {
+			if (data != NULL)
+				*data++ = 0xff;
+			continue;
+		}
+		d = isapnp_read_byte(0x04);	/* PRESDI */
+		isapnp_checksum_value += d;
+		if (data != NULL)
+			*data++ = d;
+	}
+}
+
+#define RDP_STEP	32	/* minimum is 4 */
+
+static int isapnp_next_rdp(void)
+{
+	int rdp = isapnp_rdp;
+	while (rdp <= 0x3ff) {
+		/*
+		 *	We cannot use NE2000 probe spaces for ISAPnP or we
+		 *	will lock up machines.
+		 */
+		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1)) 
+		{
+			isapnp_rdp = rdp;
+			return 0;
+		}
+		rdp += RDP_STEP;
+	}
+	return -1;
+}
+
+/* Set read port address */
+static inline void isapnp_set_rdp(void)
+{
+	isapnp_write_byte(0x00, isapnp_rdp >> 2);
+	udelay(100);
+}
+
+/*
+ *	Perform an isolation. The port selection code now tries to avoid
+ *	"dangerous to read" ports.
+ */
+
+static int __init isapnp_isolate_rdp_select(void)
+{
+	isapnp_wait();
+	isapnp_key();
+
+	/* Control: reset CSN and conditionally everything else too */
+	isapnp_write_byte(0x02, isapnp_reset ? 0x05 : 0x04);
+	mdelay(2);
+
+	isapnp_wait();
+	isapnp_key();
+	isapnp_wake(0x00);
+
+	if (isapnp_next_rdp() < 0) {
+		isapnp_wait();
+		return -1;
+	}
+
+	isapnp_set_rdp();
+	udelay(1000);
+	write_address(0x01);
+	udelay(1000);
+	return 0;
+}
+
+/*
+ *  Isolate (assign uniqued CSN) to all ISA PnP devices.
+ */
+
+static int __init isapnp_isolate(void)
+{
+	unsigned char checksum = 0x6a;
+	unsigned char chksum = 0x00;
+	unsigned char bit = 0x00;
+	int data;
+	int csn = 0;
+	int i;
+	int iteration = 1;
+
+	isapnp_rdp = 0x213;
+	if (isapnp_isolate_rdp_select() < 0)
+		return -1;
+
+	while (1) {
+		for (i = 1; i <= 64; i++) {
+			data = read_data() << 8;
+			udelay(250);
+			data = data | read_data();
+			udelay(250);
+			if (data == 0x55aa)
+				bit = 0x01;
+			checksum = ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7) | (checksum >> 1);
+			bit = 0x00;
+		}
+		for (i = 65; i <= 72; i++) {
+			data = read_data() << 8;
+			udelay(250);
+			data = data | read_data();
+			udelay(250);
+			if (data == 0x55aa)
+				chksum |= (1 << (i - 65));
+		}
+		if (checksum != 0x00 && checksum == chksum) {
+			csn++;
+
+			isapnp_write_byte(0x06, csn);
+			udelay(250);
+			iteration++;
+			isapnp_wake(0x00);
+			isapnp_set_rdp();
+			udelay(1000);
+			write_address(0x01);
+			udelay(1000);
+			goto __next;
+		}
+		if (iteration == 1) {
+			isapnp_rdp += RDP_STEP;
+			if (isapnp_isolate_rdp_select() < 0)
+				return -1;
+		} else if (iteration > 1) {
+			break;
+		}
+	      __next:
+		checksum = 0x6a;
+		chksum = 0x00;
+		bit = 0x00;
+	}
+	isapnp_wait();
+	return csn;
+}
+
+/*
+ *  Read one tag from stream.
+ */
+
+static int __init isapnp_read_tag(unsigned char *type, unsigned short *size)
+{
+	unsigned char tag, tmp[2];
+
+	isapnp_peek(&tag, 1);
+	if (tag == 0)				/* invalid tag */
+		return -1;
+	if (tag & 0x80) {	/* large item */
+		*type = tag;
+		isapnp_peek(tmp, 2);
+		*size = (tmp[1] << 8) | tmp[0];
+	} else {
+		*type = (tag >> 3) & 0x0f;
+		*size = tag & 0x07;
+	}
+#if 0
+	printk(KERN_DEBUG "tag = 0x%x, type = 0x%x, size = %i\n", tag, *type, *size);
+#endif
+	if (type == 0)				/* wrong type */
+		return -1;
+	if (*type == 0xff && *size == 0xffff)	/* probably invalid data */
+		return -1;
+	return 0;
+}
+
+/*
+ *  Skip specified number of bytes from stream.
+ */
+
+static void __init isapnp_skip_bytes(int count)
+{
+	isapnp_peek(NULL, count);
+}
+
+/*
+ *  Parse EISA id.
+ */
+
+static void isapnp_parse_id(struct pnp_dev * dev, unsigned short vendor, unsigned short device)
+{
+	struct pnp_id * id = isapnp_alloc(sizeof(struct pnp_id));
+	if (!id)
+		return;
+	if (!dev)
+		return;
+	sprintf(id->id, "%c%c%c%x%x%x%x",
+			'A' + ((vendor >> 2) & 0x3f) - 1,
+			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+			'A' + ((vendor >> 8) & 0x1f) - 1,
+			(device >> 4) & 0x0f,
+			device & 0x0f,
+			(device >> 12) & 0x0f,
+			(device >> 8) & 0x0f);
+	pnp_add_id(id, dev);
+}
+
+/*
+ *  Parse logical device tag.
+ */
+
+static struct pnp_dev * __init isapnp_parse_device(struct pnp_card *card, int size, int number)
+{
+	unsigned char tmp[6];
+	struct pnp_dev *dev;
+
+	isapnp_peek(tmp, size);
+	dev = isapnp_alloc(sizeof(struct pnp_dev));
+	if (!dev)
+		return NULL;
+	pnp_init_device(dev);
+	dev->number = number;
+	isapnp_parse_id(dev, (tmp[1] << 8) | tmp[0], (tmp[3] << 8) | tmp[2]);
+	dev->regs = tmp[4];
+	dev->card = card;
+	if (size > 5)
+		dev->regs |= tmp[5] << 8;
+	return dev;
+}
+
+
+/*
+ *  Add IRQ resource to resources list.
+ */
+
+static void __init isapnp_add_irq_resource(struct pnp_dev *dev,
+                                               int depnum, int size)
+{
+	unsigned char tmp[3];
+	struct pnp_irq *irq;
+
+	isapnp_peek(tmp, size);
+	irq = isapnp_alloc(sizeof(struct pnp_irq));
+	if (!irq)
+		return;
+	irq->map = (tmp[1] << 8) | tmp[0];
+	if (size > 2)
+		irq->flags = tmp[2];
+	else
+		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
+	pnp_add_irq_resource(dev, depnum, irq);
+	return;
+}
+
+/*
+ *  Add DMA resource to resources list.
+ */
+
+static void __init isapnp_add_dma_resource(struct pnp_dev *dev,
+                                    	       int depnum, int size)
+{
+	unsigned char tmp[2];
+	struct pnp_dma *dma;
+
+	isapnp_peek(tmp, size);
+	dma = isapnp_alloc(sizeof(struct pnp_dma));
+	if (!dma)
+		return;
+	dma->map = tmp[0];
+	dma->flags = tmp[1];
+	pnp_add_dma_resource(dev, depnum, dma);
+	return;
+}
+
+/*
+ *  Add port resource to resources list.
+ */
+
+static void __init isapnp_add_port_resource(struct pnp_dev *dev,
+						int depnum, int size)
+{
+	unsigned char tmp[7];
+	struct pnp_port *port;
+
+	isapnp_peek(tmp, size);
+	port = isapnp_alloc(sizeof(struct pnp_port));
+	if (!port)
+		return;
+	port->min = (tmp[2] << 8) | tmp[1];
+	port->max = (tmp[4] << 8) | tmp[3];
+	port->align = tmp[5];
+	port->size = tmp[6];
+	port->flags = tmp[0] ? ISAPNP_PORT_FLAG_16BITADDR : 0;
+	pnp_add_port_resource(dev,depnum,port);
+	return;
+}
+
+/*
+ *  Add fixed port resource to resources list.
+ */
+
+static void __init isapnp_add_fixed_port_resource(struct pnp_dev *dev,
+						      int depnum, int size)
+{
+	unsigned char tmp[3];
+	struct pnp_port *port;
+
+	isapnp_peek(tmp, size);
+	port = isapnp_alloc(sizeof(struct pnp_port));
+	if (!port)
+		return;
+	port->min = port->max = (tmp[1] << 8) | tmp[0];
+	port->size = tmp[2];
+	port->align = 0;
+	port->flags = ISAPNP_PORT_FLAG_FIXED;
+	pnp_add_port_resource(dev,depnum,port);
+	return;
+}
+
+/*
+ *  Add memory resource to resources list.
+ */
+
+static void __init isapnp_add_mem_resource(struct pnp_dev *dev,
+					       int depnum, int size)
+{
+	unsigned char tmp[9];
+	struct pnp_mem *mem;
+
+	isapnp_peek(tmp, size);
+	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
+		return;
+	mem->min = ((tmp[2] << 8) | tmp[1]) << 8;
+	mem->max = ((tmp[4] << 8) | tmp[3]) << 8;
+	mem->align = (tmp[6] << 8) | tmp[5];
+	mem->size = ((tmp[8] << 8) | tmp[7]) << 8;
+	mem->flags = tmp[0];
+	pnp_add_mem_resource(dev,depnum,mem);
+	return;
+}
+
+/*
+ *  Add 32-bit memory resource to resources list.
+ */
+
+static void __init isapnp_add_mem32_resource(struct pnp_dev *dev,
+						 int depnum, int size)
+{
+	unsigned char tmp[17];
+	struct pnp_mem32 *mem32;
+
+	isapnp_peek(tmp, size);
+	mem32 = isapnp_alloc(sizeof(struct pnp_mem32));
+	if (!mem32)
+		return;
+	memcpy(mem32->data, tmp, 17);
+	pnp_add_mem32_resource(dev,depnum,mem32);
+}
+
+/*
+ *  Add 32-bit fixed memory resource to resources list.
+ */
+
+static void __init isapnp_add_fixed_mem32_resource(struct pnp_dev *dev,
+						       int depnum, int size)
+{
+	unsigned char tmp[17];
+	struct pnp_mem32 *mem32;
+
+	isapnp_peek(tmp, size);
+	mem32 = isapnp_alloc(sizeof(struct pnp_mem32));
+	if (!mem32)
+		return;
+	memcpy(mem32->data, tmp, 17);
+	pnp_add_mem32_resource(dev,depnum,mem32);
+}
+
+/*
+ *  Parse card name for ISA PnP device.
+ */ 
+ 
+static void __init 
+isapnp_parse_name(char *name, unsigned int name_max, unsigned short *size)
+{
+	if (name[0] == '\0') {
+		unsigned short size1 = *size >= name_max ? (name_max - 1) : *size;
+		isapnp_peek(name, size1);
+		name[size1] = '\0';
+		*size -= size1;
+		
+		/* clean whitespace from end of string */
+		while (size1 > 0  &&  name[--size1] == ' ')
+			name[size1] = '\0';
+	}	
+}
+
+/*
+ *  Parse resource map for logical device.
+ */
+
+static int __init isapnp_create_device(struct pnp_card *card,
+					   unsigned short size)
+{
+	int number = 0, skip = 0, depnum = 0, dependent = 0, compat = 0;
+	unsigned char type, tmp[17];
+	struct pnp_dev *dev;
+	if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
+		return 1;
+	if (pnp_build_resource(dev, 0) == NULL)
+		return 1;
+	list_add_tail(&dev->card_list, &card->devices);
+	while (1) {
+		if (isapnp_read_tag(&type, &size)<0)
+			return 1;
+		if (skip && type != _STAG_LOGDEVID && type != _STAG_END)
+			goto __skip;
+		switch (type) {
+		case _STAG_LOGDEVID:
+			if (size >= 5 && size <= 6) {
+				isapnp_config_prepare(dev);
+				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
+					return 1;
+				pnp_build_resource(dev,0);
+				list_add_tail(&dev->card_list, &card->devices);
+				size = 0;
+				skip = 0;
+			} else {
+				skip = 1;
+			}
+			dependent = 0;
+			depnum = 0;
+			compat = 0;
+			break;
+		case _STAG_COMPATDEVID:
+			if (size == 4 && compat < DEVICE_COUNT_COMPATIBLE) {
+				isapnp_peek(tmp, 4);
+				isapnp_parse_id(dev,(tmp[1] << 8) | tmp[0], (tmp[3] << 8) | tmp[2]);
+				compat++;
+				size = 0;
+			}
+			break;
+		case _STAG_IRQ:
+			if (size < 2 || size > 3)
+				goto __skip;
+			isapnp_add_irq_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _STAG_DMA:
+			if (size != 2)
+				goto __skip;
+			isapnp_add_dma_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _STAG_STARTDEP:
+			if (size > 1)
+				goto __skip;
+			dependent = 0x100 | ISAPNP_RES_PRIORITY_ACCEPTABLE;
+			if (size > 0) {
+				isapnp_peek(tmp, size);
+				dependent = 0x100 | tmp[0];
+				size = 0;
+			}
+			pnp_build_resource(dev,dependent);
+			depnum = pnp_get_max_depnum(dev);
+			break;
+		case _STAG_ENDDEP:
+			if (size != 0)
+				goto __skip;
+			dependent = 0;
+			depnum = 0;
+			break;
+		case _STAG_IOPORT:
+			if (size != 7)
+				goto __skip;
+			isapnp_add_port_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _STAG_FIXEDIO:
+			if (size != 3)
+				goto __skip;
+			isapnp_add_fixed_port_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _STAG_VENDOR:
+			break;
+		case _LTAG_MEMRANGE:
+			if (size != 9)
+				goto __skip;
+			isapnp_add_mem_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _LTAG_ANSISTR:
+			isapnp_parse_name(dev->name, sizeof(dev->name), &size);
+			break;
+		case _LTAG_UNICODESTR:
+			/* silently ignore */
+			/* who use unicode for hardware identification? */
+			break;
+		case _LTAG_VENDOR:
+			break;
+		case _LTAG_MEM32RANGE:
+			if (size != 17)
+				goto __skip;
+			isapnp_add_mem32_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _LTAG_FIXEDMEM32RANGE:
+			if (size != 17)
+				goto __skip;
+			isapnp_add_fixed_mem32_resource(dev, depnum, size);
+			size = 0;
+			break;
+		case _STAG_END:
+			if (size > 0)
+				isapnp_skip_bytes(size);
+			isapnp_config_prepare(dev);
+			return 1;
+		default:
+			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n", type, dev->number, card->number);
+		}
+	      __skip:
+	      	if (size > 0)
+		      	isapnp_skip_bytes(size);
+	}
+	isapnp_config_prepare(dev);
+	return 0;
+}
+
+/*
+ *  Parse resource map for ISA PnP card.
+ */
+ 
+static void __init isapnp_parse_resource_map(struct pnp_card *card)
+{
+	unsigned char type, tmp[17];
+	unsigned short size;
+
+	while (1) {
+		if (isapnp_read_tag(&type, &size)<0)
+			return;
+		switch (type) {
+		case _STAG_PNPVERNO:
+			if (size != 2)
+				goto __skip;
+			isapnp_peek(tmp, 2);
+			card->pnpver = tmp[0];
+			card->productver = tmp[1];
+			size = 0;
+			break;
+		case _STAG_LOGDEVID:
+			if (size >= 5 && size <= 6) {
+				if (isapnp_create_device(card, size)==1)
+					return;
+				size = 0;
+			}
+			break;
+		case _STAG_VENDOR:
+			break;
+		case _LTAG_ANSISTR:
+			isapnp_parse_name(card->name, sizeof(card->name), &size);
+			break;
+		case _LTAG_UNICODESTR:
+			/* silently ignore */
+			/* who use unicode for hardware identification? */
+			break;
+		case _LTAG_VENDOR:
+			break;
+		case _STAG_END:
+			if (size > 0)
+				isapnp_skip_bytes(size);
+			return;
+		default:
+			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for device %i, ignored\n", type, card->number);
+		}
+	      __skip:
+	      	if (size > 0)
+		      	isapnp_skip_bytes(size);
+	}
+}
+
+/*
+ *  Compute ISA PnP checksum for first eight bytes.
+ */
+
+static unsigned char __init isapnp_checksum(unsigned char *data)
+{
+	int i, j;
+	unsigned char checksum = 0x6a, bit, b;
+	
+	for (i = 0; i < 8; i++) {
+		b = data[i];
+		for (j = 0; j < 8; j++) {
+			bit = 0;
+			if (b & (1 << j))
+				bit = 1;
+			checksum = ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7) | (checksum >> 1);
+		}
+	}
+	return checksum;
+}
+
+/*
+ *  Parse EISA id for ISA PnP card.
+ */
+
+static void isapnp_parse_card_id(struct pnp_card * card, unsigned short vendor, unsigned short device)
+{
+	struct pnp_id * id = isapnp_alloc(sizeof(struct pnp_id));
+	if (!id)
+		return;
+	sprintf(id->id, "%c%c%c%x%x%x%x",
+			'A' + ((vendor >> 2) & 0x3f) - 1,
+			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+			'A' + ((vendor >> 8) & 0x1f) - 1,
+			(device >> 4) & 0x0f,
+			device & 0x0f,
+			(device >> 12) & 0x0f,
+			(device >> 8) & 0x0f);
+	list_add_tail(&id->id_list,&card->ids);
+}
+
+/*
+ *  Build device list for all present ISA PnP devices.
+ */
+
+static int __init isapnp_build_device_list(void)
+{
+	int csn;
+	unsigned char header[9], checksum;
+	struct pnp_card *card;
+
+	isapnp_wait();
+	isapnp_key();
+	for (csn = 1; csn <= 10; csn++) {
+		isapnp_wake(csn);
+		isapnp_peek(header, 9);
+		checksum = isapnp_checksum(header);
+#if 0
+		printk(KERN_DEBUG "vendor: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+			header[0], header[1], header[2], header[3],
+			header[4], header[5], header[6], header[7], header[8]);
+		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
+#endif
+		/* Don't be strict on the checksum, here !
+                   e.g. 'SCM SwapBox Plug and Play' has header[8]==0 (should be: b7)*/
+		if (header[8] == 0)
+			;
+		else if (checksum == 0x00 || checksum != header[8])	/* not valid CSN */
+			continue;
+		if ((card = isapnp_alloc(sizeof(struct pci_bus))) == NULL)
+			continue;
+
+		card->number = csn;
+		INIT_LIST_HEAD(&card->devices);
+		INIT_LIST_HEAD(&card->ids);
+		isapnp_parse_card_id(card, (header[1] << 8) | header[0], (header[3] << 8) | header[2]);
+		card->serial = (header[7] << 24) | (header[6] << 16) | (header[5] << 8) | header[4];
+		isapnp_checksum_value = 0x00;
+		isapnp_parse_resource_map(card);
+		if (isapnp_checksum_value != 0x00)
+			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
+		card->checksum = isapnp_checksum_value;
+
+		list_add_tail(&card->node, &isapnp_cards);
+	}
+	return 0;
+}
+
+/*
+ *  Basic configuration routines.
+ */
+
+int isapnp_present(void)
+{
+	return !list_empty(&isapnp_devices);
+}
+
+int isapnp_cfg_begin(int csn, int logdev)
+{
+	if (csn < 1 || csn > 10 || logdev > 10)
+		return -EINVAL;
+	MOD_INC_USE_COUNT;
+	down(&isapnp_cfg_mutex);
+	isapnp_wait();
+	isapnp_key();
+	isapnp_wake(csn);
+#if 0
+	/* to avoid malfunction when the isapnptools package is used */
+	/* we must set RDP to our value again */
+	/* it is possible to set RDP only in the isolation phase */
+	/*   Jens Thoms Toerring <Jens.Toerring-1Olz3AKvcsuAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org> */
+	isapnp_write_byte(0x02, 0x04);	/* clear CSN of card */
+	mdelay(2);			/* is this necessary? */
+	isapnp_wake(csn);		/* bring card into sleep state */
+	isapnp_wake(0);			/* bring card into isolation state */
+	isapnp_set_rdp();		/* reset the RDP port */
+	udelay(1000);			/* delay 1000us */
+	isapnp_write_byte(0x06, csn);	/* reset CSN to previous value */
+	udelay(250);			/* is this necessary? */
+#endif
+	if (logdev >= 0)
+		isapnp_device(logdev);
+	return 0;
+}
+
+int isapnp_cfg_end(void)
+{
+	isapnp_wait();
+	up(&isapnp_cfg_mutex);
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static int isapnp_config_prepare(struct pnp_dev *dev)
+{
+	int idx;
+	if (dev == NULL)
+		return -EINVAL;
+	if (dev->active || dev->ro)
+		return -EBUSY;
+	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
+		dev->irq_resource[idx].name = NULL;
+		dev->irq_resource[idx].start = -1;
+		dev->irq_resource[idx].end = -1;
+		dev->irq_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++) {
+		dev->dma_resource[idx].name = NULL;
+		dev->dma_resource[idx].start = -1;
+		dev->dma_resource[idx].end = -1;
+		dev->dma_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++) {
+		dev->resource[idx].name = NULL;
+		dev->resource[idx].start = 0;
+		dev->resource[idx].end = 0;
+		dev->resource[idx].flags = 0;
+	}
+	return 0;
+}
+
+void isapnp_resource_change(struct resource *resource,
+			    unsigned long start,
+			    unsigned long size)
+{
+	if (resource == NULL)
+		return;
+	resource->flags &= ~IORESOURCE_AUTO;
+	resource->start = start;
+	resource->end = start + size - 1;
+}
+
+/*
+ *  Inititialization.
+ */
+
+
+EXPORT_SYMBOL(isapnp_cards);
+EXPORT_SYMBOL(isapnp_devices);
+EXPORT_SYMBOL(isapnp_present);
+EXPORT_SYMBOL(isapnp_cfg_begin);
+EXPORT_SYMBOL(isapnp_cfg_end);
+EXPORT_SYMBOL(isapnp_read_byte);
+EXPORT_SYMBOL(isapnp_read_word);
+EXPORT_SYMBOL(isapnp_read_dword);
+EXPORT_SYMBOL(isapnp_write_byte);
+EXPORT_SYMBOL(isapnp_write_word);
+EXPORT_SYMBOL(isapnp_write_dword);
+EXPORT_SYMBOL(isapnp_wake);
+EXPORT_SYMBOL(isapnp_device);
+EXPORT_SYMBOL(isapnp_resource_change);
+
+static int isapnp_get_resources(struct pnp_dev *dev)
+{
+	/* We don't need to do anything but this, the rest is taken care of */
+	if ((dev->resource[0].start == 0) &&
+	    (dev->irq_resource[0].start == -1) &&
+	    (dev->dma_resource[0].start == -1))
+		dev->active = 0;
+	else
+		dev->active = 1;
+	return 0;
+}
+
+static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_cfg *cfg, char flags)
+{
+	int tmp;
+      	isapnp_cfg_begin(dev->card->number, dev->number);
+	dev->active = 1;
+	dev->irq_resource[0] = cfg->request.irq_resource[0];
+	dev->irq_resource[1] = cfg->request.irq_resource[1];
+	dev->dma_resource[0] = cfg->request.dma_resource[0];
+	dev->dma_resource[1] = cfg->request.dma_resource[1];
+	for (tmp = 0; tmp < 12; tmp++) {
+		dev->resource[tmp] = cfg->request.resource[tmp];
+	}
+	for (tmp = 0; tmp < 8 && dev->resource[tmp].flags; tmp++)
+		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), dev->resource[tmp].start);
+	for (tmp = 0; tmp < 2 && dev->irq_resource[tmp].flags; tmp++) {
+		int irq = dev->irq_resource[tmp].start;
+		if (irq == 2)
+			irq = 9;
+		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
+	}
+	for (tmp = 0; tmp < 2 && dev->dma_resource[tmp].flags; tmp++)
+		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, dev->dma_resource[tmp].start);
+	for (tmp = 0; tmp < 4 && dev->resource[tmp+8].flags; tmp++)
+		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (dev->resource[tmp + 8].start >> 8) & 0xffff);
+	isapnp_activate(dev->number);
+	isapnp_cfg_end();
+	return 0;
+}
+
+static int isapnp_disable_resources(struct pnp_dev *dev)
+{
+	if (!dev || !dev->active)
+		return -EINVAL;
+      	isapnp_cfg_begin(dev->card->number, dev->number);
+	isapnp_deactivate(dev->number);
+	dev->active = 0;
+	isapnp_cfg_end();
+	return 0;
+}
+
+struct pnp_protocol isapnp_protocol = {
+	name:	"ISA Plug and Play",
+	get:	isapnp_get_resources,
+	set:	isapnp_set_resources,
+	disable:isapnp_disable_resources,
+};
+
+static inline int isapnp_init_device_tree(void)
+{
+
+	struct pnp_card *card;
+
+	isapnp_for_each_card(card) {
+		struct list_head *devlist;
+		for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
+			struct pnp_dev *dev = card_to_pnp_dev(devlist);
+			snprintf(dev->dev.name, sizeof(dev->dev.name), "%s", dev->name);
+			dev->card = card;
+			dev->protocol = &isapnp_protocol;
+			pnp_add_device(dev);
+		}
+	}
+
+	return 0;
+}
+
+int __init isapnp_init(void)
+{
+	int cards;
+	struct pnp_card *card;
+
+	if (isapnp_disable) {
+		isapnp_detected = 0;
+		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
+		return 0;
+	}
+#ifdef ISAPNP_REGION_OK
+	if (!request_region(_PIDXR, 1, "isapnp index")) {
+		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n", _PIDXR);
+		return -EBUSY;
+	}
+#endif
+	if (!request_region(_PNPWRP, 1, "isapnp write")) {
+		printk(KERN_ERR "isapnp: Write Data Register 0x%x already used\n", _PNPWRP);
+#ifdef ISAPNP_REGION_OK
+		release_region(_PIDXR, 1);
+#endif
+		return -EBUSY;
+	}
+
+	if(pnp_protocol_register(&isapnp_protocol)<0)
+		return -EBUSY;
+
+	/*
+	 *	Print a message. The existing ISAPnP code is hanging machines
+	 *	so let the user know where.
+	 */
+	 
+	printk(KERN_INFO "isapnp: Scanning for PnP cards...\n");
+	if (isapnp_rdp >= 0x203 && isapnp_rdp <= 0x3ff) {
+		isapnp_rdp |= 3;
+		if (!request_region(isapnp_rdp, 1, "isapnp read")) {
+			printk(KERN_ERR "isapnp: Read Data Register 0x%x already used\n", isapnp_rdp);
+#ifdef ISAPNP_REGION_OK
+			release_region(_PIDXR, 1);
+#endif
+			release_region(_PNPWRP, 1);
+			return -EBUSY;
+		}
+		isapnp_set_rdp();
+	}
+	isapnp_detected = 1;
+	if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
+		cards = isapnp_isolate();
+		if (cards < 0 || 
+		    (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
+#ifdef ISAPNP_REGION_OK
+			release_region(_PIDXR, 1);
+#endif
+			release_region(_PNPWRP, 1);
+			isapnp_detected = 0;
+			printk(KERN_INFO "isapnp: No Plug & Play device found\n");
+			return 0;
+		}
+		request_region(isapnp_rdp, 1, "isapnp read");
+	}
+	isapnp_build_device_list();
+	cards = 0;
+
+	isapnp_for_each_card(card) {
+		cards++;
+		if (isapnp_verbose) {
+			struct list_head *devlist;
+			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
+			if (isapnp_verbose < 2)
+				continue;
+			for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
+				struct pci_dev *dev = pci_dev_b(devlist);
+				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->name[0]?card->name:"Unknown");
+			}
+		}
+	}
+	if (cards) {
+		printk(KERN_INFO "isapnp: %i Plug & Play card%s detected total\n", cards, cards>1?"s":"");
+	} else {
+		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
+	}
+
+	isapnp_init_device_tree();
+	isapnp_proc_init();
+	return 0;
+}
+
+subsys_initcall(isapnp_init);
+
+/* format is: noisapnp */
+
+static int __init isapnp_setup_disable(char *str)
+{
+	isapnp_disable = 1;
+	return 1;
+}
+
+__setup("noisapnp", isapnp_setup_disable);
+
+/* format is: isapnp=rdp,reset,skip_pci_scan,verbose */
+
+static int __init isapnp_setup_isapnp(char *str)
+{
+	(void)((get_option(&str,&isapnp_rdp) == 2) &&
+	       (get_option(&str,&isapnp_reset) == 2) &&
+	       (get_option(&str,&isapnp_skip_pci_scan) == 2) &&
+	       (get_option(&str,&isapnp_verbose) == 2));
+	return 1;
+}
+
+__setup("isapnp=", isapnp_setup_isapnp);
+
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
--- a/drivers/pnp/isapnp/proc.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/isapnp/proc.c	Mon Oct 14 19:20:39 2002
@@ -0,0 +1,171 @@
+/*
+ *  ISA Plug & Play support
+ *  Copyright (c) by Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+
+#include <linux/isapnp.h>
+#include <linux/pnp.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <asm/uaccess.h>
+
+
+static struct proc_dir_entry *isapnp_proc_bus_dir = NULL;
+
+static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int whence)
+{
+	loff_t new = -1;
+
+	lock_kernel();
+	switch (whence) {
+	case 0:
+		new = off;
+		break;
+	case 1:
+		new = file->f_pos + off;
+		break;
+	case 2:
+		new = 256 + off;
+		break;
+	}
+	if (new < 0 || new > 256) {
+		unlock_kernel();
+		return -EINVAL;
+	}
+	unlock_kernel();
+	return (file->f_pos = new);
+}
+
+static ssize_t isapnp_proc_bus_read(struct file *file, char *buf, size_t nbytes, loff_t *ppos)
+{
+	struct inode *ino = file->f_dentry->d_inode;
+	struct proc_dir_entry *dp = PDE(ino);
+	struct pnp_dev *dev = dp->data;
+	int pos = *ppos;
+	int cnt, size = 256;
+
+	if (pos >= size)
+		return 0;
+	if (nbytes >= size)
+		nbytes = size;
+	if (pos + nbytes > size)
+		nbytes = size - pos;
+	cnt = nbytes;
+
+	if (!access_ok(VERIFY_WRITE, buf, cnt))
+		return -EINVAL;
+
+	isapnp_cfg_begin(dev->card->number, dev->number);
+	for ( ; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
+		unsigned char val;
+		val = isapnp_read_byte(pos);
+		__put_user(val, buf);
+	}
+	isapnp_cfg_end();
+
+	*ppos = pos;
+	return nbytes;
+}
+
+static struct file_operations isapnp_proc_bus_file_operations =
+{
+	llseek:		isapnp_proc_bus_lseek,
+	read:		isapnp_proc_bus_read,
+};
+
+static int isapnp_proc_attach_device(struct pnp_dev *dev)
+{
+	struct pnp_card *bus = dev->card;
+	struct proc_dir_entry *de, *e;
+	char name[16];
+
+	if (!(de = bus->procdir)) {
+		sprintf(name, "%02x", bus->number);
+		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
+		if (!de)
+			return -ENOMEM;
+	}
+	sprintf(name, "%02x", dev->number);
+	e = dev->procent = create_proc_entry(name, S_IFREG | S_IRUGO, de);
+	if (!e)
+		return -ENOMEM;
+	e->proc_fops = &isapnp_proc_bus_file_operations;
+	e->owner = THIS_MODULE;
+	e->data = dev;
+	e->size = 256;
+	return 0;
+}
+
+#ifdef MODULE
+static int __exit isapnp_proc_detach_device(struct pnp_dev *dev)
+{
+	struct pnp_card *bus = dev->card;
+	struct proc_dir_entry *de;
+	char name[16];
+
+	if (!(de = bus->procdir))
+		return -EINVAL;
+	sprintf(name, "%02x", dev->number);
+	remove_proc_entry(name, de);
+	return 0;
+}
+
+static int __exit isapnp_proc_detach_bus(struct pnp_card *bus)
+{
+	struct proc_dir_entry *de;
+	char name[16];
+
+	if (!(de = bus->procdir))
+		return -EINVAL;
+	sprintf(name, "%02x", bus->number);
+	remove_proc_entry(name, isapnp_proc_bus_dir);
+	return 0;
+}
+#endif /* MODULE */
+
+int __init isapnp_proc_init(void)
+{
+	struct pnp_dev *dev;
+	isapnp_proc_bus_dir = proc_mkdir("isapnp", proc_bus);
+	isapnp_for_each_dev(dev) {
+		isapnp_proc_attach_device(dev);
+	}
+	return 0;
+}
+
+#ifdef MODULE
+int __exit isapnp_proc_done(void)
+{
+	struct pnp_dev *dev;
+	struct pnp_bus *card;
+
+	isapnp_for_each_dev(dev) {
+		isapnp_proc_detach_device(dev);
+	}
+	isapnp_for_each_card(card) {
+		isapnp_proc_detach_bus(card);
+	}
+	if (isapnp_proc_bus_dir)
+		remove_proc_entry("isapnp", proc_bus);
+	return 0;
+}
+#endif /* MODULE */
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp.c b/drivers/pnp/isapnp.c
--- a/drivers/pnp/isapnp.c	Tue Oct 15 17:31:32 2002
+++ b/drivers/pnp/isapnp.c	Thu Jan  1 00:00:00 1970
@@ -1,2514 +0,0 @@
-/*
- *  ISA Plug & Play support
- *  Copyright (c) by Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *  Changelog:
- *  2000-01-01	Added quirks handling for buggy hardware
- *		Peter Denison <peterd-ELNARaTYPWWHCRyBVyKX4rVCufUGDwFn@public.gmane.org>
- *  2000-06-14	Added isapnp_probe_devs() and isapnp_activate_dev()
- *		Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
- *  2001-06-03  Added release_region calls to correspond with
- *		request_region calls when a failure occurs.  Also
- *		added KERN_* constants to printk() calls.
- *  2001-11-07  Added isapnp_{,un}register_driver calls along the lines
- *              of the pci driver interface
- *              Kai Germaschewski <kai.germaschewski-Mmb7MZpHnFY@public.gmane.org>
- *  2002-06-06  Made the use of dma channel 0 configurable 
- *              Gerald Teschl <gerald.teschl-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
- */
-
-#include <linux/config.h>
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-#include <asm/irq.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/isapnp.h>
-
-LIST_HEAD(isapnp_cards);
-LIST_HEAD(isapnp_devices);
-
-#if 0
-#define ISAPNP_REGION_OK
-#endif
-#if 0
-#define ISAPNP_DEBUG
-#endif
-
-int isapnp_disable;			/* Disable ISA PnP */
-int isapnp_rdp;				/* Read Data Port */
-int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
-int isapnp_allow_dma0 = -1;		/* allow dma 0 during auto activation: -1=off (:default), 0=off (set by user), 1=on */
-int isapnp_skip_pci_scan;		/* skip PCI resource scanning */
-int isapnp_verbose = 1;			/* verbose mode */
-int isapnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
-int isapnp_reserve_dma[8] = { [0 ... 7] = -1 };		/* reserve (don't use) some DMA */
-int isapnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
-int isapnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
-
-MODULE_AUTHOR("Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>");
-MODULE_DESCRIPTION("Generic ISA Plug & Play support");
-MODULE_PARM(isapnp_disable, "i");
-MODULE_PARM_DESC(isapnp_disable, "ISA Plug & Play disable");
-MODULE_PARM(isapnp_rdp, "i");
-MODULE_PARM_DESC(isapnp_rdp, "ISA Plug & Play read data port");
-MODULE_PARM(isapnp_reset, "i");
-MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
-MODULE_PARM(isapnp_allow_dma0, "i");
-MODULE_PARM_DESC(isapnp_allow_dma0, "Allow dma value 0 during auto activation");
-MODULE_PARM(isapnp_skip_pci_scan, "i");
-MODULE_PARM_DESC(isapnp_skip_pci_scan, "ISA Plug & Play skip PCI resource scanning");
-MODULE_PARM(isapnp_verbose, "i");
-MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
-MODULE_PARM(isapnp_reserve_irq, "1-16i");
-MODULE_PARM_DESC(isapnp_reserve_irq, "ISA Plug & Play - reserve IRQ line(s)");
-MODULE_PARM(isapnp_reserve_dma, "1-8i");
-MODULE_PARM_DESC(isapnp_reserve_dma, "ISA Plug & Play - reserve DMA channel(s)");
-MODULE_PARM(isapnp_reserve_io, "1-16i");
-MODULE_PARM_DESC(isapnp_reserve_io, "ISA Plug & Play - reserve I/O region(s) - port,size");
-MODULE_PARM(isapnp_reserve_mem, "1-16i");
-MODULE_PARM_DESC(isapnp_reserve_mem, "ISA Plug & Play - reserve memory region(s) - address,size");
-MODULE_LICENSE("GPL");
-
-#define _PIDXR		0x279
-#define _PNPWRP		0xa79
-
-/* short tags */
-#define _STAG_PNPVERNO		0x01
-#define _STAG_LOGDEVID		0x02
-#define _STAG_COMPATDEVID	0x03
-#define _STAG_IRQ		0x04
-#define _STAG_DMA		0x05
-#define _STAG_STARTDEP		0x06
-#define _STAG_ENDDEP		0x07
-#define _STAG_IOPORT		0x08
-#define _STAG_FIXEDIO		0x09
-#define _STAG_VENDOR		0x0e
-#define _STAG_END		0x0f
-/* long tags */
-#define _LTAG_MEMRANGE		0x81
-#define _LTAG_ANSISTR		0x82
-#define _LTAG_UNICODESTR	0x83
-#define _LTAG_VENDOR		0x84
-#define _LTAG_MEM32RANGE	0x85
-#define _LTAG_FIXEDMEM32RANGE	0x86
-
-static unsigned char isapnp_checksum_value;
-static DECLARE_MUTEX(isapnp_cfg_mutex);
-static int isapnp_detected;
-
-/* some prototypes */
-
-static int isapnp_config_prepare(struct pci_dev *dev);
-static int isapnp_config_activate(struct pci_dev *dev);
-static int isapnp_config_deactivate(struct pci_dev *dev);
-
-static inline void write_data(unsigned char x)
-{
-	outb(x, _PNPWRP);
-}
-
-static inline void write_address(unsigned char x)
-{
-	outb(x, _PIDXR);
-	udelay(20);
-}
-
-static inline unsigned char read_data(void)
-{
-	unsigned char val = inb(isapnp_rdp);
-	return val;
-}
-
-unsigned char isapnp_read_byte(unsigned char idx)
-{
-	write_address(idx);
-	return read_data();
-}
-
-unsigned short isapnp_read_word(unsigned char idx)
-{
-	unsigned short val;
-
-	val = isapnp_read_byte(idx);
-	val = (val << 8) + isapnp_read_byte(idx+1);
-	return val;
-}
-
-unsigned int isapnp_read_dword(unsigned char idx)
-{
-	unsigned int val;
-
-	val = isapnp_read_byte(idx);
-	val = (val << 8) + isapnp_read_byte(idx+1);
-	val = (val << 8) + isapnp_read_byte(idx+2);
-	val = (val << 8) + isapnp_read_byte(idx+3);
-	return val;
-}
-
-void isapnp_write_byte(unsigned char idx, unsigned char val)
-{
-	write_address(idx);
-	write_data(val);
-}
-
-void isapnp_write_word(unsigned char idx, unsigned short val)
-{
-	isapnp_write_byte(idx, val >> 8);
-	isapnp_write_byte(idx+1, val);
-}
-
-void isapnp_write_dword(unsigned char idx, unsigned int val)
-{
-	isapnp_write_byte(idx, val >> 24);
-	isapnp_write_byte(idx+1, val >> 16);
-	isapnp_write_byte(idx+2, val >> 8);
-	isapnp_write_byte(idx+3, val);
-}
-
-void *isapnp_alloc(long size)
-{
-	void *result;
-
-	result = kmalloc(size, GFP_KERNEL);
-	if (!result)
-		return NULL;
-	memset(result, 0, size);
-	return result;
-}
-
-static void isapnp_key(void)
-{
-	unsigned char code = 0x6a, msb;
-	int i;
-
-	mdelay(1);
-	write_address(0x00);
-	write_address(0x00);
-
-	write_address(code);
-
-	for (i = 1; i < 32; i++) {
-		msb = ((code & 0x01) ^ ((code & 0x02) >> 1)) << 7;
-		code = (code >> 1) | msb;
-		write_address(code);
-	}
-}
-
-/* place all pnp cards in wait-for-key state */
-static void isapnp_wait(void)
-{
-	isapnp_write_byte(0x02, 0x02);
-}
-
-void isapnp_wake(unsigned char csn)
-{
-	isapnp_write_byte(0x03, csn);
-}
-
-void isapnp_device(unsigned char logdev)
-{
-	isapnp_write_byte(0x07, logdev);
-}
-
-void isapnp_activate(unsigned char logdev)
-{
-	isapnp_device(logdev);
-	isapnp_write_byte(ISAPNP_CFG_ACTIVATE, 1);
-	udelay(250);
-}
-
-void isapnp_deactivate(unsigned char logdev)
-{
-	isapnp_device(logdev);
-	isapnp_write_byte(ISAPNP_CFG_ACTIVATE, 0);
-	udelay(500);
-}
-
-static void __init isapnp_peek(unsigned char *data, int bytes)
-{
-	int i, j;
-	unsigned char d=0;
-
-	for (i = 1; i <= bytes; i++) {
-		for (j = 0; j < 20; j++) {
-			d = isapnp_read_byte(0x05);
-			if (d & 1)
-				break;
-			udelay(100);
-		}
-		if (!(d & 1)) {
-			if (data != NULL)
-				*data++ = 0xff;
-			continue;
-		}
-		d = isapnp_read_byte(0x04);	/* PRESDI */
-		isapnp_checksum_value += d;
-		if (data != NULL)
-			*data++ = d;
-	}
-}
-
-#define RDP_STEP	32	/* minimum is 4 */
-
-static int isapnp_next_rdp(void)
-{
-	int rdp = isapnp_rdp;
-	while (rdp <= 0x3ff) {
-		/*
-		 *	We cannot use NE2000 probe spaces for ISAPnP or we
-		 *	will lock up machines.
-		 */
-		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1)) 
-		{
-			isapnp_rdp = rdp;
-			return 0;
-		}
-		rdp += RDP_STEP;
-	}
-	return -1;
-}
-
-/* Set read port address */
-static inline void isapnp_set_rdp(void)
-{
-	isapnp_write_byte(0x00, isapnp_rdp >> 2);
-	udelay(100);
-}
-
-/*
- *	Perform an isolation. The port selection code now tries to avoid
- *	"dangerous to read" ports.
- */
-
-static int __init isapnp_isolate_rdp_select(void)
-{
-	isapnp_wait();
-	isapnp_key();
-
-	/* Control: reset CSN and conditionally everything else too */
-	isapnp_write_byte(0x02, isapnp_reset ? 0x05 : 0x04);
-	mdelay(2);
-
-	isapnp_wait();
-	isapnp_key();
-	isapnp_wake(0x00);
-
-	if (isapnp_next_rdp() < 0) {
-		isapnp_wait();
-		return -1;
-	}
-
-	isapnp_set_rdp();
-	udelay(1000);
-	write_address(0x01);
-	udelay(1000);
-	return 0;
-}
-
-/*
- *  Isolate (assign uniqued CSN) to all ISA PnP devices.
- */
-
-static int __init isapnp_isolate(void)
-{
-	unsigned char checksum = 0x6a;
-	unsigned char chksum = 0x00;
-	unsigned char bit = 0x00;
-	int data;
-	int csn = 0;
-	int i;
-	int iteration = 1;
-
-	isapnp_rdp = 0x213;
-	if (isapnp_isolate_rdp_select() < 0)
-		return -1;
-
-	while (1) {
-		for (i = 1; i <= 64; i++) {
-			data = read_data() << 8;
-			udelay(250);
-			data = data | read_data();
-			udelay(250);
-			if (data == 0x55aa)
-				bit = 0x01;
-			checksum = ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7) | (checksum >> 1);
-			bit = 0x00;
-		}
-		for (i = 65; i <= 72; i++) {
-			data = read_data() << 8;
-			udelay(250);
-			data = data | read_data();
-			udelay(250);
-			if (data == 0x55aa)
-				chksum |= (1 << (i - 65));
-		}
-		if (checksum != 0x00 && checksum == chksum) {
-			csn++;
-
-			isapnp_write_byte(0x06, csn);
-			udelay(250);
-			iteration++;
-			isapnp_wake(0x00);
-			isapnp_set_rdp();
-			udelay(1000);
-			write_address(0x01);
-			udelay(1000);
-			goto __next;
-		}
-		if (iteration == 1) {
-			isapnp_rdp += RDP_STEP;
-			if (isapnp_isolate_rdp_select() < 0)
-				return -1;
-		} else if (iteration > 1) {
-			break;
-		}
-	      __next:
-		checksum = 0x6a;
-		chksum = 0x00;
-		bit = 0x00;
-	}
-	isapnp_wait();
-	return csn;
-}
-
-/*
- *  Read one tag from stream.
- */
-
-static int __init isapnp_read_tag(unsigned char *type, unsigned short *size)
-{
-	unsigned char tag, tmp[2];
-
-	isapnp_peek(&tag, 1);
-	if (tag == 0)				/* invalid tag */
-		return -1;
-	if (tag & 0x80) {	/* large item */
-		*type = tag;
-		isapnp_peek(tmp, 2);
-		*size = (tmp[1] << 8) | tmp[0];
-	} else {
-		*type = (tag >> 3) & 0x0f;
-		*size = tag & 0x07;
-	}
-#if 0
-	printk(KERN_DEBUG "tag = 0x%x, type = 0x%x, size = %i\n", tag, *type, *size);
-#endif
-	if (type == 0)				/* wrong type */
-		return -1;
-	if (*type == 0xff && *size == 0xffff)	/* probably invalid data */
-		return -1;
-	return 0;
-}
-
-/*
- *  Skip specified number of bytes from stream.
- */
- 
-static void __init isapnp_skip_bytes(int count)
-{
-	isapnp_peek(NULL, count);
-}
-
-/*
- *  Parse logical device tag.
- */
-
-static struct pci_dev * __init isapnp_parse_device(struct pci_bus *card, int size, int number)
-{
-	unsigned char tmp[6];
-	struct pci_dev *dev;
-
-	isapnp_peek(tmp, size);
-	dev = isapnp_alloc(sizeof(struct pci_dev));
-	if (!dev)
-		return NULL;
-	dev->dma_mask = 0x00ffffff;
-	dev->devfn = number;
-	dev->vendor = (tmp[1] << 8) | tmp[0];
-	dev->device = (tmp[3] << 8) | tmp[2];
-	dev->regs = tmp[4];
-	dev->bus = card;
-	if (size > 5)
-		dev->regs |= tmp[5] << 8;
-	dev->prepare = isapnp_config_prepare;
-	dev->activate = isapnp_config_activate;
-	dev->deactivate = isapnp_config_deactivate;
-	return dev;
-}
-
-/*
- *  Build new resources structure
- */
-
-static struct isapnp_resources * __init isapnp_build_resources(struct pci_dev *dev, int dependent)
-{
-	struct isapnp_resources *res, *ptr, *ptra;
-	
-	res = isapnp_alloc(sizeof(struct isapnp_resources));
-	if (!res)
-		return NULL;
-	res->dev = dev;
-	ptr = (struct isapnp_resources *)dev->sysdata;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr && ptr->dependent && dependent) { /* add to another list */
-		ptra = ptr->alt;
-		while (ptra && ptra->alt)
-			ptra = ptra->alt;
-		if (!ptra)
-			ptr->alt = res;
-		else
-			ptra->alt = res;
-	} else {
-		if (!ptr)
-			dev->sysdata = res;
-		else
-			ptr->next = res;
-	}
-	if (dependent) {
-		res->priority = dependent & 0xff;
-		if (res->priority > ISAPNP_RES_PRIORITY_FUNCTIONAL)
-			res->priority = ISAPNP_RES_PRIORITY_INVALID;
-		res->dependent = 1;
-	} else {
-		res->priority = ISAPNP_RES_PRIORITY_PREFERRED;
-		res->dependent = 0;
-	}
-	return res;
-}
-
-/*
- *  Add IRQ resource to resources list.
- */
-
-static void __init isapnp_add_irq_resource(struct pci_dev *dev,
-                                    	       struct isapnp_resources **res,
-                                               int dependent, int size)
-{
-	unsigned char tmp[3];
-	int i;
-	struct isapnp_irq *irq, *ptr;
-
-	isapnp_peek(tmp, size);
-	irq = isapnp_alloc(sizeof(struct isapnp_irq));
-	if (!irq)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(irq);
-			return;
-		}
-	}
-	irq->map = (tmp[1] << 8) | tmp[0];
-	if (size > 2)
-		irq->flags = tmp[2];
-	else
-		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
-	irq->res = *res;
-	ptr = (*res)->irq;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = irq;
-	else
-		(*res)->irq = irq;
-#ifdef CONFIG_PCI
-	for (i=0; i<16; i++)
-		if (irq->map & (1<<i))
-			pcibios_penalize_isa_irq(i);
-#endif
-}
-
-/*
- *  Add DMA resource to resources list.
- */
-
-static void __init isapnp_add_dma_resource(struct pci_dev *dev,
-                                    	       struct isapnp_resources **res,
-                                    	       int dependent, int size)
-{
-	unsigned char tmp[2];
-	struct isapnp_dma *dma, *ptr;
-
-	isapnp_peek(tmp, size);
-	dma = isapnp_alloc(sizeof(struct isapnp_dma));
-	if (!dma)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(dma);
-			return;
-		}
-	}
-	dma->map = tmp[0];
-	dma->flags = tmp[1];
-	dma->res = *res;
-	ptr = (*res)->dma;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = dma;
-	else
-		(*res)->dma = dma;
-}
-
-/*
- *  Add port resource to resources list.
- */
-
-static void __init isapnp_add_port_resource(struct pci_dev *dev,
-						struct isapnp_resources **res,
-						int dependent, int size)
-{
-	unsigned char tmp[7];
-	struct isapnp_port *port, *ptr;
-
-	isapnp_peek(tmp, size);
-	port = isapnp_alloc(sizeof(struct isapnp_port));
-	if (!port)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(port);
-			return;
-		}
-	}
-	port->min = (tmp[2] << 8) | tmp[1];
-	port->max = (tmp[4] << 8) | tmp[3];
-	port->align = tmp[5];
-	port->size = tmp[6];
-	port->flags = tmp[0] ? ISAPNP_PORT_FLAG_16BITADDR : 0;
-	port->res = *res;
-	ptr = (*res)->port;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = port;
-	else
-		(*res)->port = port;
-}
-
-/*
- *  Add fixed port resource to resources list.
- */
-
-static void __init isapnp_add_fixed_port_resource(struct pci_dev *dev,
-						      struct isapnp_resources **res,
-						      int dependent, int size)
-{
-	unsigned char tmp[3];
-	struct isapnp_port *port, *ptr;
-
-	isapnp_peek(tmp, size);
-	port = isapnp_alloc(sizeof(struct isapnp_port));
-	if (!port)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(port);
-			return;
-		}
-	}
-	port->min = port->max = (tmp[1] << 8) | tmp[0];
-	port->size = tmp[2];
-	port->align = 0;
-	port->flags = ISAPNP_PORT_FLAG_FIXED;
-	port->res = *res;
-	ptr = (*res)->port;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = port;
-	else
-		(*res)->port = port;
-}
-
-/*
- *  Add memory resource to resources list.
- */
-
-static void __init isapnp_add_mem_resource(struct pci_dev *dev,
-					       struct isapnp_resources **res,
-					       int dependent, int size)
-{
-	unsigned char tmp[9];
-	struct isapnp_mem *mem, *ptr;
-
-	isapnp_peek(tmp, size);
-	mem = isapnp_alloc(sizeof(struct isapnp_mem));
-	if (!mem)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(mem);
-			return;
-		}
-	}
-	mem->min = ((tmp[2] << 8) | tmp[1]) << 8;
-	mem->max = ((tmp[4] << 8) | tmp[3]) << 8;
-	mem->align = (tmp[6] << 8) | tmp[5];
-	mem->size = ((tmp[8] << 8) | tmp[7]) << 8;
-	mem->flags = tmp[0];
-	mem->res = *res;
-	ptr = (*res)->mem;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = mem;
-	else
-		(*res)->mem = mem;
-}
-
-/*
- *  Add 32-bit memory resource to resources list.
- */
-
-static void __init isapnp_add_mem32_resource(struct pci_dev *dev,
-						 struct isapnp_resources **res,
-						 int dependent, int size)
-{
-	unsigned char tmp[17];
-	struct isapnp_mem32 *mem32, *ptr;
-
-	isapnp_peek(tmp, size);
-	mem32 = isapnp_alloc(sizeof(struct isapnp_mem32));
-	if (!mem32)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(mem32);
-			return;
-		}
-	}
-	memcpy(mem32->data, tmp, 17);
-	mem32->res = *res;
-	ptr = (*res)->mem32;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = mem32;
-	else
-		(*res)->mem32 = mem32;
-}
-
-/*
- *  Add 32-bit fixed memory resource to resources list.
- */
-
-static void __init isapnp_add_fixed_mem32_resource(struct pci_dev *dev,
-						       struct isapnp_resources **res,
-						       int dependent, int size)
-{
-	unsigned char tmp[17];
-	struct isapnp_mem32 *mem32, *ptr;
-
-	isapnp_peek(tmp, size);
-	mem32 = isapnp_alloc(sizeof(struct isapnp_mem32));
-	if (!mem32)
-		return;
-	if (*res == NULL) {
-		*res = isapnp_build_resources(dev, dependent);
-		if (*res == NULL) {
-			kfree(mem32);
-			return;
-		}
-	}
-	memcpy(mem32->data, tmp, 17);
-	mem32->res = *res;
-	ptr = (*res)->mem32;
-	while (ptr && ptr->next)
-		ptr = ptr->next;
-	if (ptr)
-		ptr->next = mem32;
-	else
-		(*res)->mem32 = mem32;
-}
-
-/*
- *  Parse card name for ISA PnP device.
- */ 
- 
-static void __init 
-isapnp_parse_name(char *name, unsigned int name_max, unsigned short *size)
-{
-	if (name[0] == '\0') {
-		unsigned short size1 = *size >= name_max ? (name_max - 1) : *size;
-		isapnp_peek(name, size1);
-		name[size1] = '\0';
-		*size -= size1;
-		
-		/* clean whitespace from end of string */
-		while (size1 > 0  &&  name[--size1] == ' ') 
-			name[size1] = '\0';
-	}	
-}
-
-/*
- *  Parse resource map for logical device.
- */
-
-static int __init isapnp_create_device(struct pci_bus *card,
-					   unsigned short size)
-{
-	int number = 0, skip = 0, dependent = 0, compat = 0;
-	unsigned char type, tmp[17];
-	struct pci_dev *dev;
-	struct isapnp_resources *res = NULL;
-	
-	if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
-		return 1;
-	list_add(&dev->bus_list, &card->devices);
-	list_add_tail(&dev->global_list, &isapnp_devices);
-	while (1) {
-		if (isapnp_read_tag(&type, &size)<0)
-			return 1;
-		if (skip && type != _STAG_LOGDEVID && type != _STAG_END)
-			goto __skip;
-		switch (type) {
-		case _STAG_LOGDEVID:
-			if (size >= 5 && size <= 6) {
-				isapnp_config_prepare(dev);
-				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
-					return 1;
-				list_add_tail(&dev->bus_list, &card->devices);
-				list_add_tail(&dev->global_list, &isapnp_devices);
-				size = 0;
-				skip = 0;
-			} else {
-				skip = 1;
-			}
-			res = NULL;
-			dependent = 0;
-			compat = 0;
-			break;
-		case _STAG_COMPATDEVID:
-			if (size == 4 && compat < DEVICE_COUNT_COMPATIBLE) {
-				isapnp_peek(tmp, 4);
-				dev->vendor_compatible[compat] = (tmp[1] << 8) | tmp[0];
-				dev->device_compatible[compat] = (tmp[3] << 8) | tmp[2];
-				compat++;
-				size = 0;
-			}
-			break;
-		case _STAG_IRQ:
-			if (size < 2 || size > 3)
-				goto __skip;
-			isapnp_add_irq_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _STAG_DMA:
-			if (size != 2)
-				goto __skip;
-			isapnp_add_dma_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _STAG_STARTDEP:
-			if (size > 1)
-				goto __skip;
-			res = NULL;
-			dependent = 0x100 | ISAPNP_RES_PRIORITY_ACCEPTABLE;
-			if (size > 0) {
-				isapnp_peek(tmp, size);
-				dependent = 0x100 | tmp[0];
-				size = 0;
-			}
-			break;
-		case _STAG_ENDDEP:
-			if (size != 0)
-				goto __skip;
-			res = NULL;
-			dependent = 0;
-			break;
-		case _STAG_IOPORT:
-			if (size != 7)
-				goto __skip;
-			isapnp_add_port_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _STAG_FIXEDIO:
-			if (size != 3)
-				goto __skip;
-			isapnp_add_fixed_port_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _STAG_VENDOR:
-			break;
-		case _LTAG_MEMRANGE:
-			if (size != 9)
-				goto __skip;
-			isapnp_add_mem_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _LTAG_ANSISTR:
-			isapnp_parse_name(dev->name, sizeof(dev->name), &size);
-			break;
-		case _LTAG_UNICODESTR:
-			/* silently ignore */
-			/* who use unicode for hardware identification? */
-			break;
-		case _LTAG_VENDOR:
-			break;
-		case _LTAG_MEM32RANGE:
-			if (size != 17)
-				goto __skip;
-			isapnp_add_mem32_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _LTAG_FIXEDMEM32RANGE:
-			if (size != 17)
-				goto __skip;
-			isapnp_add_fixed_mem32_resource(dev, &res, dependent, size);
-			size = 0;
-			break;
-		case _STAG_END:
-			if (size > 0)
-				isapnp_skip_bytes(size);
-			isapnp_config_prepare(dev);
-			return 1;
-		default:
-			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n", type, dev->devfn, card->number);
-		}
-	      __skip:
-	      	if (size > 0)
-		      	isapnp_skip_bytes(size);
-	}
-	isapnp_config_prepare(dev);
-	return 0;
-}
-
-/*
- *  Parse resource map for ISA PnP card.
- */
- 
-static void __init isapnp_parse_resource_map(struct pci_bus *card)
-{
-	unsigned char type, tmp[17];
-	unsigned short size;
-	
-	while (1) {
-		if (isapnp_read_tag(&type, &size)<0)
-			return;
-		switch (type) {
-		case _STAG_PNPVERNO:
-			if (size != 2)
-				goto __skip;
-			isapnp_peek(tmp, 2);
-			card->pnpver = tmp[0];
-			card->productver = tmp[1];
-			size = 0;
-			break;
-		case _STAG_LOGDEVID:
-			if (size >= 5 && size <= 6) {
-				if (isapnp_create_device(card, size)==1)
-					return;
-				size = 0;
-			}
-			break;
-		case _STAG_VENDOR:
-			break;
-		case _LTAG_ANSISTR:
-			isapnp_parse_name(card->name, sizeof(card->name), &size);
-			break;
-		case _LTAG_UNICODESTR:
-			/* silently ignore */
-			/* who use unicode for hardware identification? */
-			break;
-		case _LTAG_VENDOR:
-			break;
-		case _STAG_END:
-			if (size > 0)
-				isapnp_skip_bytes(size);
-			return;
-		default:
-			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for device %i, ignored\n", type, card->number);
-		}
-	      __skip:
-	      	if (size > 0)
-		      	isapnp_skip_bytes(size);
-	}
-}
-
-/*
- *  Compute ISA PnP checksum for first eight bytes.
- */
-
-static unsigned char __init isapnp_checksum(unsigned char *data)
-{
-	int i, j;
-	unsigned char checksum = 0x6a, bit, b;
-	
-	for (i = 0; i < 8; i++) {
-		b = data[i];
-		for (j = 0; j < 8; j++) {
-			bit = 0;
-			if (b & (1 << j))
-				bit = 1;
-			checksum = ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7) | (checksum >> 1);
-		}
-	}
-	return checksum;
-}
-
-/*
- *  Build device list for all present ISA PnP devices.
- */
-
-static int __init isapnp_build_device_list(void)
-{
-	int csn;
-	unsigned char header[9], checksum;
-	struct pci_bus *card;
-	struct pci_dev *dev;
-
-	isapnp_wait();
-	isapnp_key();
-	for (csn = 1; csn <= 10; csn++) {
-		isapnp_wake(csn);
-		isapnp_peek(header, 9);
-		checksum = isapnp_checksum(header);
-#if 0
-		printk(KERN_DEBUG "vendor: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
-			header[0], header[1], header[2], header[3],
-			header[4], header[5], header[6], header[7], header[8]);
-		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
-#endif
-		/* Don't be strict on the checksum, here !
-                   e.g. 'SCM SwapBox Plug and Play' has header[8]==0 (should be: b7)*/
-		if (header[8] == 0)
-			;
-		else if (checksum == 0x00 || checksum != header[8])	/* not valid CSN */
-			continue;
-		if ((card = isapnp_alloc(sizeof(struct pci_bus))) == NULL)
-			continue;
-
-		card->number = csn;
-		card->vendor = (header[1] << 8) | header[0];
-		card->device = (header[3] << 8) | header[2];
-		card->serial = (header[7] << 24) | (header[6] << 16) | (header[5] << 8) | header[4];
-		isapnp_checksum_value = 0x00;
-		INIT_LIST_HEAD(&card->children);
-		INIT_LIST_HEAD(&card->devices);
-		isapnp_parse_resource_map(card);
-		if (isapnp_checksum_value != 0x00)
-			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
-		card->checksum = isapnp_checksum_value;
-
-		list_add_tail(&card->node, &isapnp_cards);
-	}
-	isapnp_for_each_dev(dev) {
-		isapnp_fixup_device(dev);
-	}
-	return 0;
-}
-
-/*
- *  Basic configuration routines.
- */
-
-int isapnp_present(void)
-{
-	return !list_empty(&isapnp_devices);
-}
-
-int isapnp_cfg_begin(int csn, int logdev)
-{
-	if (csn < 1 || csn > 10 || logdev > 10)
-		return -EINVAL;
-	MOD_INC_USE_COUNT;
-	down(&isapnp_cfg_mutex);
-	isapnp_wait();
-	isapnp_key();
-	isapnp_wake(csn);
-#if 0
-	/* to avoid malfunction when the isapnptools package is used */
-	/* we must set RDP to our value again */
-	/* it is possible to set RDP only in the isolation phase */ 
-	/*   Jens Thoms Toerring <Jens.Toerring-1Olz3AKvcsuAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org> */
-	isapnp_write_byte(0x02, 0x04);	/* clear CSN of card */
-	mdelay(2);			/* is this necessary? */
-	isapnp_wake(csn);		/* bring card into sleep state */
-	isapnp_wake(0);			/* bring card into isolation state */
-	isapnp_set_rdp();		/* reset the RDP port */
-	udelay(1000);			/* delay 1000us */
-	isapnp_write_byte(0x06, csn);	/* reset CSN to previous value */
-	udelay(250);			/* is this necessary? */
-#endif
-	if (logdev >= 0)
-		isapnp_device(logdev);
-	return 0;
-}
-
-int isapnp_cfg_end(void)
-{
-	isapnp_wait();
-	up(&isapnp_cfg_mutex);
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
-/*
- *  Resource manager.
- */
-
-static struct isapnp_port *isapnp_find_port(struct pci_dev *dev, int index)
-{
-	struct isapnp_resources *res;
-	struct isapnp_port *port;
-	
-	if (!dev || index < 0 || index > 7)
-		return NULL;
-	for (res = (struct isapnp_resources *)dev->sysdata; res; res = res->next) {
-		for (port = res->port; port; port = port->next) {
-			if (!index)
-				return port;
-			index--;
-		}
-	}
-	return NULL;
-}
-
-struct isapnp_irq *isapnp_find_irq(struct pci_dev *dev, int index)
-{
-	struct isapnp_resources *res, *resa;
-	struct isapnp_irq *irq;
-	int index1, index2, index3;
-	
-	if (!dev || index < 0 || index > 7)
-		return NULL;
-	for (res = (struct isapnp_resources *)dev->sysdata; res; res = res->next) {
-		index3 = 0;
-		for (resa = res; resa; resa = resa->alt) {
-			index1 = index;
-			index2 = 0;
-			for (irq = resa->irq; irq; irq = irq->next) {
-				if (!index1)
-					return irq;
-				index1--;
-				index2++;
-			}
-			if (index3 < index2)
-				index3 = index2;
-		}
-		index -= index3;
-	}
-	return NULL;
-}
-
-struct isapnp_dma *isapnp_find_dma(struct pci_dev *dev, int index)
-{
-	struct isapnp_resources *res;
-	struct isapnp_dma *dma;
-	
-	if (!dev || index < 0 || index > 7)
-		return NULL;
-	for (res = (struct isapnp_resources *)dev->sysdata; res; res = res->next) {
-		for (dma = res->dma; dma; dma = dma->next) {
-			if (!index)
-				return dma;
-			index--;
-		}
-	}
-	return NULL;
-}
-
-struct isapnp_mem *isapnp_find_mem(struct pci_dev *dev, int index)
-{
-	struct isapnp_resources *res;
-	struct isapnp_mem *mem;
-	
-	if (!dev || index < 0 || index > 7)
-		return NULL;
-	for (res = (struct isapnp_resources *)dev->sysdata; res; res = res->next) {
-		for (mem = res->mem; mem; mem = mem->next) {
-			if (!index)
-				return mem;
-			index--;
-		}
-	}
-	return NULL;
-}
-
-struct isapnp_mem32 *isapnp_find_mem32(struct pci_dev *dev, int index)
-{
-	struct isapnp_resources *res;
-	struct isapnp_mem32 *mem32;
-	
-	if (!dev || index < 0 || index > 7)
-		return NULL;
-	for (res = (struct isapnp_resources *)dev->sysdata; res; res = res->next) {
-		for (mem32 = res->mem32; mem32; mem32 = mem32->next) {
-			if (!index)
-				return mem32;
-			index--;
-		}
-	}
-	return NULL;
-}
-
-/*
- *  Device manager.
- */
-
-struct pci_bus *isapnp_find_card(unsigned short vendor,
-				 unsigned short device,
-				 struct pci_bus *from)
-{
-	struct list_head *list;
-
-	list = isapnp_cards.next;
-	if (from)
-		list = from->node.next;
-
-	while (list != &isapnp_cards) {
-		struct pci_bus *card = pci_bus_b(list);
-		if (card->vendor == vendor && card->device == device)
-			return card;
-		list = list->next;
-	}
-	return NULL;
-}
-
-struct pci_dev *isapnp_find_dev(struct pci_bus *card,
-				unsigned short vendor,
-				unsigned short function,
-				struct pci_dev *from)
-{
-	if (card == NULL) {	/* look for a logical device from all cards */
-		struct list_head *list;
-
-		list = isapnp_devices.next;
-		if (from)
-			list = from->global_list.next;
-
-		while (list != &isapnp_devices) {
-			int idx;
-			struct pci_dev *dev = pci_dev_g(list);
-
-			if (dev->vendor == vendor && dev->device == function)
-				return dev;
-			for (idx = 0; idx < DEVICE_COUNT_COMPATIBLE; idx++)
-				if (dev->vendor_compatible[idx] == vendor &&
-				    dev->device_compatible[idx] == function)
-					return dev;
-			list = list->next;
-		}
-	} else {
-		struct list_head *list;
-
-		list = card->devices.next;
-		if (from) {
-			list = from->bus_list.next;
-			if (from->bus != card)	/* something is wrong */
-				return NULL;
-		}
-		while (list != &card->devices) {
-			int idx;
-			struct pci_dev *dev = pci_dev_b(list);
-
-			if (dev->vendor == vendor && dev->device == function)
-				return dev;
-			for (idx = 0; idx < DEVICE_COUNT_COMPATIBLE; idx++)
-				if (dev->vendor_compatible[idx] == vendor &&
-				    dev->device_compatible[idx] == function)
-					return dev;
-			list = list->next;
-		}
-	}
-	return NULL;
-}
-
-static const struct isapnp_card_id *
-isapnp_match_card(const struct isapnp_card_id *ids, struct pci_bus *card)
-{
-	int idx;
-
-	while (ids->card_vendor || ids->card_device) {
-		if ((ids->card_vendor == ISAPNP_ANY_ID || ids->card_vendor == card->vendor) &&
-		    (ids->card_device == ISAPNP_ANY_ID || ids->card_device == card->device)) {
-			for (idx = 0; idx < ISAPNP_CARD_DEVS; idx++) {
-				if (ids->devs[idx].vendor == 0 &&
-				    ids->devs[idx].function == 0)
-					return ids;
-				if (isapnp_find_dev(card,
-						    ids->devs[idx].vendor,
-						    ids->devs[idx].function,
-						    NULL) == NULL)
-					goto __next;
-			}
-			return ids;
-		}
-	      __next:
-		ids++;
-	}
-	return NULL;
-}
-
-int isapnp_probe_cards(const struct isapnp_card_id *ids,
-		       int (*probe)(struct pci_bus *_card,
-		       		    const struct isapnp_card_id *_id))
-{
-	struct pci_bus *card;	
-	const struct isapnp_card_id *id;
-	int count = 0;
-
-	if (ids == NULL || probe == NULL)
-		return -EINVAL;
-	isapnp_for_each_card(card) {
-		id = isapnp_match_card(ids, card);
-		if (id != NULL && probe(card, id) >= 0)
-			count++;
-	}
-	return count;
-}
-
-static const struct isapnp_device_id *
-isapnp_match_dev(const struct isapnp_device_id *ids, struct pci_dev *dev)
-{
-	while (ids->card_vendor || ids->card_device) {
-		if ((ids->card_vendor == ISAPNP_ANY_ID || ids->card_vendor == dev->bus->vendor) &&
-		    (ids->card_device == ISAPNP_ANY_ID || ids->card_device == dev->bus->device) &&
-                    (ids->vendor == ISAPNP_ANY_ID || ids->vendor == dev->vendor) &&
-                    (ids->function == ISAPNP_ANY_ID || ids->function == dev->device))
-			return ids;
-		ids++;
-	}
-	return NULL;
-}
-
-int isapnp_probe_devs(const struct isapnp_device_id *ids,
-		      int (*probe)(struct pci_dev *dev,
-		                   const struct isapnp_device_id *id))
-{
-	
-	struct pci_dev *dev;
-	const struct isapnp_device_id *id;
-	int count = 0;
-
-	if (ids == NULL || probe == NULL)
-		return -EINVAL;
-	isapnp_for_each_dev(dev) {
-		id = isapnp_match_dev(ids, dev);
-		if (id != NULL && probe(dev, id) >= 0)
-			count++;
-	}
-	return count;
-}
-
-int isapnp_activate_dev(struct pci_dev *dev, const char *name)
-{
-	int err;
-	
-	/* Device already active? Let's use it and inform the caller */
-	if (dev->active)
-		return -EBUSY;
-
-	if ((err = dev->activate(dev)) < 0) {
-		printk(KERN_ERR "isapnp: config of %s failed (out of resources?)[%d]\n", name, err);
-		dev->deactivate(dev);
-		return err;
-	}
-
-	return 0;
-}
-
-static unsigned int isapnp_dma_resource_flags(struct isapnp_dma *dma)
-{
-	return dma->flags | IORESOURCE_DMA | IORESOURCE_AUTO;
-}
-
-static unsigned int isapnp_mem_resource_flags(struct isapnp_mem *mem)
-{
-	unsigned int result;
-
-	result = mem->flags | IORESOURCE_MEM | IORESOURCE_AUTO;
-	if (!(mem->flags & IORESOURCE_MEM_WRITEABLE))
-		result |= IORESOURCE_READONLY;
-	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
-		result |= IORESOURCE_CACHEABLE;
-	if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
-		result |= IORESOURCE_RANGELENGTH;
-	if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
-		result |= IORESOURCE_SHADOWABLE;
-	return result;
-}
-
-static unsigned int isapnp_irq_resource_flags(struct isapnp_irq *irq)
-{
-	return irq->flags | IORESOURCE_IRQ | IORESOURCE_AUTO;
-}
-
-static unsigned int isapnp_port_resource_flags(struct isapnp_port *port)
-{
-	return port->flags | IORESOURCE_IO | IORESOURCE_AUTO;
-}
-
-static int isapnp_config_prepare(struct pci_dev *dev)
-{
-	struct isapnp_resources *res, *resa;
-	struct isapnp_port *port;
-	struct isapnp_irq *irq;
-	struct isapnp_dma *dma;
-	struct isapnp_mem *mem;
-	int port_count, port_count1;
-	int irq_count, irq_count1;
-	int dma_count, dma_count1;
-	int mem_count, mem_count1;
-	int idx;
-
-	if (dev == NULL)
-		return -EINVAL;
-	if (dev->active || dev->ro)
-		return -EBUSY;
-	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
-		dev->irq_resource[idx].name = NULL;
-		dev->irq_resource[idx].start = 0;
-		dev->irq_resource[idx].end = 0;
-		dev->irq_resource[idx].flags = 0;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++) {
-		dev->dma_resource[idx].name = NULL;
-		dev->dma_resource[idx].start = 0;
-		dev->dma_resource[idx].end = 0;
-		dev->dma_resource[idx].flags = 0;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++) {
-		dev->resource[idx].name = NULL;
-		dev->resource[idx].start = 0;
-		dev->resource[idx].end = 0;
-		dev->resource[idx].flags = 0;
-	}
-	port_count = irq_count = dma_count = mem_count = 0;
-	for (res = (struct isapnp_resources *)dev->sysdata; res; res = res->next) {
-		port_count1 = irq_count1 = dma_count1 = mem_count1 = 0;
-		for (resa = res; resa; resa = resa->alt) {
-			for (port = resa->port, idx = 0; port; port = port->next, idx++) {
-				if (dev->resource[port_count + idx].flags == 0) {
-					dev->resource[port_count + idx].flags = isapnp_port_resource_flags(port);
-					dev->resource[port_count + idx].end = port->size;
-				}
-			}
-			if (port_count1 < idx)
-				port_count1 = idx;
-			for (irq = resa->irq, idx = 0; irq; irq = irq->next, idx++) {
-				int count = irq_count + idx;
-				if (count < DEVICE_COUNT_IRQ) {
-					if (dev->irq_resource[count].flags == 0) {
-						dev->irq_resource[count].flags = isapnp_irq_resource_flags(irq);
-					}
-				}
-				
-			}
-			if (irq_count1 < idx)
-				irq_count1 = idx;
-			for (dma = resa->dma, idx = 0; dma; dma = dma->next, idx++)
-				if (dev->dma_resource[idx].flags == 0) {
-					dev->dma_resource[idx].flags = isapnp_dma_resource_flags(dma);
-				}
-			if (dma_count1 < idx)
-				dma_count1 = idx;
-			for (mem = resa->mem, idx = 0; mem; mem = mem->next, idx++)
-				if (dev->resource[mem_count + idx + 8].flags == 0) {
-					dev->resource[mem_count + idx + 8].flags = isapnp_mem_resource_flags(mem);
-				}
-			if (mem_count1 < idx)
-				mem_count1 = idx;
-		}
-		port_count += port_count1;
-		irq_count += irq_count1;
-		dma_count += dma_count1;
-		mem_count += mem_count1;
-	}
-	return 0;
-}
-
-struct isapnp_cfgtmp {
-	struct isapnp_port *port[8];
-	struct isapnp_irq *irq[2];
-	struct isapnp_dma *dma[2];
-	struct isapnp_mem *mem[4];
-	struct pci_dev *request;
-	struct pci_dev result;
-};
-
-static int isapnp_alternative_switch(struct isapnp_cfgtmp *cfg,
-				     struct isapnp_resources *from,
-				     struct isapnp_resources *to)
-{
-	int tmp, tmp1;
-	struct isapnp_port *port;
-	struct isapnp_irq *irq;
-	struct isapnp_dma *dma;
-	struct isapnp_mem *mem;
-
-	if (!cfg)
-		return -EINVAL;
-	/* process port settings */
-	for (tmp = 0; tmp < 8; tmp++) {
-		if (!(cfg->request->resource[tmp].flags & IORESOURCE_AUTO))
-			continue;		/* don't touch */
-		port = cfg->port[tmp];
-		if (!port) {
-			cfg->port[tmp] = port = isapnp_find_port(cfg->request, tmp);
-			if (!port)
-				return -EINVAL;
-		}
-		if (from && port->res == from) {
-			while (port->res != to) {
-				if (!port->res->alt)
-					return -EINVAL;
-				port = port->res->alt->port;
-				for (tmp1 = tmp; tmp1 > 0 && port; tmp1--)
-					port = port->next;
-				cfg->port[tmp] = port;
-				if (!port)
-					return -ENOENT;
-				cfg->result.resource[tmp].flags = isapnp_port_resource_flags(port);
-			}
-		}
-	}
-	/* process irq settings */
-	for (tmp = 0; tmp < 2; tmp++) {
-		if (!(cfg->request->irq_resource[tmp].flags & IORESOURCE_AUTO))
-			continue;		/* don't touch */
-		irq = cfg->irq[tmp];
-		if (!irq) {
-			cfg->irq[tmp] = irq = isapnp_find_irq(cfg->request, tmp);
-			if (!irq)
-				return -EINVAL;
-		}
-		if (from && irq->res == from) {
-			while (irq->res != to) {
-				if (!irq->res->alt)
-					return -EINVAL;
-				irq = irq->res->alt->irq;
-				for (tmp1 = tmp; tmp1 > 0 && irq; tmp1--)
-					irq = irq->next;
-				cfg->irq[tmp] = irq;
-				if (!irq)
-					return -ENOENT;
-				cfg->result.irq_resource[tmp].flags = isapnp_irq_resource_flags(irq);
-			}
-		}
-	}
-	/* process dma settings */
-	for (tmp = 0; tmp < 2; tmp++) {
-		if (!(cfg->request->dma_resource[tmp].flags & IORESOURCE_AUTO))
-			continue;		/* don't touch */
-		dma = cfg->dma[tmp];
-		if (!dma) {
-			cfg->dma[tmp] = dma = isapnp_find_dma(cfg->request, tmp);
-			if (!dma)
-				return -EINVAL;
-		}
-		if (from && dma->res == from) {
-			while (dma->res != to) {
-				if (!dma->res->alt)
-					return -EINVAL;
-				dma = dma->res->alt->dma;
-				for (tmp1 = tmp; tmp1 > 0 && dma; tmp1--)
-					dma = dma->next;
-				cfg->dma[tmp] = dma;
-				if (!dma)
-					return -ENOENT;
-				cfg->result.dma_resource[tmp].flags = isapnp_dma_resource_flags(dma);
-			}
-		}
-	}
-	/* process memory settings */
-	for (tmp = 0; tmp < 4; tmp++) {
-		if (!(cfg->request->resource[tmp + 8].flags & IORESOURCE_AUTO))
-			continue;		/* don't touch */
-		mem = cfg->mem[tmp];
-		if (!mem) {
-			cfg->mem[tmp] = mem = isapnp_find_mem(cfg->request, tmp);
-			if (!mem)
-				return -EINVAL;
-		}
-		if (from && mem->res == from) {
-			while (mem->res != to) {
-				if (!mem->res->alt)
-					return -EINVAL;
-				mem = mem->res->alt->mem;
-				for (tmp1 = tmp; tmp1 > 0 && mem; tmp1--)
-					mem = mem->next;
-				cfg->mem[tmp] = mem;
-				if (!mem)
-					return -ENOENT;
-				cfg->result.resource[tmp + 8].flags = isapnp_mem_resource_flags(mem);
-			}
-		}
-	}
-	return 0;
-}
-
-static int isapnp_check_port(struct isapnp_cfgtmp *cfg, int port, int size, int idx)
-{
-	int i, tmp, rport, rsize;
-	struct isapnp_port *xport;
-	struct pci_dev *dev;
-
-	if (check_region(port, size))
-		return 1;
-	for (i = 0; i < 8; i++) {
-		rport = isapnp_reserve_io[i << 1];
-		rsize = isapnp_reserve_io[(i << 1) + 1];
-		if (port >= rport && port < rport + rsize)
-			return 1;
-		if (port + size > rport && port + size < (rport + rsize) - 1)
-			return 1;
-	}
-
-	isapnp_for_each_dev(dev) {
-		if (dev->active) {
-			for (tmp = 0; tmp < 8; tmp++) {
-				if (dev->resource[tmp].flags) {
-					rport = dev->resource[tmp].start;
-					rsize = (dev->resource[tmp].end - rport) + 1;
-					if (port >= rport && port < rport + rsize)
-						return 1;
-					if (port + size > rport && port + size < (rport + rsize) - 1)
-						return 1;
-				}
-			}
-		}
-	}
-	for (i = 0; i < 8; i++) {
-		unsigned int flags;
-		if (i == idx)
-			continue;
-		flags = cfg->request->resource[i].flags;
-		if (!flags)
-			continue;
-		tmp = cfg->request->resource[i].start;
-		if (flags & IORESOURCE_AUTO) {		/* auto */
-			xport = cfg->port[i];
-			if (!xport)
-				return 1;
-			if (cfg->result.resource[i].flags & IORESOURCE_AUTO)
-				continue;
-			tmp = cfg->result.resource[i].start;
-			if (tmp + xport->size >= port && tmp <= port + xport->size)
-				return 1;
-			continue;
-		}
-		if (port == tmp)
-			return 1;
-		xport = isapnp_find_port(cfg->request, i);
-		if (!xport)
-			return 1;
-		if (tmp + xport->size >= port && tmp <= port + xport->size)
-			return 1;
-	}
-	return 0;
-}
-
-static int isapnp_valid_port(struct isapnp_cfgtmp *cfg, int idx)
-{
-	int err;
-	unsigned long *value1, *value2;
-	struct isapnp_port *port;
-
-	if (!cfg || idx < 0 || idx > 7)
-		return -EINVAL;
-	if (!(cfg->result.resource[idx].flags & IORESOURCE_AUTO)) /* don't touch */
-		return 0;
-      __again:
-      	port = cfg->port[idx];
-      	if (!port)
-      		return -EINVAL;
-      	value1 = &cfg->result.resource[idx].start;
-      	value2 = &cfg->result.resource[idx].end;
-	if (cfg->result.resource[idx].flags & IORESOURCE_AUTO) {
-		cfg->result.resource[idx].flags &= ~IORESOURCE_AUTO;
-		*value1 = port->min;
-		*value2 = port->min + port->size - 1;
-		if (!isapnp_check_port(cfg, *value1, port->size, idx))
-			return 0;
-	}
-	do {
-		*value1 += port->align;
-		*value2 = *value1 + port->size - 1;
-		if (*value1 > port->max || !port->align) {
-			if (port->res && port->res->alt) {
-				if ((err = isapnp_alternative_switch(cfg, port->res, port->res->alt))<0)
-					return err;
-				goto __again;
-			}
-			return -ENOENT;
-		}
-	} while (isapnp_check_port(cfg, *value1, port->size, idx));
-	return 0;
-}
-
-static void isapnp_test_handler(int irq, void *dev_id, struct pt_regs *regs)
-{
-}
-
-static int isapnp_check_interrupt(struct isapnp_cfgtmp *cfg, int irq, int idx)
-{
-	int i;
-	struct pci_dev *dev;
-
-	if (irq < 0 || irq > 15)
-		return 1;
-	for (i = 0; i < 16; i++) {
-		if (isapnp_reserve_irq[i] == irq)
-			return 1;
-	}
-	isapnp_for_each_dev(dev) {
-		if (dev->active) {
-			if ((dev->irq_resource[0].flags && dev->irq_resource[0].start == irq) ||
-			    (dev->irq_resource[1].flags && dev->irq_resource[1].start == irq))
-				return 1;
-		}
-	}
-#ifdef CONFIG_PCI
-	if (!isapnp_skip_pci_scan) {
-		pci_for_each_dev(dev) {
-			if (dev->irq == irq)
-				return 1;
-		}
-	}
-#endif
-	if (request_irq(irq, isapnp_test_handler, SA_INTERRUPT, "isapnp", NULL))
-		return 1;
-	free_irq(irq, NULL);
-	for (i = 0; i < DEVICE_COUNT_IRQ; i++) {
-		if (i == idx)
-			continue;
-		if (!cfg->result.irq_resource[i].flags)
-			continue;
-		if (cfg->result.irq_resource[i].flags & IORESOURCE_AUTO)
-			continue;
-		if (cfg->result.irq_resource[i].start == irq)
-			return 1;
-	}
-	return 0;
-}
-
-static int isapnp_valid_irq(struct isapnp_cfgtmp *cfg, int idx)
-{
-	/* IRQ priority: this table is good for i386 */
-	static unsigned short xtab[16] = {
-		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
-	};
-	int err, i;
-	unsigned long *value1, *value2;
-	struct isapnp_irq *irq;
-
-	if (!cfg || idx < 0 || idx > 1)
-		return -EINVAL;
-	if (!(cfg->result.irq_resource[idx].flags & IORESOURCE_AUTO))
-		return 0;
-      __again:
-      	irq = cfg->irq[idx];
-      	if (!irq)
-      		return -EINVAL;
-      	value1 = &cfg->result.irq_resource[idx].start;
-      	value2 = &cfg->result.irq_resource[idx].end;
-	if (cfg->result.irq_resource[idx].flags & IORESOURCE_AUTO) {
-		for (i = 0; i < 16 && !(irq->map & (1<<xtab[i])); i++);
-		if (i >= 16)
-			return -ENOENT;
-		cfg->result.irq_resource[idx].flags &= ~IORESOURCE_AUTO;
-		if (!isapnp_check_interrupt(cfg, *value1 = *value2 = xtab[i], idx))
-			return 0;
-	}
-	do {
-		for (i = 0; i < 16 && xtab[i] != *value1; i++);
-		for (i++; i < 16 && !(irq->map & (1<<xtab[i])); i++);
-		if (i >= 16) {
-			if (irq->res && irq->res->alt) {
-				if ((err = isapnp_alternative_switch(cfg, irq->res, irq->res->alt))<0)
-					return err;
-				goto __again;
-			}
-			return -ENOENT;
-		} else {
-			*value1 = *value2 = xtab[i];
-		}
-	} while (isapnp_check_interrupt(cfg, *value1, idx));
-	return 0;
-}
-
-static int isapnp_check_dma(struct isapnp_cfgtmp *cfg, int dma, int idx)
-{
-	int i, mindma =1;
-	struct pci_dev *dev;
-
-	/* Some machines allow DMA 0, but others don't. In fact on some 
-	   boxes DMA 0 is the memory refresh. Play safe */
-	if (isapnp_allow_dma0 == 1)
-		mindma = 0;
-	if (dma < mindma || dma == 4 || dma > 7)
-		return 1;
-	for (i = 0; i < 8; i++) {
-		if (isapnp_reserve_dma[i] == dma)
-			return 1;
-	}
-	isapnp_for_each_dev(dev) {
-		if (dev->active) {
-			if ((dev->dma_resource[0].flags && dev->dma_resource[0].start == dma) ||
-			    (dev->dma_resource[1].flags && dev->dma_resource[1].start == dma))
-				return 1;
-		}
-	}
-	if (request_dma(dma, "isapnp"))
-		return 1;
-	free_dma(dma);
-	for (i = 0; i < 2; i++) {
-		if (i == idx)
-			continue;
-		if (!cfg->result.dma_resource[i].flags ||
-		    (cfg->result.dma_resource[i].flags & IORESOURCE_AUTO))
-			continue;
-		if (cfg->result.dma_resource[i].start == dma)
-			return 1;
-	}
-	return 0;
-}
-
-static int isapnp_valid_dma(struct isapnp_cfgtmp *cfg, int idx)
-{
-	/* DMA priority: this table is good for i386 */
-	static unsigned short xtab[16] = {
-		1, 3, 5, 6, 7, 0, 2, 4
-	};
-	int err, i;
-	unsigned long *value1, *value2;
-	struct isapnp_dma *dma;
-
-	if (!cfg || idx < 0 || idx > 1)
-		return -EINVAL;
-	if (!(cfg->result.dma_resource[idx].flags & IORESOURCE_AUTO))	/* don't touch */
-		return 0;
-      __again:
-      	dma = cfg->dma[idx];
-      	if (!dma)
-      		return -EINVAL;
-      	value1 = &cfg->result.dma_resource[idx].start;
-      	value2 = &cfg->result.dma_resource[idx].end;
-	if (cfg->result.dma_resource[idx].flags & IORESOURCE_AUTO) {
-		for (i = 0; i < 8 && !(dma->map & (1<<xtab[i])); i++);
-		if (i >= 8)
-			return -ENOENT;
-		cfg->result.dma_resource[idx].flags &= ~IORESOURCE_AUTO;
-		if (!isapnp_check_dma(cfg, *value1 = *value2 = xtab[i], idx))
-			return 0;
-	}
-	do {
-		for (i = 0; i < 8 && xtab[i] != *value1; i++);
-		for (i++; i < 8 && !(dma->map & (1<<xtab[i])); i++);
-		if (i >= 8) {
-			if (dma->res && dma->res->alt) {
-				if ((err = isapnp_alternative_switch(cfg, dma->res, dma->res->alt))<0)
-					return err;
-				goto __again;
-			}
-			return -ENOENT;
-		} else {
-			*value1 = *value2 = xtab[i];
-		}
-	} while (isapnp_check_dma(cfg, *value1, idx));
-	return 0;
-}
-
-static int isapnp_check_mem(struct isapnp_cfgtmp *cfg, unsigned int addr, unsigned int size, int idx)
-{
-	int i, tmp;
-	unsigned int raddr, rsize;
-	struct isapnp_mem *xmem;
-	struct pci_dev *dev;
-
-	for (i = 0; i < 8; i++) {
-		raddr = (unsigned int)isapnp_reserve_mem[i << 1];
-		rsize = (unsigned int)isapnp_reserve_mem[(i << 1) + 1];
-		if (addr >= raddr && addr < raddr + rsize)
-			return 1;
-		if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
-			return 1;
-		if (__check_region(&iomem_resource, addr, size))
-			return 1;
-	}
-	isapnp_for_each_dev(dev) {
-		if (dev->active) {
-			for (tmp = 0; tmp < 4; tmp++) {
-				if (dev->resource[tmp].flags) {
-					raddr = dev->resource[tmp + 8].start;
-					rsize = (dev->resource[tmp + 8].end - raddr) + 1;
-					if (addr >= raddr && addr < raddr + rsize)
-						return 1;
-					if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
-						return 1;
-				}
-			}
-		}
-	}
-	for (i = 0; i < 4; i++) {
-		unsigned int flags = cfg->request->resource[i + 8].flags;
-		if (i == idx)
-			continue;
-		if (!flags)
-			continue;
-		tmp = cfg->result.resource[i + 8].start;
-		if (flags & IORESOURCE_AUTO) {		/* auto */
-			xmem = cfg->mem[i];
-			if (!xmem)
-				return 1;
-			if (cfg->result.resource[i + 8].flags & IORESOURCE_AUTO)
-				continue;
-			if (tmp + xmem->size >= addr && tmp <= addr + xmem->size)
-				return 1;
-			continue;
-		}
-		if (addr == tmp)
-			return 1;
-		xmem = isapnp_find_mem(cfg->request, i);
-		if (!xmem)
-			return 1;
-		if (tmp + xmem->size >= addr && tmp <= addr + xmem->size)
-			return 1;
-	}
-	return 0;
-}
-
-static int isapnp_valid_mem(struct isapnp_cfgtmp *cfg, int idx)
-{
-	int err;
-	unsigned long *value1, *value2;
-	struct isapnp_mem *mem;
-
-	if (!cfg || idx < 0 || idx > 3)
-		return -EINVAL;
-	if (!(cfg->result.resource[idx + 8].flags & IORESOURCE_AUTO)) /* don't touch */
-		return 0;
-      __again:
-      	mem = cfg->mem[idx];
-      	if (!mem)
-      		return -EINVAL;
-      	value1 = &cfg->result.resource[idx + 8].start;
-      	value2 = &cfg->result.resource[idx + 8].end;
-	if (cfg->result.resource[idx + 8].flags & IORESOURCE_AUTO) {
-		cfg->result.resource[idx + 8].flags &= ~IORESOURCE_AUTO;
-		*value1 = mem->min;
-		*value2 = mem->min + mem->size - 1;
-		if (!isapnp_check_mem(cfg, *value1, mem->size, idx))
-			return 0;
-	}
-	do {
-		*value1 += mem->align;
-		*value2 = *value1 + mem->size - 1;
-		if (*value1 > mem->max || !mem->align) {
-			if (mem->res && mem->res->alt) {
-				if ((err = isapnp_alternative_switch(cfg, mem->res, mem->res->alt))<0)
-					return err;
-				goto __again;
-			}
-			return -ENOENT;
-		}
-	} while (isapnp_check_mem(cfg, *value1, mem->size, idx));
-	return 0;
-}
-
-static int isapnp_check_valid(struct isapnp_cfgtmp *cfg)
-{
-	int tmp;
-	
-	for (tmp = 0; tmp < 8; tmp++)
-		if (cfg->result.resource[tmp].flags & IORESOURCE_AUTO)
-			return -EAGAIN;
-	for (tmp = 0; tmp < 2; tmp++)
-		if (cfg->result.irq_resource[tmp].flags & IORESOURCE_AUTO)
-			return -EAGAIN;
-	for (tmp = 0; tmp < 2; tmp++)
-		if (cfg->result.dma_resource[tmp].flags & IORESOURCE_AUTO)
-			return -EAGAIN;
-	for (tmp = 0; tmp < 4; tmp++)
-		if (cfg->result.resource[tmp + 8].flags & IORESOURCE_AUTO)
-			return -EAGAIN;
-	return 0;
-}
-
-static int isapnp_config_activate(struct pci_dev *dev)
-{
-	struct isapnp_cfgtmp cfg;
-	int tmp, fauto, err;
-	
-	if (!dev)
-		return -EINVAL;
-	if (dev->active)
-		return -EBUSY;
-	memset(&cfg, 0, sizeof(cfg));
-	cfg.request = dev;
-	memcpy(&cfg.result, dev, sizeof(struct pci_dev));
-	/* check if all values are set, otherwise try auto-configuration */
-	for (tmp = fauto = 0; !fauto && tmp < 8; tmp++) {
-		if (dev->resource[tmp].flags & IORESOURCE_AUTO)
-			fauto++;
-	}
-	for (tmp = 0; !fauto && tmp < 2; tmp++) {
-		if (dev->irq_resource[tmp].flags & IORESOURCE_AUTO)
-			fauto++;
-	}
-	for (tmp = 0; !fauto && tmp < 2; tmp++) {
-		if (dev->dma_resource[tmp].flags & IORESOURCE_AUTO)
-			fauto++;
-	}
-	for (tmp = 0; !fauto && tmp < 4; tmp++) {
-		if (dev->resource[tmp + 8].flags & IORESOURCE_AUTO)
-			fauto++;
-	}
-	if (!fauto)
-		goto __skip_auto;
-	/* set variables to initial values */
-	if ((err = isapnp_alternative_switch(&cfg, NULL, NULL))<0)
-		return err;
-	/* find first valid configuration */
-	fauto = 0;
-	do {
-		for (tmp = 0; tmp < 8 && cfg.result.resource[tmp].flags; tmp++)
-			if ((err = isapnp_valid_port(&cfg, tmp))<0)
-				return err;
-		for (tmp = 0; tmp < 2 && cfg.result.irq_resource[tmp].flags; tmp++)
-			if ((err = isapnp_valid_irq(&cfg, tmp))<0)
-				return err;
-		for (tmp = 0; tmp < 2 && cfg.result.dma_resource[tmp].flags; tmp++)
-			if ((err = isapnp_valid_dma(&cfg, tmp))<0)
-				return err;
-		for (tmp = 0; tmp < 4 && cfg.result.resource[tmp + 8].flags; tmp++)
-			if ((err = isapnp_valid_mem(&cfg, tmp))<0)
-				return err;
-	} while (isapnp_check_valid(&cfg)<0 && fauto++ < 20);
-	if (fauto >= 20)
-		return -EAGAIN;
-      __skip_auto:
-      	/* we have valid configuration, try configure hardware */
-      	isapnp_cfg_begin(dev->bus->number, dev->devfn);
-	dev->active = 1;
-	dev->irq_resource[0] = cfg.result.irq_resource[0];
-	dev->irq_resource[1] = cfg.result.irq_resource[1];
-	dev->dma_resource[0] = cfg.result.dma_resource[0];
-	dev->dma_resource[1] = cfg.result.dma_resource[1];
-	for (tmp = 0; tmp < 12; tmp++) {
-		dev->resource[tmp] = cfg.result.resource[tmp];
-	}	
-	for (tmp = 0; tmp < 8 && dev->resource[tmp].flags; tmp++)
-		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), dev->resource[tmp].start);
-	for (tmp = 0; tmp < 2 && dev->irq_resource[tmp].flags; tmp++) {
-		int irq = dev->irq_resource[tmp].start;
-		if (irq == 2)
-			irq = 9;
-		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
-	}
-	for (tmp = 0; tmp < 2 && dev->dma_resource[tmp].flags; tmp++)
-		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, dev->dma_resource[tmp].start);
-	for (tmp = 0; tmp < 4 && dev->resource[tmp+8].flags; tmp++)
-		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (dev->resource[tmp + 8].start >> 8) & 0xffff);
-	isapnp_activate(dev->devfn);
-	isapnp_cfg_end();
-	return 0;
-}
-
-static int isapnp_config_deactivate(struct pci_dev *dev)
-{
-	if (!dev || !dev->active)
-		return -EINVAL;
-      	isapnp_cfg_begin(dev->bus->number, dev->devfn);
-	isapnp_deactivate(dev->devfn);
-	dev->active = 0;
-	isapnp_cfg_end();
-	return 0;
-}
-
-void isapnp_resource_change(struct resource *resource,
-			    unsigned long start,
-			    unsigned long size)
-{
-	if (resource == NULL)
-		return;
-	resource->flags &= ~IORESOURCE_AUTO;
-	resource->start = start;
-	resource->end = start + size - 1;
-}
-
-/*
- *  Inititialization.
- */
-
-#ifdef MODULE
-
-static void isapnp_free_port(struct isapnp_port *port)
-{
-	struct isapnp_port *next;
-
-	while (port) {
-		next = port->next;
-		kfree(port);
-		port = next;
-	}
-}
-
-static void isapnp_free_irq(struct isapnp_irq *irq)
-{
-	struct isapnp_irq *next;
-
-	while (irq) {
-		next = irq->next;
-		kfree(irq);
-		irq = next;
-	}
-}
-
-static void isapnp_free_dma(struct isapnp_dma *dma)
-{
-	struct isapnp_dma *next;
-
-	while (dma) {
-		next = dma->next;
-		kfree(dma);
-		dma = next;
-	}
-}
-
-static void isapnp_free_mem(struct isapnp_mem *mem)
-{
-	struct isapnp_mem *next;
-
-	while (mem) {
-		next = mem->next;
-		kfree(mem);
-		mem = next;
-	}
-}
-
-static void isapnp_free_mem32(struct isapnp_mem32 *mem32)
-{
-	struct isapnp_mem32 *next;
-
-	while (mem32) {
-		next = mem32->next;
-		kfree(mem32);
-		mem32 = next;
-	}
-}
-
-static void isapnp_free_resources(struct isapnp_resources *resources, int alt)
-{
-	struct isapnp_resources *next;
-
-	while (resources) {
-		next = alt ? resources->alt : resources->next;
-		isapnp_free_port(resources->port);
-		isapnp_free_irq(resources->irq);
-		isapnp_free_dma(resources->dma);
-		isapnp_free_mem(resources->mem);
-		isapnp_free_mem32(resources->mem32);
-		if (!alt && resources->alt)
-			isapnp_free_resources(resources->alt, 1);
-		kfree(resources);
-		resources = next;
-	}
-}
-
-static void isapnp_free_card(struct pci_bus *card)
-{
-	while (!list_empty(&card->devices)) {
-		struct list_head *list = card->devices.next;
-		struct pci_dev *dev = pci_dev_b(list);
-		list_del(list);
-		isapnp_free_resources((struct isapnp_resources *)dev->sysdata, 0);
-		kfree(dev);
-	}
-	kfree(card);
-}
-
-static void isapnp_free_all_resources(void)
-{
-#ifdef ISAPNP_REGION_OK
-	release_region(_PIDXR, 1);
-#endif
-	release_region(_PNPWRP, 1);
-	release_region(isapnp_rdp, 1);
-#ifdef CONFIG_PROC_FS
-	isapnp_proc_done();
-#endif
-	while (!list_empty(&isapnp_cards)) {
-		struct list_head *list = isapnp_cards.next;
-		list_del(list);
-		isapnp_free_card(pci_bus_b(list));
-	}
-}
-
-#endif /* MODULE */
-
-static int isapnp_announce_device(struct isapnp_driver *drv, 
-				  struct pci_dev *dev)
-{
-	const struct isapnp_device_id *id;
-	int ret = 0;
-
-	if (drv->id_table) {
-		id = isapnp_match_dev(drv->id_table, dev);
-		if (!id) {
-			ret = 0;
-			goto out;
-		}
-	} else
-		id = NULL;
-
-	if (drv->probe(dev, id) >= 0) {
-		dev->driver = (struct pci_driver *) drv;
-		ret = 1;
-	}
-out:
-	return ret;
-}
-
-/**
- * isapnp_dev_driver - get the isapnp_driver of a device
- * @dev: the device to query
- *
- * Returns the appropriate isapnp_driver structure or %NULL if there is no 
- * registered driver for the device.
- */
-static struct isapnp_driver *isapnp_dev_driver(const struct pci_dev *dev)
-{
-	return (struct isapnp_driver *) dev->driver;
-}
-
-static LIST_HEAD(isapnp_drivers);
-
-/**
- * isapnp_register_driver - register a new ISAPnP driver
- * @drv: the driver structure to register
- * 
- * Adds the driver structure to the list of registered ISAPnP drivers
- * Returns the number of isapnp devices which were claimed by the driver
- * during registration.  The driver remains registered even if the
- * return value is zero.
- */
-int isapnp_register_driver(struct isapnp_driver *drv)
-{
-	struct pci_dev *dev;
-	int count = 0;
-
-	list_add_tail(&drv->node, &isapnp_drivers);
-
-	isapnp_for_each_dev(dev) {
-		if (!isapnp_dev_driver(dev))
-			count += isapnp_announce_device(drv, dev);
-	}
-	return count;
-}
-
-/**
- * isapnp_unregister_driver - unregister an isapnp driver
- * @drv: the driver structure to unregister
- * 
- * Deletes the driver structure from the list of registered ISAPnP drivers,
- * gives it a chance to clean up by calling its remove() function for
- * each device it was responsible for, and marks those devices as
- * driverless.
- */
-void isapnp_unregister_driver(struct isapnp_driver *drv)
-{
-	struct pci_dev *dev;
-
-	list_del(&drv->node);
-	isapnp_for_each_dev(dev) {
-		if (dev->driver == (struct pci_driver *) drv) {
-			if (drv->remove)
-				drv->remove(dev);
-			dev->driver = NULL;
-		}
-	}
-}
-
-EXPORT_SYMBOL(isapnp_cards);
-EXPORT_SYMBOL(isapnp_devices);
-EXPORT_SYMBOL(isapnp_present);
-EXPORT_SYMBOL(isapnp_cfg_begin);
-EXPORT_SYMBOL(isapnp_cfg_end);
-EXPORT_SYMBOL(isapnp_read_byte);
-EXPORT_SYMBOL(isapnp_read_word);
-EXPORT_SYMBOL(isapnp_read_dword);
-EXPORT_SYMBOL(isapnp_write_byte);
-EXPORT_SYMBOL(isapnp_write_word);
-EXPORT_SYMBOL(isapnp_write_dword);
-EXPORT_SYMBOL(isapnp_wake);
-EXPORT_SYMBOL(isapnp_device);
-EXPORT_SYMBOL(isapnp_activate);
-EXPORT_SYMBOL(isapnp_deactivate);
-EXPORT_SYMBOL(isapnp_find_card);
-EXPORT_SYMBOL(isapnp_find_dev);
-EXPORT_SYMBOL(isapnp_probe_cards);
-EXPORT_SYMBOL(isapnp_probe_devs);
-EXPORT_SYMBOL(isapnp_activate_dev);
-EXPORT_SYMBOL(isapnp_resource_change);
-EXPORT_SYMBOL(isapnp_register_driver);
-EXPORT_SYMBOL(isapnp_unregister_driver);
-
-static struct device_driver isapnp_device_driver = {
-	.devices = LIST_HEAD_INIT(isapnp_device_driver.devices),
-};
-
-static inline int isapnp_init_device_tree(void)
-{
-	struct pci_bus *card;
-	struct pci_dev *parent = pci_find_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-
-	INIT_LIST_HEAD(&isapnp_device_driver.devices);
-
-	isapnp_for_each_card(card) {
-		struct list_head *devlist;
-
-		card->dev = isapnp_alloc(sizeof(*card->dev));
-		if (!card->dev)
-			break;
-		snprintf(card->dev->name, sizeof(card->dev->name), "%s", card->name);
-		sprintf(card->dev->bus_id, "isapnp%d", card->number);
-		card->dev->parent = parent ? &parent->dev : NULL;
-		card->dev->driver = &isapnp_device_driver;
-		device_register(card->dev);
-
-		for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
-			struct pci_dev *dev = pci_dev_b(devlist);
-
-			snprintf(dev->dev.name, sizeof(dev->dev.name), "%s", dev->name);
-			sprintf(dev->dev.bus_id, "%d", dev->devfn);
-			dev->dev.parent = card->dev;
-			dev->dev.driver = &isapnp_device_driver;
-			device_register(&dev->dev);
-		}
-	}
-
-	return 0;
-}
-
-int __init isapnp_init(void)
-{
-	int cards;
-	struct pci_bus *card;
-
-	if (isapnp_disable) {
-		isapnp_detected = 0;
-		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
-		return 0;
-	}
-#ifdef ISAPNP_REGION_OK
-	if (!request_region(_PIDXR, 1, "isapnp index")) {
-		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n", _PIDXR);
-		return -EBUSY;
-	}
-#endif
-	if (!request_region(_PNPWRP, 1, "isapnp write")) {
-		printk(KERN_ERR "isapnp: Write Data Register 0x%x already used\n", _PNPWRP);
-#ifdef ISAPNP_REGION_OK
-		release_region(_PIDXR, 1);
-#endif
-		return -EBUSY;
-	}
-	
-	/*
-	 *	Print a message. The existing ISAPnP code is hanging machines
-	 *	so let the user know where.
-	 */
-	 
-	printk(KERN_INFO "isapnp: Scanning for PnP cards...\n");
-	if (isapnp_rdp >= 0x203 && isapnp_rdp <= 0x3ff) {
-		isapnp_rdp |= 3;
-		if (!request_region(isapnp_rdp, 1, "isapnp read")) {
-			printk(KERN_ERR "isapnp: Read Data Register 0x%x already used\n", isapnp_rdp);
-#ifdef ISAPNP_REGION_OK
-			release_region(_PIDXR, 1);
-#endif
-			release_region(_PNPWRP, 1);
-			return -EBUSY;
-		}
-		isapnp_set_rdp();
-	}
-	isapnp_detected = 1;
-	if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
-		cards = isapnp_isolate();
-		if (cards < 0 || 
-		    (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
-#ifdef ISAPNP_REGION_OK
-			release_region(_PIDXR, 1);
-#endif
-			release_region(_PNPWRP, 1);
-			isapnp_detected = 0;
-			printk(KERN_INFO "isapnp: No Plug & Play device found\n");
-			return 0;
-		}
-		request_region(isapnp_rdp, 1, "isapnp read");
-	}
-	isapnp_build_device_list();
-	cards = 0;
-
-	isapnp_for_each_card(card) {
-		cards++;
-		if (isapnp_verbose) {
-			struct list_head *devlist;
-			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
-			if (isapnp_verbose < 2)
-				continue;
-			for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
-				struct pci_dev *dev = pci_dev_b(devlist);
-				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->name[0]?card->name:"Unknown");
-			}
-		}
-	}
-	if (cards) {
-		printk(KERN_INFO "isapnp: %i Plug & Play card%s detected total\n", cards, cards>1?"s":"");
-	} else {
-		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
-	}
-
-	isapnp_init_device_tree();
-
-#ifdef CONFIG_PROC_FS
-	isapnp_proc_init();
-#endif
-	return 0;
-}
-
-subsys_initcall(isapnp_init);
-
-#ifdef MODULE
-
-static inline void isapnp_cleanup_device_tree(void)
-{
-	struct pci_bus *card;
-
-	isapnp_for_each_card(card) {
-		struct list_head *devlist;
-
-		for (devlist = card->devices.next; devlist != &card->devices; devlist = devlist->next) {
-			struct pci_dev *dev = pci_dev_b(devlist);
-
-			put_device(&dev->dev);
-		}
-		put_device(card->dev);
-	}
-}
-
-void cleanup_module(void)
-{
-	if (isapnp_detected) {
-		isapnp_cleanup_device_tree();
-		isapnp_free_all_resources();
-	}
-}
-
-#else
-
-/* format is: noisapnp */
-
-static int __init isapnp_setup_disable(char *str)
-{
-	isapnp_disable = 1;
-	return 1;
-}
-
-__setup("noisapnp", isapnp_setup_disable);
-
-/* format is: isapnp=rdp,reset,skip_pci_scan,verbose */
-
-static int __init isapnp_setup_isapnp(char *str)
-{
-	(void)((get_option(&str,&isapnp_rdp) == 2) &&
-	       (get_option(&str,&isapnp_reset) == 2) &&
-	       (get_option(&str,&isapnp_skip_pci_scan) == 2) &&
-	       (get_option(&str,&isapnp_verbose) == 2));
-	return 1;
-}
-
-__setup("isapnp=", isapnp_setup_isapnp);
-
-/* format is: isapnp_reserve_irq=irq1[,irq2] .... */
-
-static int __init isapnp_setup_reserve_irq(char *str)
-{
-	int i;
-
-	for (i = 0; i < 16; i++)
-		if (get_option(&str,&isapnp_reserve_irq[i]) != 2)
-			break;
-	return 1;
-}
-
-__setup("isapnp_reserve_irq=", isapnp_setup_reserve_irq);
-
-/* format is: isapnp_reserve_dma=dma1[,dma2] .... */
-
-static int __init isapnp_setup_reserve_dma(char *str)
-{
-	int i;
-
-	for (i = 0; i < 8; i++)
-		if (get_option(&str,&isapnp_reserve_dma[i]) != 2)
-			break;
-	return 1;
-}
-
-__setup("isapnp_reserve_dma=", isapnp_setup_reserve_dma);
-
-/* format is: isapnp_reserve_io=io1,size1[,io2,size2] .... */
-
-static int __init isapnp_setup_reserve_io(char *str)
-{
-	int i;
-
-	for (i = 0; i < 16; i++)
-		if (get_option(&str,&isapnp_reserve_io[i]) != 2)
-			break;
-	return 1;
-}
-
-__setup("isapnp_reserve_io=", isapnp_setup_reserve_io);
-
-/* format is: isapnp_reserve_mem=mem1,size1[,mem2,size2] .... */
-
-static int __init isapnp_setup_reserve_mem(char *str)
-{
-	int i;
-
-	for (i = 0; i < 16; i++)
-		if (get_option(&str,&isapnp_reserve_mem[i]) != 2)
-			break;
-	return 1;
-}
-
-__setup("isapnp_reserve_mem=", isapnp_setup_reserve_mem);
-
-#endif
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp_proc.c b/drivers/pnp/isapnp_proc.c
--- a/drivers/pnp/isapnp_proc.c	Tue Oct 15 17:31:32 2002
+++ b/drivers/pnp/isapnp_proc.c	Thu Jan  1 00:00:00 1970
@@ -1,1134 +0,0 @@
-/*
- *  ISA Plug & Play support
- *  Copyright (c) by Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#define __NO_VERSION__
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/poll.h>
-#include <linux/vmalloc.h>
-#include <asm/uaccess.h>
-#include <linux/smp_lock.h>
-#include <linux/isapnp.h>
-
-struct isapnp_info_buffer {
-	char *buffer;		/* pointer to begin of buffer */
-	char *curr;		/* current position in buffer */
-	unsigned long size;	/* current size */
-	unsigned long len;	/* total length of buffer */
-	int stop;		/* stop flag */
-	int error;		/* error code */
-};
-
-typedef struct isapnp_info_buffer isapnp_info_buffer_t;
-
-static struct proc_dir_entry *isapnp_proc_entry = NULL;
-static struct proc_dir_entry *isapnp_proc_bus_dir = NULL;
-static struct proc_dir_entry *isapnp_proc_devices_entry = NULL;
-
-static void isapnp_info_read(isapnp_info_buffer_t *buffer);
-static void isapnp_info_write(isapnp_info_buffer_t *buffer);
-
-int isapnp_printf(isapnp_info_buffer_t * buffer, char *fmt,...)
-{
-	va_list args;
-	int res;
-	char sbuffer[512];
-
-	if (buffer->stop || buffer->error)
-		return 0;
-	va_start(args, fmt);
-	res = vsprintf(sbuffer, fmt, args);
-	va_end(args);
-	if (buffer->size + res >= buffer->len) {
-		buffer->stop = 1;
-		return 0;
-	}
-	strcpy(buffer->curr, sbuffer);
-	buffer->curr += res;
-	buffer->size += res;
-	return res;
-}
-
-static void isapnp_devid(char *str, unsigned short vendor, unsigned short device)
-{
-	sprintf(str, "%c%c%c%x%x%x%x",
-			'A' + ((vendor >> 2) & 0x3f) - 1,
-			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
-			'A' + ((vendor >> 8) & 0x1f) - 1,
-			(device >> 4) & 0x0f,
-			device & 0x0f,
-			(device >> 12) & 0x0f,
-			(device >> 8) & 0x0f);
-}
-
-static loff_t isapnp_info_entry_lseek(struct file *file, loff_t offset, int orig)
-{
-	loff_t ret;
-
-	lock_kernel();
-
-	switch (orig) {
-	case 0:	/* SEEK_SET */
-		file->f_pos = offset;
-		ret = file->f_pos;
-		break;
-	case 1:	/* SEEK_CUR */
-		file->f_pos += offset;
-		ret = file->f_pos;
-		break;
-	case 2:	/* SEEK_END */
-	default:
-		ret = -EINVAL;
-	}
-
-	unlock_kernel();
-	return ret;
-}
-
-static ssize_t isapnp_info_entry_read(struct file *file, char *buffer,
-				      size_t count, loff_t * offset)
-{
-	isapnp_info_buffer_t *buf;
-	long size = 0, size1;
-	int mode;
-
-	mode = file->f_flags & O_ACCMODE;
-	if (mode != O_RDONLY)
-		return -EINVAL;
-	buf = (isapnp_info_buffer_t *) file->private_data;
-	if (!buf)
-		return -EIO;
-	if (file->f_pos >= buf->size)
-		return 0;
-	size = buf->size < count ? buf->size : count;
-	size1 = buf->size - file->f_pos;
-	if (size1 < size)
-		size = size1;
-	if (copy_to_user(buffer, buf->buffer + file->f_pos, size))
-		return -EFAULT;
-	file->f_pos += size;
-	return size;
-}
-
-static ssize_t isapnp_info_entry_write(struct file *file, const char *buffer,
-				       size_t count, loff_t * offset)
-{
-	isapnp_info_buffer_t *buf;
-	long size = 0, size1;
-	int mode;
-
-	mode = file->f_flags & O_ACCMODE;
-	if (mode != O_WRONLY)
-		return -EINVAL;
-	buf = (isapnp_info_buffer_t *) file->private_data;
-	if (!buf)
-		return -EIO;
-	if (file->f_pos < 0)
-		return -EINVAL;
-	if (file->f_pos >= buf->len)
-		return -ENOMEM;
-	size = buf->len < count ? buf->len : count;
-	size1 = buf->len - file->f_pos;
-	if (size1 < size)
-		size = size1;
-	if (copy_from_user(buf->buffer + file->f_pos, buffer, size))
-		return -EFAULT;
-	if (buf->size < file->f_pos + size)
-		buf->size = file->f_pos + size;
-	file->f_pos += size;
-	return size;
-}
-
-static int isapnp_info_entry_open(struct inode *inode, struct file *file)
-{
-	isapnp_info_buffer_t *buffer;
-	int mode;
-
-	mode = file->f_flags & O_ACCMODE;
-	if (mode != O_RDONLY && mode != O_WRONLY)
-		return -EINVAL;
-	buffer = (isapnp_info_buffer_t *)
-				isapnp_alloc(sizeof(isapnp_info_buffer_t));
-	if (!buffer)
-		return -ENOMEM;
-	buffer->len = 4 * PAGE_SIZE;
-	buffer->buffer = vmalloc(buffer->len);
-	if (!buffer->buffer) {
-		kfree(buffer);
-		return -ENOMEM;
-	}
-	buffer->curr = buffer->buffer;
-	file->private_data = buffer;
-	if (mode == O_RDONLY)
-		isapnp_info_read(buffer);
-	return 0;
-}
-
-static int isapnp_info_entry_release(struct inode *inode, struct file *file)
-{
-	isapnp_info_buffer_t *buffer;
-	int mode;
-
-	if ((buffer = (isapnp_info_buffer_t *) file->private_data) == NULL)
-		return -EINVAL;
-	mode = file->f_flags & O_ACCMODE;
-	if (mode == O_WRONLY)
-		isapnp_info_write(buffer);
-	vfree(buffer->buffer);
-	kfree(buffer);
-	return 0;
-}
-
-static unsigned int isapnp_info_entry_poll(struct file *file, poll_table * wait)
-{
-	if (!file->private_data)
-		return 0;
-	return POLLIN | POLLRDNORM;
-}
-
-static struct file_operations isapnp_info_entry_operations =
-{
-	llseek:		isapnp_info_entry_lseek,
-	read:		isapnp_info_entry_read,
-	write:		isapnp_info_entry_write,
-	poll:		isapnp_info_entry_poll,
-	open:		isapnp_info_entry_open,
-	release:	isapnp_info_entry_release,
-};
-
-static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int whence)
-{
-	loff_t new = -1;
-
-	lock_kernel();
-	switch (whence) {
-	case 0:
-		new = off;
-		break;
-	case 1:
-		new = file->f_pos + off;
-		break;
-	case 2:
-		new = 256 + off;
-		break;
-	}
-	if (new < 0 || new > 256) {
-		unlock_kernel();
-		return -EINVAL;
-	}
-	unlock_kernel();
-	return (file->f_pos = new);
-}
-
-static ssize_t isapnp_proc_bus_read(struct file *file, char *buf, size_t nbytes, loff_t *ppos)
-{
-	struct inode *ino = file->f_dentry->d_inode;
-	struct proc_dir_entry *dp = PDE(ino);
-	struct pci_dev *dev = dp->data;
-	int pos = *ppos;
-	int cnt, size = 256;
-
-	if (pos >= size)
-		return 0;
-	if (nbytes >= size)
-		nbytes = size;
-	if (pos + nbytes > size)
-		nbytes = size - pos;
-	cnt = nbytes;
-
-	if (!access_ok(VERIFY_WRITE, buf, cnt))
-		return -EINVAL;
-		
-	isapnp_cfg_begin(dev->bus->number, dev->devfn);
-	for ( ; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
-		unsigned char val;
-		val = isapnp_read_byte(pos);
-		__put_user(val, buf);
-	}
-	isapnp_cfg_end();
-	
-	*ppos = pos;
-	return nbytes;
-}
-
-static struct file_operations isapnp_proc_bus_file_operations =
-{
-	llseek:		isapnp_proc_bus_lseek,
-	read:		isapnp_proc_bus_read,
-};
-
-static int isapnp_proc_attach_device(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->bus;
-	struct proc_dir_entry *de, *e;
-	char name[16];
-
-	if (!(de = bus->procdir)) {
-		sprintf(name, "%02x", bus->number);
-		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
-		if (!de)
-			return -ENOMEM;
-	}
-	sprintf(name, "%02x", dev->devfn);
-	e = dev->procent = create_proc_entry(name, S_IFREG | S_IRUGO, de);
-	if (!e)
-		return -ENOMEM;
-	e->proc_fops = &isapnp_proc_bus_file_operations;
-	e->owner = THIS_MODULE;
-	e->data = dev;
-	e->size = 256;
-	return 0;
-}
-
-#ifdef MODULE
-static int __exit isapnp_proc_detach_device(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->bus;
-	struct proc_dir_entry *de;
-	char name[16];
-
-	if (!(de = bus->procdir))
-		return -EINVAL;
-	sprintf(name, "%02x", dev->devfn);
-	remove_proc_entry(name, de);
-	return 0;
-}
-
-static int __exit isapnp_proc_detach_bus(struct pci_bus *bus)
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
-#endif
-
-static int isapnp_proc_read_devices(char *buf, char **start, off_t pos, int count)
-{
-	struct pci_dev *dev;
-	off_t at = 0;
-	int len, cnt, i;
-	
-	cnt = 0;
-	isapnp_for_each_dev(dev) {
-		char bus_id[8], device_id[8];
-	
-		isapnp_devid(bus_id, dev->bus->vendor, dev->bus->device);
-		isapnp_devid(device_id, dev->vendor, dev->device);
-		len = sprintf(buf, "%02x%02x\t%s%s\t",
-			dev->bus->number,
-			dev->devfn,
-			bus_id,
-			device_id);
-		isapnp_cfg_begin(dev->bus->number, dev->devfn);
-		len += sprintf(buf+len, "%02x", isapnp_read_byte(ISAPNP_CFG_ACTIVATE));
-		for (i = 0; i < 8; i++)
-			len += sprintf(buf+len, "%04x", isapnp_read_word(ISAPNP_CFG_PORT + (i << 1)));
-		for (i = 0; i < 2; i++)
-			len += sprintf(buf+len, "%04x", isapnp_read_word(ISAPNP_CFG_IRQ + (i << 1)));
-		for (i = 0; i < 2; i++)
-			len += sprintf(buf+len, "%04x", isapnp_read_word(ISAPNP_CFG_DMA + i));
-		for (i = 0; i < 4; i++)
-			len += sprintf(buf+len, "%08x", isapnp_read_dword(ISAPNP_CFG_MEM + (i << 3)));
-		isapnp_cfg_end();
-		buf[len++] = '\n';
-		at += len;
-		if (at >= pos) {
-			if (!*start) {
-				*start = buf + (pos - (at - len));
-				cnt = at - pos;
-			} else
-				cnt += len;
-			buf += len;
-		}
-	}
-	return (count > cnt) ? cnt : count;
-}
-
-int __init isapnp_proc_init(void)
-{
-	struct proc_dir_entry *p;
-	struct pci_dev *dev;
-
-	isapnp_proc_entry = NULL;
-	p = create_proc_entry("isapnp", S_IFREG | S_IRUGO | S_IWUSR, &proc_root);
-	if (p) {
-		p->proc_fops = &isapnp_info_entry_operations;
-		p->owner = THIS_MODULE;
-	}
-	isapnp_proc_entry = p;
-	isapnp_proc_bus_dir = proc_mkdir("isapnp", proc_bus);
-	isapnp_proc_devices_entry = create_proc_info_entry("devices", 0,
-							   isapnp_proc_bus_dir,
-							   isapnp_proc_read_devices);
-	isapnp_for_each_dev(dev) {
-		isapnp_proc_attach_device(dev);
-	}
-	return 0;
-}
-
-#ifdef MODULE
-int __exit isapnp_proc_done(void)
-{
-	struct pci_dev *dev;
-	struct pci_bus *card;
-
-	isapnp_for_each_dev(dev) {
-		isapnp_proc_detach_device(dev);
-	}
-	isapnp_for_each_card(card) {
-		isapnp_proc_detach_bus(card);
-	}
-	if (isapnp_proc_devices_entry)
-		remove_proc_entry("devices", isapnp_proc_devices_entry);
-	if (isapnp_proc_bus_dir)
-		remove_proc_entry("isapnp", proc_bus);
-	if (isapnp_proc_entry)
-		remove_proc_entry("isapnp", &proc_root);
-	return 0;
-}
-#endif /* MODULE */
-
-/*
- *
- */
-
-static void isapnp_print_devid(isapnp_info_buffer_t *buffer, unsigned short vendor, unsigned short device)
-{
-	char tmp[8];
-	
-	isapnp_devid(tmp, vendor, device);
-	isapnp_printf(buffer, tmp);
-}
-
-static void isapnp_print_compatible(isapnp_info_buffer_t *buffer, struct pci_dev *dev)
-{
-	int idx;
-
-	for (idx = 0; idx < DEVICE_COUNT_COMPATIBLE; idx++) {
-		if (dev->vendor_compatible[idx] == 0)
-			continue;
-		isapnp_printf(buffer, "    Compatible device ");
-		isapnp_print_devid(buffer,
-				   dev->vendor_compatible[idx],
-				   dev->device_compatible[idx]);
-		isapnp_printf(buffer, "\n");
-	}
-}
-
-static void isapnp_print_port(isapnp_info_buffer_t *buffer, char *space, struct isapnp_port *port)
-{
-	isapnp_printf(buffer, "%sPort 0x%x-0x%x, align 0x%x, size 0x%x, %i-bit address decoding\n",
-			space, port->min, port->max, port->align ? (port->align-1) : 0, port->size,
-			port->flags & ISAPNP_PORT_FLAG_16BITADDR ? 16 : 10);
-}
-
-static void isapnp_print_irq(isapnp_info_buffer_t *buffer, char *space, struct isapnp_irq *irq)
-{
-	int first = 1, i;
-
-	isapnp_printf(buffer, "%sIRQ ", space);
-	for (i = 0; i < 16; i++)
-		if (irq->map & (1<<i)) {
-			if (!first) {
-				isapnp_printf(buffer, ",");
-			} else {
-				first = 0;
-			}
-			if (i == 2 || i == 9)
-				isapnp_printf(buffer, "2/9");
-			else
-				isapnp_printf(buffer, "%i", i);
-		}
-	if (!irq->map)
-		isapnp_printf(buffer, "<none>");
-	if (irq->flags & IORESOURCE_IRQ_HIGHEDGE)
-		isapnp_printf(buffer, " High-Edge");
-	if (irq->flags & IORESOURCE_IRQ_LOWEDGE)
-		isapnp_printf(buffer, " Low-Edge");
-	if (irq->flags & IORESOURCE_IRQ_HIGHLEVEL)
-		isapnp_printf(buffer, " High-Level");
-	if (irq->flags & IORESOURCE_IRQ_LOWLEVEL)
-		isapnp_printf(buffer, " Low-Level");
-	isapnp_printf(buffer, "\n");
-}
-
-static void isapnp_print_dma(isapnp_info_buffer_t *buffer, char *space, struct isapnp_dma *dma)
-{
-	int first = 1, i;
-	char *s;
-
-	isapnp_printf(buffer, "%sDMA ", space);
-	for (i = 0; i < 8; i++)
-		if (dma->map & (1<<i)) {
-			if (!first) {
-				isapnp_printf(buffer, ",");
-			} else {
-				first = 0;
-			}
-			isapnp_printf(buffer, "%i", i);
-		}
-	if (!dma->map)
-		isapnp_printf(buffer, "<none>");
-	switch (dma->flags & IORESOURCE_DMA_TYPE_MASK) {
-	case IORESOURCE_DMA_8BIT:
-		s = "8-bit";
-		break;
-	case IORESOURCE_DMA_8AND16BIT:
-		s = "8-bit&16-bit";
-		break;
-	default:
-		s = "16-bit";
-	}
-	isapnp_printf(buffer, " %s", s);
-	if (dma->flags & IORESOURCE_DMA_MASTER)
-		isapnp_printf(buffer, " master");
-	if (dma->flags & IORESOURCE_DMA_BYTE)
-		isapnp_printf(buffer, " byte-count");
-	if (dma->flags & IORESOURCE_DMA_WORD)
-		isapnp_printf(buffer, " word-count");
-	switch (dma->flags & IORESOURCE_DMA_SPEED_MASK) {
-	case IORESOURCE_DMA_TYPEA:
-		s = "type-A";
-		break;
-	case IORESOURCE_DMA_TYPEB:
-		s = "type-B";
-		break;
-	case IORESOURCE_DMA_TYPEF:
-		s = "type-F";
-		break;
-	default:
-		s = "compatible";
-		break;
-	}
-	isapnp_printf(buffer, " %s\n", s);
-}
-
-static void isapnp_print_mem(isapnp_info_buffer_t *buffer, char *space, struct isapnp_mem *mem)
-{
-	char *s;
-
-	isapnp_printf(buffer, "%sMemory 0x%x-0x%x, align 0x%x, size 0x%x",
-			space, mem->min, mem->max, mem->align, mem->size);
-	if (mem->flags & IORESOURCE_MEM_WRITEABLE)
-		isapnp_printf(buffer, ", writeable");
-	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
-		isapnp_printf(buffer, ", cacheable");
-	if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
-		isapnp_printf(buffer, ", range-length");
-	if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
-		isapnp_printf(buffer, ", shadowable");
-	if (mem->flags & IORESOURCE_MEM_EXPANSIONROM)
-		isapnp_printf(buffer, ", expansion ROM");
-	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
-	case IORESOURCE_MEM_8BIT:
-		s = "8-bit";
-		break;
-	case IORESOURCE_MEM_8AND16BIT:
-		s = "8-bit&16-bit";
-		break;
-	default:
-		s = "16-bit";
-	}
-	isapnp_printf(buffer, ", %s\n", s);
-}
-
-static void isapnp_print_mem32(isapnp_info_buffer_t *buffer, char *space, struct isapnp_mem32 *mem32)
-{
-	int first = 1, i;
-
-	isapnp_printf(buffer, "%s32-bit memory ", space);
-	for (i = 0; i < 17; i++) {
-		if (first) {
-			first = 0;
-		} else {
-			isapnp_printf(buffer, ":");
-		}
-		isapnp_printf(buffer, "%02x", mem32->data[i]);
-	}
-}
-
-static void isapnp_print_resources(isapnp_info_buffer_t *buffer, char *space, struct isapnp_resources *res)
-{
-	char *s;
-	struct isapnp_port *port;
-	struct isapnp_irq *irq;
-	struct isapnp_dma *dma;
-	struct isapnp_mem *mem;
-	struct isapnp_mem32 *mem32;
-
-	switch (res->priority) {
-	case ISAPNP_RES_PRIORITY_PREFERRED:
-		s = "preferred";
-		break;
-	case ISAPNP_RES_PRIORITY_ACCEPTABLE:
-		s = "acceptable";
-		break;
-	case ISAPNP_RES_PRIORITY_FUNCTIONAL:
-		s = "functional";
-		break;
-	default:
-		s = "invalid";
-	}
-	isapnp_printf(buffer, "%sPriority %s\n", space, s);
-	for (port = res->port; port; port = port->next)
-		isapnp_print_port(buffer, space, port);
-	for (irq = res->irq; irq; irq = irq->next)
-		isapnp_print_irq(buffer, space, irq);
-	for (dma = res->dma; dma; dma = dma->next)
-		isapnp_print_dma(buffer, space, dma);
-	for (mem = res->mem; mem; mem = mem->next)
-		isapnp_print_mem(buffer, space, mem);
-	for (mem32 = res->mem32; mem32; mem32 = mem32->next)
-		isapnp_print_mem32(buffer, space, mem32);
-}
-
-static void isapnp_print_configuration(isapnp_info_buffer_t *buffer, struct pci_dev *dev)
-{
-	int i, tmp, next;
-	char *space = "    ";
-
-	isapnp_cfg_begin(dev->bus->number, dev->devfn);
-	isapnp_printf(buffer, "%sDevice is %sactive\n",
-			space, isapnp_read_byte(ISAPNP_CFG_ACTIVATE)?"":"not ");
-	for (i = next = 0; i < 8; i++) {
-		tmp = isapnp_read_word(ISAPNP_CFG_PORT + (i << 1));
-		if (!tmp)
-			continue;
-		if (!next) {
-			isapnp_printf(buffer, "%sActive port ", space);
-			next = 1;
-		}
-		isapnp_printf(buffer, "%s0x%x", i > 0 ? "," : "", tmp);
-	}
-	if (next)
-		isapnp_printf(buffer, "\n");
-	for (i = next = 0; i < 2; i++) {
-		tmp = isapnp_read_word(ISAPNP_CFG_IRQ + (i << 1));
-		if (!(tmp >> 8))
-			continue;
-		if (!next) {
-			isapnp_printf(buffer, "%sActive IRQ ", space);
-			next = 1;
-		}
-		isapnp_printf(buffer, "%s%i", i > 0 ? "," : "", tmp >> 8);
-		if (tmp & 0xff)
-			isapnp_printf(buffer, " [0x%x]", tmp & 0xff);
-	}
-	if (next)
-		isapnp_printf(buffer, "\n");
-	for (i = next = 0; i < 2; i++) {
-		tmp = isapnp_read_byte(ISAPNP_CFG_DMA + i);
-		if (tmp == 4)
-			continue;
-		if (!next) {
-			isapnp_printf(buffer, "%sActive DMA ", space);
-			next = 1;
-		}
-		isapnp_printf(buffer, "%s%i", i > 0 ? "," : "", tmp);
-	}
-	if (next)
-		isapnp_printf(buffer, "\n");
-	for (i = next = 0; i < 4; i++) {
-		tmp = isapnp_read_dword(ISAPNP_CFG_MEM + (i << 3));
-		if (!tmp)
-			continue;
-		if (!next) {
-			isapnp_printf(buffer, "%sActive memory ", space);
-			next = 1;
-		}
-		isapnp_printf(buffer, "%s0x%x", i > 0 ? "," : "", tmp);
-	}
-	if (next)
-		isapnp_printf(buffer, "\n");
-	isapnp_cfg_end();
-}
-
-static void isapnp_print_device(isapnp_info_buffer_t *buffer, struct pci_dev *dev)
-{
-	int block, block1;
-	char *space = "    ";
-	struct isapnp_resources *res, *resa;
-
-	if (!dev)
-		return;
-	isapnp_printf(buffer, "  Logical device %i '", dev->devfn);
-	isapnp_print_devid(buffer, dev->vendor, dev->device);
-	isapnp_printf(buffer, ":%s'", dev->name[0]?dev->name:"Unknown");
-	isapnp_printf(buffer, "\n");
-#if 0
-	isapnp_cfg_begin(dev->bus->number, dev->devfn);
-	for (block = 0; block < 128; block++)
-		if ((block % 16) == 15)
-			isapnp_printf(buffer, "%02x\n", isapnp_read_byte(block));
-		else
-			isapnp_printf(buffer, "%02x:", isapnp_read_byte(block));
-	isapnp_cfg_end();
-#endif
-	if (dev->regs)
-		isapnp_printf(buffer, "%sSupported registers 0x%x\n", space, dev->regs);
-	isapnp_print_compatible(buffer, dev);
-	isapnp_print_configuration(buffer, dev);
-	for (res = (struct isapnp_resources *)dev->sysdata, block = 0; res; res = res->next, block++) {
-		isapnp_printf(buffer, "%sResources %i\n", space, block);
-		isapnp_print_resources(buffer, "      ", res);
-		for (resa = res->alt, block1 = 1; resa; resa = resa->alt, block1++) {
-			isapnp_printf(buffer, "%s  Alternate resources %i:%i\n", space, block, block1);
-			isapnp_print_resources(buffer, "        ", resa);
-		}
-	}
-}
-
-/*
- *  Main read routine
- */
- 
-static void isapnp_info_read(isapnp_info_buffer_t *buffer)
-{
-	struct pci_bus *card;
-
-	isapnp_for_each_card(card) {
-		struct list_head *dev_list;
-
-		isapnp_printf(buffer, "Card %i '", card->number);
-		isapnp_print_devid(buffer, card->vendor, card->device);
-		isapnp_printf(buffer, ":%s'", card->name[0]?card->name:"Unknown");
-		if (card->pnpver)
-			isapnp_printf(buffer, " PnP version %x.%x", card->pnpver >> 4, card->pnpver & 0x0f);
-		if (card->productver)
-			isapnp_printf(buffer, " Product version %x.%x", card->productver >> 4, card->productver & 0x0f);
-		isapnp_printf(buffer,"\n");
-		for (dev_list = card->devices.next; dev_list != &card->devices; dev_list = dev_list->next)
-			isapnp_print_device(buffer, pci_dev_b(dev_list));
-	}
-}
-
-/*
- *
- */
-
-static struct pci_bus *isapnp_info_card;
-static struct pci_dev *isapnp_info_device;
-
-static char *isapnp_get_str(char *dest, char *src, int len)
-{
-	int c;
-
-	while (*src == ' ' || *src == '\t')
-		src++;
-	if (*src == '"' || *src == '\'') {
-		c = *src++;
-		while (--len > 0 && *src && *src != c) {
-			*dest++ = *src++;
-		}
-		if (*src == c)
-			src++;
-	} else {
-		while (--len > 0 && *src && *src != ' ' && *src != '\t') {
-			*dest++ = *src++;
-		}
-	}
-	*dest = 0;
-	while (*src == ' ' || *src == '\t')
-		src++;
-	return src;
-}
-
-static unsigned char isapnp_get_hex(unsigned char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return (c - 'a') + 10;
-	if (c >= 'A' && c <= 'F')
-		return (c - 'A') + 10;
-	return 0;
-}
-
-static unsigned int isapnp_parse_id(const char *id)
-{
-	if (strlen(id) != 7) {
-		printk("isapnp: wrong PnP ID\n");
-		return 0;
-	}
-	return (ISAPNP_VENDOR(id[0], id[1], id[2])<<16) |
-			(isapnp_get_hex(id[3])<<4) |
-			(isapnp_get_hex(id[4])<<0) |
-			(isapnp_get_hex(id[5])<<12) |
-			(isapnp_get_hex(id[6])<<8);
-}
-
-static int isapnp_set_card(char *line)
-{
-	int idx, idx1;
-	unsigned int id;
-	char index[16], value[32];
-
-	if (isapnp_info_card) {
-		isapnp_cfg_end();
-		isapnp_info_card = NULL;
-	}
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	idx = idx1 = simple_strtoul(index, NULL, 0);
-	id = isapnp_parse_id(value);
-	isapnp_info_card = isapnp_find_card(id >> 16, id & 0xffff, NULL);
-	while (isapnp_info_card && idx1-- > 0)
-		isapnp_info_card = isapnp_find_card(id >> 16, id & 0xffff, isapnp_info_card);
-	if (isapnp_info_card == NULL) {
-		printk("isapnp: card '%s' order %i not found\n", value, idx);
-		return 1;
-	}
-	if (isapnp_cfg_begin(isapnp_info_card->number, -1)<0) {
-		printk("isapnp: configuration start sequence for device '%s' failed\n", value);
-		isapnp_info_card = NULL;
-		return 1;
-	}
-	return 0;
-}
-
-static int isapnp_select_csn(char *line)
-{
-	int csn;
-	struct list_head *list;
-	char index[16], value[32];
-
-	isapnp_info_device = NULL;
-	isapnp_get_str(index, line, sizeof(index));
-	csn = simple_strtoul(index, NULL, 0);
-
-	for (list = isapnp_cards.next; list != &isapnp_cards; list = list->next) {
-		isapnp_info_card = pci_bus_b(list);
-		if (isapnp_info_card->number == csn)
-			break;
-	}
-	if (list == &isapnp_cards) {
-		printk("isapnp: cannot find CSN %i\n", csn);
-		return 1;
-	}
-	if (isapnp_cfg_begin(isapnp_info_card->number, -1)<0) {
-		printk("isapnp: configuration start sequence for device '%s' failed\n", value);
-		isapnp_info_card = NULL;
-		return 1;
-	}
-	return 0;
-}
-
-static int isapnp_set_device(char *line)
-{
-	int idx, idx1;
-	unsigned int id;
-	char index[16], value[32];
-
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	idx = idx1 = simple_strtoul(index, NULL, 0);
-	id = isapnp_parse_id(value);
-	isapnp_info_device = isapnp_find_dev(isapnp_info_card, id >> 16, id & 0xffff, NULL);
-	while (isapnp_info_device && idx-- > 0)
-		isapnp_info_device = isapnp_find_dev(isapnp_info_card, id >> 16, id & 0xffff, isapnp_info_device);
-	if (isapnp_info_device == NULL) {
-		printk("isapnp: device '%s' order %i not found\n", value, idx);
-		return 1;
-	}
-	isapnp_device(isapnp_info_device->devfn);
-	return 0;
-}
-
-static int isapnp_autoconfigure(void)
-{
-	isapnp_cfg_end();
-	if (isapnp_info_device->active)
-		isapnp_info_device->deactivate(isapnp_info_device);
-	if (isapnp_info_device->prepare(isapnp_info_device) < 0) {
-		printk("isapnp: cannot prepare device for the activation");
-		return 0;
-	}
-	if (isapnp_info_device->activate(isapnp_info_device) < 0) {
-		printk("isapnp: cannot activate device");
-		return 0;
-	}
-	if (isapnp_cfg_begin(isapnp_info_card->number, -1)<0) {
-		printk("isapnp: configuration start sequence for card %d failed\n", isapnp_info_card->number);
-		isapnp_info_card = NULL;
-		isapnp_info_device = NULL;
-		return 1;
-	}
-	isapnp_device(isapnp_info_device->devfn);
-	return 0;
-}
-
-static int isapnp_set_port(char *line)
-{
-	int idx, port;
-	char index[16], value[32];
-
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	idx = simple_strtoul(index, NULL, 0);
-	port = simple_strtoul(value, NULL, 0);
-	if (idx < 0 || idx > 7) {
-		printk("isapnp: wrong port index %i\n", idx);
-		return 1;
-	}
-	if (port < 0 || port > 0xffff) {
-		printk("isapnp: wrong port value 0x%x\n", port);
-		return 1;
-	}
-	isapnp_write_word(ISAPNP_CFG_PORT + (idx << 1), port);
-	if (!isapnp_info_device->resource[idx].flags)
-		return 0;
-	if (isapnp_info_device->resource[idx].flags & IORESOURCE_AUTO) {
-		isapnp_info_device->resource[idx].start = port;
-		isapnp_info_device->resource[idx].end += port - 1;
-		isapnp_info_device->resource[idx].flags &= ~IORESOURCE_AUTO;
-	} else {
-		isapnp_info_device->resource[idx].end -= isapnp_info_device->resource[idx].start;
-		isapnp_info_device->resource[idx].start = port;
-		isapnp_info_device->resource[idx].end += port;
-	}
-	return 0;
-}
-
-static void isapnp_set_irqresource(struct resource *res, int irq)
-{
-	res->start = res->end = irq;
-	res->flags = IORESOURCE_IRQ;
-}
- 
-static int isapnp_set_irq(char *line)
-{
-	int idx, irq;
-	char index[16], value[32];
-
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	idx = simple_strtoul(index, NULL, 0);
-	irq = simple_strtoul(value, NULL, 0);
-	if (idx < 0 || idx > 1) {
-		printk("isapnp: wrong IRQ index %i\n", idx);
-		return 1;
-	}
-	if (irq == 2)
-		irq = 9;
-	if (irq < 0 || irq > 15) {
-		printk("isapnp: wrong IRQ value %i\n", irq);
-		return 1;
-	}
-	isapnp_write_byte(ISAPNP_CFG_IRQ + (idx << 1), irq);
-	isapnp_set_irqresource(isapnp_info_device->irq_resource + idx, irq);
-	return 0;
-}
- 
-static void isapnp_set_dmaresource(struct resource *res, int dma)
-{
-	res->start = res->end = dma;
-	res->flags = IORESOURCE_DMA;
-}
-
-extern int isapnp_allow_dma0;
-static int isapnp_set_allow_dma0(char *line)
-{
-	int i;
-	char value[32];
-
-	isapnp_get_str(value, line, sizeof(value));
-	i = simple_strtoul(value, NULL, 0);
-	if (i < 0 || i > 1) {
-		printk("isapnp: wrong value %i for allow_dma0\n", i);
-		return 1;
-	}
-	isapnp_allow_dma0 = i;
-	return 0;
-}
- 
-static int isapnp_set_dma(char *line)
-{
-	int idx, dma;
-	char index[16], value[32];
-
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	idx = simple_strtoul(index, NULL, 0);
-	dma = simple_strtoul(value, NULL, 0);
-	if (idx < 0 || idx > 1) {
-		printk("isapnp: wrong DMA index %i\n", idx);
-		return 1;
-	}
-	if (dma < 0 || dma > 7) {
-		printk("isapnp: wrong DMA value %i\n", dma);
-		return 1;
-	}
-	isapnp_write_byte(ISAPNP_CFG_DMA + idx, dma);
-	isapnp_set_dmaresource(isapnp_info_device->dma_resource + idx, dma);
-	return 0;
-}
- 
-static int isapnp_set_mem(char *line)
-{
-	int idx;
-	unsigned int mem;
-	char index[16], value[32];
-
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	idx = simple_strtoul(index, NULL, 0);
-	mem = simple_strtoul(value, NULL, 0);
-	if (idx < 0 || idx > 3) {
-		printk("isapnp: wrong memory index %i\n", idx);
-		return 1;
-	}
-	mem >>= 8;
-	isapnp_write_word(ISAPNP_CFG_MEM + (idx<<2), mem & 0xffff);
-	if (!isapnp_info_device->resource[idx + 8].flags)
-		return 0;
-	if (isapnp_info_device->resource[idx + 8].flags & IORESOURCE_AUTO) {
-		isapnp_info_device->resource[idx + 8].start = mem & ~0x00ffff00;
-		isapnp_info_device->resource[idx + 8].end += (mem & ~0x00ffff00) - 1;
-		isapnp_info_device->resource[idx + 8].flags &= ~IORESOURCE_AUTO;
-	} else {
-		isapnp_info_device->resource[idx + 8].end -= isapnp_info_device->resource[idx + 8].start;
-		isapnp_info_device->resource[idx + 8].start = mem & ~0x00ffff00;
-		isapnp_info_device->resource[idx + 8].end += mem & ~0x00ffff00;
-	}
-	return 0;
-}
- 
-static int isapnp_poke(char *line, int what)
-{
-	int reg;
-	unsigned int val;
-	char index[16], value[32];
-
-	line = isapnp_get_str(index, line, sizeof(index));
-	isapnp_get_str(value, line, sizeof(value));
-	reg = simple_strtoul(index, NULL, 0);
-	val = simple_strtoul(value, NULL, 0);
-	if (reg < 0 || reg > 127) {
-		printk("isapnp: wrong register %i\n", reg);
-		return 1;
-	}
-	switch (what) {
-	case 1:
-		isapnp_write_word(reg, val);
-		break;
-	case 2:
-		isapnp_write_dword(reg, val);
-		break;
-	default:
-		isapnp_write_byte(reg, val);
-		break;
-	}
-	return 0;
-}
- 
-static int isapnp_decode_line(char *line)
-{
-	char cmd[32];
-
-	line = isapnp_get_str(cmd, line, sizeof(cmd));
-	if (!strcmp(cmd, "allow_dma0"))
-		return isapnp_set_allow_dma0(line);
-	if (!strcmp(cmd, "card"))
-		return isapnp_set_card(line);
-	if (!strcmp(cmd, "csn"))
-		return isapnp_select_csn(line);
-	if (!isapnp_info_card) {
-		printk("isapnp: card is not selected\n");
-		return 1;
-	}
-	if (!strncmp(cmd, "dev", 3))
-		return isapnp_set_device(line);
-	if (!isapnp_info_device) {
-		printk("isapnp: device is not selected\n");
-		return 1;
-	}
-	if (!strncmp(cmd, "auto", 4))
-		return isapnp_autoconfigure();
-	if (!strncmp(cmd, "act", 3)) {
-		isapnp_activate(isapnp_info_device->devfn);
-		isapnp_info_device->active = 1;
-		return 0;
-	}
-	if (!strncmp(cmd, "deact", 5)) {
-		isapnp_deactivate(isapnp_info_device->devfn);
-		isapnp_info_device->active = 0;
-		return 0;
-	}
-	if (!strcmp(cmd, "port"))
-		return isapnp_set_port(line);
-	if (!strcmp(cmd, "irq"))
-		return isapnp_set_irq(line);
-	if (!strcmp(cmd, "dma"))
-		return isapnp_set_dma(line);
-	if (!strncmp(cmd, "mem", 3))
-		return isapnp_set_mem(line);
-	if (!strcmp(cmd, "poke"))
-		return isapnp_poke(line, 0);
-	if (!strcmp(cmd, "pokew"))
-		return isapnp_poke(line, 1);
-	if (!strcmp(cmd, "poked"))
-		return isapnp_poke(line, 2);
-	printk("isapnp: wrong command '%s'\n", cmd);
-	return 1;
-}
-
-/*
- *  Main write routine
- */
-
-static void isapnp_info_write(isapnp_info_buffer_t *buffer)
-{
-	int c, idx, idx1 = 0;
-	char line[128];
-
-	if (buffer->size <= 0)
-		return;
-	isapnp_info_card = NULL;
-	isapnp_info_device = NULL;
-	for (idx = 0; idx < buffer->size; idx++) {
-		c = buffer->buffer[idx];
-		if (c == '\n') {
-			line[idx1] = '\0';
-			if (line[0] != '#') {
-				if (isapnp_decode_line(line))
-					goto __end;
-			}
-			idx1 = 0;
-			continue;
-		}
-		if (idx1 >= sizeof(line)-1) {
-			printk("isapnp: line too long, aborting\n");
-			return;
-		}
-		line[idx1++] = c;
-	}
-      __end:
-	if (isapnp_info_card)
-		isapnp_cfg_end();
-}
diff -ur --new-file --exclude *.flags a/drivers/pnp/names.c b/drivers/pnp/names.c
--- a/drivers/pnp/names.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/names.c	Fri Oct 11 14:00:11 2002
@@ -0,0 +1,51 @@
+/*
+ * names.c - a very simple name database for PnP devices
+ *
+ * Some code is based on names.c from linux pci
+ * Copyright 1993--1999 Drew Eckhardt, Frederic Potter,
+ * David Mosberger-Tang, Martin Mares
+ *
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+#include <linux/string.h>
+#include <linux/pnp.h>
+
+#include "base.h"
+
+#ifdef CONFIG_PNP_NAMES
+
+static char *pnp_id_eisaid[] = {
+#define ID(x,y) x,
+#include "idlist.h"
+};
+
+static char *pnp_id_names[] = {
+#define ID(x,y) y,
+#include "idlist.h"
+};
+
+void
+pnp_name_device(struct pnp_dev *dev)
+{
+	int i;
+	char *name = dev->name;
+	for(i=0; i<sizeof(pnp_id_eisaid)/sizeof(pnp_id_eisaid[0]); i++){
+		if (compare_pnp_id(&dev->ids,pnp_id_eisaid[i])){
+			sprintf(name, "%s", pnp_id_names[i]);
+			return;
+		}
+	}
+	return;
+}
+
+#else
+
+void
+pnp_name_device(struct pnp_dev *dev)
+{
+	return;
+}
+
+#endif /* CONFIG_PNP_NAMES */
diff -ur --new-file --exclude *.flags a/drivers/pnp/pnpbios/Makefile b/drivers/pnp/pnpbios/Makefile
--- a/drivers/pnp/pnpbios/Makefile	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/pnpbios/Makefile	Tue Oct  8 17:18:29 2002
@@ -0,0 +1,11 @@
+#
+# Makefile for the kernel PNPBIOS driver.
+#
+
+export-objs := core.o
+
+pnpbios-proc-$(CONFIG_PROC_FS) = proc.o
+
+obj-y := core.o $(pnpbios-proc-y)
+
+include $(TOPDIR)/Rules.make
diff -ur --new-file --exclude *.flags a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/pnpbios/core.c	Tue Oct 15 15:13:38 2002
@@ -0,0 +1,1571 @@
+/*
+ * pnpbios -- PnP BIOS driver
+ *
+ * This driver provides access to Plug-'n'-Play services provided by
+ * the PnP BIOS firmware, described in the following documents:
+ *   Plug and Play BIOS Specification, Version 1.0A, 5 May 1994
+ *   Plug and Play BIOS Clarification Paper, 6 October 1994
+ *     Compaq Computer Corporation, Phoenix Technologies Ltd., Intel Corp.
+ * 
+ * Originally (C) 1998 Christian Schmidt <schmidt-IABvq36EpHazQB+pC5nmwQ@public.gmane.org>
+ * Modifications (C) 1998 Tom Lees <tom-jMAA5W8IFouX/4koqx8SDw@public.gmane.org>
+ * Minor reorganizations by David Hinds <dahinds-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
+ * Further modifications (C) 2001, 2002 by:
+ *   Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *   Thomas Hood <jdthood-O5WfVfzUwx8@public.gmane.org>
+ *   Brian Gerst <bgerst-Gk3hQYvpvHrdtAWm4Da02A@public.gmane.org>
+ *
+ * Ported to the PnP Layer and several additional improvements (C) 2002
+ * by Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/pnpbios.h>
+#include <linux/device.h>
+#include <linux/pnp.h>
+#include <asm/page.h>
+#include <asm/system.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <asm/desc.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/kmod.h>
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
+#include <asm/byteorder.h>
+
+
+/*
+ *
+ * PnP BIOS INTERFACE
+ *
+ */
+
+/* PnP BIOS signature: "$PnP" */
+#define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
+
+#pragma pack(1)
+union pnp_bios_expansion_header {
+	struct {
+		u32 signature;    /* "$PnP" */
+		u8 version;	  /* in BCD */
+		u8 length;	  /* length in bytes, currently 21h */
+		u16 control;	  /* system capabilities */
+		u8 checksum;	  /* all bytes must add up to 0 */
+
+		u32 eventflag;    /* phys. address of the event flag */
+		u16 rmoffset;     /* real mode entry point */
+		u16 rmcseg;
+		u16 pm16offset;   /* 16 bit protected mode entry */
+		u32 pm16cseg;
+		u32 deviceID;	  /* EISA encoded system ID or 0 */
+		u16 rmdseg;	  /* real mode data segment */
+		u32 pm16dseg;	  /* 16 bit pm data segment base */
+	} fields;
+	char chars[0x21];	  /* To calculate the checksum */
+};
+#pragma pack()
+
+static struct {
+	u16	offset;
+	u16	segment;
+} pnp_bios_callpoint;
+
+static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
+
+/* The PnP BIOS entries in the GDT */
+#define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
+
+#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
+#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
+#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
+#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
+#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
+
+/* 
+ * These are some opcodes for a "static asmlinkage"
+ * As this code is *not* executed inside the linux kernel segment, but in a
+ * alias at offset 0, we need a far return that can not be compiled by
+ * default (please, prove me wrong! this is *really* ugly!) 
+ * This is the only way to get the bios to return into the kernel code,
+ * because the bios code runs in 16 bit protected mode and therefore can only
+ * return to the caller if the call is within the first 64kB, and the linux
+ * kernel begins at offset 3GB...
+ */
+
+asmlinkage void pnp_bios_callfunc(void);
+
+__asm__(
+	".text			\n"
+	__ALIGN_STR "\n"
+	"pnp_bios_callfunc:\n"
+	"	pushl %edx	\n"
+	"	pushl %ecx	\n"
+	"	pushl %ebx	\n"
+	"	pushl %eax	\n"
+	"	lcallw *pnp_bios_callpoint\n"
+	"	addl $16, %esp	\n"
+	"	lret		\n"
+	".previous		\n"
+);
+
+#define Q_SET_SEL(cpu, selname, address, size) \
+do { \
+set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+} while(0)
+
+#define Q2_SET_SEL(cpu, selname, address, size) \
+do { \
+set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+} while(0)
+
+/*
+ * At some point we want to use this stack frame pointer to unwind
+ * after PnP BIOS oopses. 
+ */
+ 
+u32 pnp_bios_fault_esp;
+u32 pnp_bios_fault_eip;
+u32 pnp_bios_is_utter_crap = 0;
+
+static spinlock_t pnp_bios_lock;
+
+static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
+				u16 arg4, u16 arg5, u16 arg6, u16 arg7,
+				void *ts1_base, u32 ts1_size,
+				void *ts2_base, u32 ts2_size)
+{
+	unsigned long flags;
+	u16 status;
+
+	/*
+	 * PnP BIOSes are generally not terribly re-entrant.
+	 * Also, don't rely on them to save everything correctly.
+	 */
+	if(pnp_bios_is_utter_crap)
+		return PNP_FUNCTION_NOT_SUPPORTED;
+
+	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
+	spin_lock_irqsave(&pnp_bios_lock, flags);
+
+	/* The lock prevents us bouncing CPU here */
+	if (ts1_size)
+		Q2_SET_SEL(smp_processor_id(), PNP_TS1, ts1_base, ts1_size);
+	if (ts2_size)
+		Q2_SET_SEL(smp_processor_id(), PNP_TS2, ts2_base, ts2_size);
+
+	__asm__ __volatile__(
+	        "pushl %%ebp\n\t"
+		"pushl %%edi\n\t"
+		"pushl %%esi\n\t"
+		"pushl %%ds\n\t"
+		"pushl %%es\n\t"
+		"pushl %%fs\n\t"
+		"pushl %%gs\n\t"
+		"pushfl\n\t"
+		"movl %%esp, pnp_bios_fault_esp\n\t"
+		"movl $1f, pnp_bios_fault_eip\n\t"
+		"lcall %5,%6\n\t"
+		"1:popfl\n\t"
+		"popl %%gs\n\t"
+		"popl %%fs\n\t"
+		"popl %%es\n\t"
+		"popl %%ds\n\t"
+	        "popl %%esi\n\t"
+		"popl %%edi\n\t"
+		"popl %%ebp\n\t"
+		: "=a" (status)
+		: "0" ((func) | (((u32)arg1) << 16)),
+		  "b" ((arg2) | (((u32)arg3) << 16)),
+		  "c" ((arg4) | (((u32)arg5) << 16)),
+		  "d" ((arg6) | (((u32)arg7) << 16)),
+		  "i" (PNP_CS32),
+		  "i" (0)
+		: "memory"
+	);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
+	
+	/* If we get here and this is set then the PnP BIOS faulted on us. */
+	if(pnp_bios_is_utter_crap)
+	{
+		printk(KERN_ERR "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue\n");
+		printk(KERN_ERR "PnPBIOS: You may need to reboot with the \"nobiospnp\" option to operate stably\n");
+		printk(KERN_ERR "PnPBIOS: Check with your vendor for an updated BIOS\n");
+	}
+
+	return status;
+}
+
+
+/*
+ *
+ * UTILITY FUNCTIONS
+ *
+ */
+
+static void pnpbios_warn_unexpected_status(const char * module, u16 status)
+{
+	printk(KERN_ERR "PnPBIOS: %s: Unexpected status 0x%x\n", module, status);
+}
+
+void *pnpbios_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc( size, f );
+	if ( p == NULL )
+		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
+	return p;
+}
+
+/*
+ * Call this only after init time
+ */
+static int pnp_bios_present(void)
+{
+	return (pnp_bios_hdr != NULL);
+}
+
+
+/*
+ *
+ * PnP BIOS ACCESS FUNCTIONS
+ *
+ */
+
+#define PNP_GET_NUM_SYS_DEV_NODES       0x00
+#define PNP_GET_SYS_DEV_NODE            0x01
+#define PNP_SET_SYS_DEV_NODE            0x02
+#define PNP_GET_EVENT                   0x03
+#define PNP_SEND_MESSAGE                0x04
+#define PNP_GET_DOCKING_STATION_INFORMATION 0x05
+#define PNP_SET_STATIC_ALLOCED_RES_INFO 0x09
+#define PNP_GET_STATIC_ALLOCED_RES_INFO 0x0a
+#define PNP_GET_APM_ID_TABLE            0x0b
+#define PNP_GET_PNP_ISA_CONFIG_STRUC    0x40
+#define PNP_GET_ESCD_INFO               0x41
+#define PNP_READ_ESCD                   0x42
+#define PNP_WRITE_ESCD                  0x43
+
+/*
+ * Call PnP BIOS with function 0x00, "get number of system device nodes"
+ */
+static int __pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0,
+			       data, sizeof(struct pnp_dev_node_info), 0, 0);
+	data->no_nodes &= 0xff;
+	return status;
+}
+
+int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
+{
+	int status = __pnp_bios_dev_node_info( data );
+	if ( status )
+		pnpbios_warn_unexpected_status( "dev_node_info", status );
+	return status;
+}
+
+/*
+ * Note that some PnP BIOSes (e.g., on Sony Vaio laptops) die a horrible
+ * death if they are asked to access the "current" configuration.
+ * Therefore, if it's a matter of indifference, it's better to call
+ * get_dev_node() and set_dev_node() with boot=1 rather than with boot=0.
+ */
+
+/* 
+ * Call PnP BIOS with function 0x01, "get system device node"
+ * Input: *nodenum = desired node, 
+ *        boot = whether to get nonvolatile boot (!=0)
+ *               or volatile current (0) config
+ * Output: *nodenum=next node or 0xff if no more nodes
+ */
+static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	if ( !boot & pnpbios_dont_use_current_config )
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0,
+			       nodenum, sizeof(char), data, 65536);
+	return status;
+}
+
+int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
+{
+	int status;
+	status =  __pnp_bios_get_dev_node( nodenum, boot, data );
+	if ( status )
+		pnpbios_warn_unexpected_status( "get_dev_node", status );
+	return status;
+}
+
+
+/*
+ * Call PnP BIOS with function 0x02, "set system device node"
+ * Input: *nodenum = desired node, 
+ *        boot = whether to set nonvolatile boot (!=0)
+ *               or volatile current (0) config
+ */
+static int __pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	if ( !boot & pnpbios_dont_use_current_config )
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0,
+			       data, 65536, 0, 0);
+	return status;
+}
+
+int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
+{
+	int status;
+	status =  __pnp_bios_set_dev_node( nodenum, boot, data );
+	if ( status ) {
+		pnpbios_warn_unexpected_status( "set_dev_node", status );
+		return status;
+	}
+	if ( !boot ) { /* Update devlist */
+		status =  pnp_bios_get_dev_node( &nodenum, boot, data );
+		if ( status )
+			return status;
+	}
+	return status;
+}
+
+#if needed
+/*
+ * Call PnP BIOS with function 0x03, "get event"
+ */
+static int pnp_bios_get_event(u16 *event)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0,
+			       event, sizeof(u16), 0, 0);
+	return status;
+}
+#endif
+
+#if needed
+/* 
+ * Call PnP BIOS with function 0x04, "send message"
+ */
+static int pnp_bios_send_message(u16 message)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+	return status;
+}
+#endif
+
+#ifdef CONFIG_HOTPLUG
+/*
+ * Call PnP BIOS with function 0x05, "get docking station information"
+ */
+static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_docking_station_info), 0, 0);
+	return status;
+}
+#endif
+
+#if needed
+/*
+ * Call PnP BIOS with function 0x09, "set statically allocated resource
+ * information"
+ */
+static int pnp_bios_set_stat_res(char *info)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       info, *((u16 *) info), 0, 0);
+	return status;
+}
+#endif
+
+/*
+ * Call PnP BIOS with function 0x0a, "get statically allocated resource
+ * information"
+ */
+static int __pnp_bios_get_stat_res(char *info)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       info, 65536, 0, 0);
+	return status;
+}
+
+int pnp_bios_get_stat_res(char *info)
+{
+	int status;
+	status = __pnp_bios_get_stat_res( info );
+	if ( status )
+		pnpbios_warn_unexpected_status( "get_stat_res", status );
+	return status;
+}
+
+#if needed
+/*
+ * Call PnP BIOS with function 0x0b, "get APM id table"
+ */
+static int pnp_bios_apm_id_table(char *table, u16 *size)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0,
+			       table, *size, size, sizeof(u16));
+	return status;
+}
+#endif
+
+/*
+ * Call PnP BIOS with function 0x40, "get isa pnp configuration structure"
+ */
+static int __pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_isa_config_struc), 0, 0);
+	return status;
+}
+
+int pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
+{
+	int status;
+	status = __pnp_bios_isapnp_config( data );
+	if ( status )
+		pnpbios_warn_unexpected_status( "isapnp_config", status );
+	return status;
+}
+
+/*
+ * Call PnP BIOS with function 0x41, "get ESCD info"
+ */
+static int __pnp_bios_escd_info(struct escd_info_struc *data)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return ESCD_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS,
+			       data, sizeof(struct escd_info_struc), 0, 0);
+	return status;
+}
+
+int pnp_bios_escd_info(struct escd_info_struc *data)
+{
+	int status;
+	status = __pnp_bios_escd_info( data );
+	if ( status )
+		pnpbios_warn_unexpected_status( "escd_info", status );
+	return status;
+}
+
+/*
+ * Call PnP BIOS function 0x42, "read ESCD"
+ * nvram_base is determined by calling escd_info
+ */
+static int __pnp_bios_read_escd(char *data, u32 nvram_base)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return ESCD_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
+			       data, 65536, (void *)nvram_base, 65536);
+	return status;
+}
+
+int pnp_bios_read_escd(char *data, u32 nvram_base)
+{
+	int status;
+	status = __pnp_bios_read_escd( data, nvram_base );
+	if ( status )
+		pnpbios_warn_unexpected_status( "read_escd", status );
+	return status;
+}
+
+#if needed
+/*
+ * Call PnP BIOS function 0x43, "write ESCD"
+ */
+static int pnp_bios_write_escd(char *data, u32 nvram_base)
+{
+	u16 status;
+	if (!pnp_bios_present())
+		return ESCD_FUNCTION_NOT_SUPPORTED;
+	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
+			       data, 65536, nvram_base, 65536);
+	return status;
+}
+#endif
+
+
+/*
+ *
+ * DOCKING FUNCTIONS
+ *
+ */
+
+#ifdef CONFIG_HOTPLUG
+
+static int unloading = 0;
+static struct completion unload_sem;
+
+/*
+ * (Much of this belongs in a shared routine somewhere)
+ */
+ 
+static int pnp_dock_event(int dock, struct pnp_docking_station_info *info)
+{
+	char *argv [3], **envp, *buf, *scratch;
+	int i = 0, value;
+
+	if (!hotplug_path [0])
+		return -ENOENT;
+	if (!current->fs->root) {
+		return -EAGAIN;
+	}
+	if (!(envp = (char **) pnpbios_kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+	if (!(buf = pnpbios_kmalloc (256, GFP_KERNEL))) {
+		kfree (envp);
+		return -ENOMEM;
+	}
+
+	/* only one standardized param to hotplug command: type */
+	argv [0] = hotplug_path;
+	argv [1] = "dock";
+	argv [2] = 0;
+
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+
+#ifdef	DEBUG
+	/* hint that policy agent should enter no-stdout debug mode */
+	envp [i++] = "DEBUG=kernel";
+#endif
+	/* extensible set of named bus-specific parameters,
+	 * supporting multiple driver selection algorithms.
+	 */
+	scratch = buf;
+
+	/* action:  add, remove */
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "ACTION=%s", dock?"add":"remove") + 1;
+
+	/* Report the ident for the dock */
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "DOCK=%x/%x/%x",
+		info->location_id, info->serial, info->capabilities);
+	envp[i] = 0;
+	
+	value = call_usermodehelper (argv [0], argv, envp);
+	kfree (buf);
+	kfree (envp);
+	return 0;
+}
+
+/*
+ * Poll the PnP docking at regular intervals
+ */
+static int pnp_dock_thread(void * unused)
+{
+	static struct pnp_docking_station_info now;
+	int docked = -1, d = 0;
+	daemonize();
+	strcpy(current->comm, "kpnpbiosd");
+	while(!unloading && !signal_pending(current))
+	{
+		int status;
+		
+		/*
+		 * Poll every 2 seconds
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ*2);
+		if(signal_pending(current))
+			break;
+
+		status = pnp_bios_dock_station_info(&now);
+
+		switch(status)
+		{
+			/*
+			 * No dock to manage
+			 */
+			case PNP_FUNCTION_NOT_SUPPORTED:
+				complete_and_exit(&unload_sem, 0);
+			case PNP_SYSTEM_NOT_DOCKED:
+				d = 0;
+				break;
+			case PNP_SUCCESS:
+				d = 1;
+				break;
+			default:
+				pnpbios_warn_unexpected_status( "pnp_dock_thread", status );
+				continue;
+		}
+		if(d != docked)
+		{
+			if(pnp_dock_event(d, &now)==0)
+			{
+				docked = d;
+#if 0
+				printk(KERN_INFO "PnPBIOS: Docking station %stached\n", docked?"at":"de");
+#endif
+			}
+		}
+	}
+	complete_and_exit(&unload_sem, 0);
+}
+
+#endif   /* CONFIG_HOTPLUG */
+
+
+/* pnp current resource reading functions */
+
+
+static void add_irqresource(struct pnp_dev *dev, int irq)
+{
+	int i = 0;
+	while (!(dev->irq_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_IRQ) i++;
+	if (i < DEVICE_COUNT_IRQ) {
+		dev->irq_resource[i].start = (unsigned long) irq;
+		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	}
+}
+
+static void add_dmaresource(struct pnp_dev *dev, int dma)
+{
+	int i = 8;
+	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_DMA) i++;
+	if (i < DEVICE_COUNT_DMA) {
+		dev->dma_resource[i].start = (unsigned long) dma;
+		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+	}
+}
+
+static void add_ioresource(struct pnp_dev *dev, int io, int len)
+{
+	int i = 0;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
+	if (i < DEVICE_COUNT_RESOURCE) {
+		dev->resource[i].start = (unsigned long) io;
+		dev->resource[i].end = (unsigned long)(io + len - 1);
+		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+	}
+}
+
+static void add_memresource(struct pnp_dev *dev, int mem, int len)
+{
+	int i = 0;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
+	if (i < DEVICE_COUNT_RESOURCE) {
+		dev->resource[i].start = (unsigned long) mem;
+		dev->resource[i].end = (unsigned long)(mem + len - 1);
+		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+	}
+}
+
+static unsigned char *node_current_resource_data_to_dev(struct pnp_bios_node *node, struct pnp_dev *dev)
+{
+	unsigned char *p = node->data, *lastp=NULL;
+	int i;
+
+	/*
+	 * First, set resource info to default values
+	 */
+	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
+		dev->resource[i].start = 0;  // "disabled"
+		dev->resource[i].flags = IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
+		dev->irq_resource[i].start = (unsigned long)-1;  // "disabled"
+		dev->irq_resource[i].flags = IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_DMA;i++) {
+		dev->dma_resource[i].start = (unsigned long)-1;  // "disabled"
+		dev->dma_resource[i].flags = IORESOURCE_UNSET;
+	}
+
+	/*
+	 * Fill in dev resource info
+	 */
+        while ( (char *)p < ((char *)node->data + node->size )) {
+        	if(p==lastp) break;
+
+                if( p[0] & 0x80 ) {// large item
+			switch (p[0] & 0x7f) {
+			case 0x01: // memory
+			{
+				int io = *(short *) &p[4];
+				int len = *(short *) &p[10];
+				add_memresource(dev, io, len);
+				break;
+			}
+			case 0x02: // device name
+			{
+				int len = *(short *) &p[1];
+				memcpy(dev->name, p + 3, len >= 80 ? 79 : len);
+				break;
+			}
+			case 0x05: // 32-bit memory
+			{
+				int io = *(int *) &p[4];
+				int len = *(int *) &p[16];
+				add_memresource(dev, io, len);
+				break;
+			}
+			case 0x06: // fixed location 32-bit memory
+			{
+				int io = *(int *) &p[4];
+				int len = *(int *) &p[8];
+				add_memresource(dev, io, len);
+				break;
+			}
+			} /* switch */
+                        lastp = p+3;
+                        p = p + p[1] + p[2]*256 + 3;
+                        continue;
+                }
+                if ((p[0]>>3) == 0x0f){ // end tag
+			p = p + 2;
+			goto end;
+                        break;
+			}
+                switch (p[0]>>3) {
+                case 0x04: // irq
+                {
+                        int i, mask, irq = -1;
+                        mask= p[1] + p[2]*256;
+                        for (i=0;i<16;i++, mask=mask>>1)
+                                if(mask & 0x01) irq=i;
+			add_irqresource(dev, irq);
+                        break;
+                }
+                case 0x05: // dma
+                {
+                        int i, mask, dma = -1;
+                        mask = p[1];
+                        for (i=0;i<8;i++, mask = mask>>1)
+                                if(mask & 0x01) dma=i;
+			add_dmaresource(dev, dma);
+                        break;
+                }
+                case 0x08: // io
+                {
+			int io= p[2] + p[3] *256;
+			int len = p[7];
+			add_ioresource(dev, io, len);
+                        break;
+                }
+		case 0x09: // fixed location io
+		{
+			int io = p[1] + p[2] * 256;
+			int len = p[3];
+			add_ioresource(dev, io, len);
+			break;
+		}
+                } /* switch */
+                lastp=p+1;
+                p = p + (p[0] & 0x07) + 1;
+
+        } /* while */
+	end:
+	if ((dev->resource[0].start == 0) &&
+	    (dev->irq_resource[0].start == -1) &&
+	    (dev->dma_resource[0].start == -1))
+		dev->active = 0;
+	else
+		dev->active = 1;
+        return (unsigned char *)p;
+}
+
+
+/* pnp possible resource reading functions */
+
+static void read_lgtag_mem(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_mem * mem;
+	mem = pnpbios_kmalloc(sizeof(struct pnp_mem),GFP_KERNEL);
+	if (!mem)
+		return;
+	memset(mem,0,sizeof(struct pnp_mem));
+	mem->min = ((p[3] << 8) | p[2]) << 8;
+	mem->max = ((p[5] << 8) | p[4]) << 8;
+	mem->align = (p[7] << 8) | p[6];
+	mem->size = ((p[9] << 8) | p[8]) << 8;
+	mem->flags = p[1];
+	pnp_add_mem_resource(dev,depnum,mem);
+	return;
+}
+
+static void read_lgtag_mem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_mem32 * mem;
+	mem = pnpbios_kmalloc(sizeof(struct pnp_mem32),GFP_KERNEL);
+	if (!mem)
+		return;
+	memset(mem,0,sizeof(struct pnp_mem32));
+	memcpy(mem->data, p, 17);
+	pnp_add_mem32_resource(dev,depnum,mem);
+	return;
+}
+
+static void read_lgtag_fmem32(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_mem32 * mem;
+	mem = pnpbios_kmalloc(sizeof(struct pnp_mem32),GFP_KERNEL);
+	if (!mem)
+		return;
+	memset(mem,0,sizeof(struct pnp_mem32));
+	memcpy(mem->data, p, 17);
+	pnp_add_mem32_resource(dev,depnum,mem);
+	return;
+}
+
+static void read_smtag_irq(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_irq * irq;
+	irq = pnpbios_kmalloc(sizeof(struct pnp_irq),GFP_KERNEL);
+	if (!irq)
+		return;
+	memset(irq,0,sizeof(struct pnp_irq));
+	irq->map = (p[2] << 8) | p[1];
+	if (size > 2)
+		irq->flags = p[3];
+	pnp_add_irq_resource(dev,depnum,irq);
+	return;
+}
+
+static void read_smtag_dma(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_dma * dma;
+	dma = pnpbios_kmalloc(sizeof(struct pnp_dma),GFP_KERNEL);
+	if (!dma)
+		return;
+	memset(dma,0,sizeof(struct pnp_dma));
+	dma->map = p[1];
+	dma->flags = p[2];
+	pnp_add_dma_resource(dev,depnum,dma);
+	return;
+}
+
+static void read_smtag_port(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_port * port;
+	port = pnpbios_kmalloc(sizeof(struct pnp_port),GFP_KERNEL);
+	if (!port)
+		return;
+	memset(port,0,sizeof(struct pnp_port));
+	port->min = (p[3] << 8) | p[2];
+	port->max = (p[5] << 8) | p[4];
+	port->align = p[6];
+	port->size = p[7];
+	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_add_port_resource(dev,depnum,port);
+	return;
+}
+
+static void read_smtag_fport(unsigned char *p, int size, int depnum, struct pnp_dev *dev)
+{
+	struct pnp_port * port;
+	port = pnpbios_kmalloc(sizeof(struct pnp_port),GFP_KERNEL);
+	if (!port)
+		return;
+	memset(port,0,sizeof(struct pnp_port));
+	port->min = port->max = (p[2] << 8) | p[1];
+	port->size = p[3];
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_add_port_resource(dev,depnum,port);
+	return;
+}
+
+static unsigned char *node_possible_resource_data_to_dev(unsigned char *p, struct pnp_bios_node *node, struct pnp_dev *dev)
+{
+	unsigned char *lastp = NULL;
+	int len, depnum, dependent;
+
+	if ((char *)p == NULL)
+		return NULL;
+	if (pnp_build_resource(dev, 0) == NULL)
+		return NULL;
+	depnum = 0; /*this is the first so it should be 0 */
+	dependent = 0;
+        while ( (char *)p < ((char *)node->data + node->size )) {
+
+                if( p[0] & 0x80 ) {// large item
+			len = (p[2] << 8) | p[1];
+			switch (p[0] & 0x7f) {
+			case 0x01: // memory
+			{
+				if (len != 9)
+					goto __skip;
+				read_lgtag_mem(p,len,depnum,dev);
+				break;
+			}
+			case 0x05: // 32-bit memory
+			{
+				if (len != 17)
+					goto __skip;
+				read_lgtag_mem32(p,len,depnum,dev);
+				break;
+			}
+			case 0x06: // fixed location 32-bit memory
+			{
+				if (len != 17)
+					goto __skip;
+				read_lgtag_fmem32(p,len,depnum,dev);
+				break;
+			}
+			} /* switch */
+                        lastp = p+3;
+                        p = p + p[1] + p[2]*256 + 3;
+                        continue;
+                }
+		len = p[0] & 0x07;
+                switch ((p[0]>>3) & 0x0f) {
+		case 0x0f:
+		{
+			p = p + 2;
+        		return (unsigned char *)p;
+			break;
+		}
+                case 0x04: // irq
+                {
+			if (len < 2 || len > 3)
+				goto __skip;
+			read_smtag_irq(p,len,depnum,dev);
+			break;
+                }
+                case 0x05: // dma
+                {
+			if (len != 2)
+				goto __skip;
+			read_smtag_dma(p,len,depnum,dev);
+                        break;
+                }
+                case 0x06: // start dep
+                {
+			if (len > 1)
+				goto __skip;
+			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			if (len > 0)
+				dependent = 0x100 | p[1];
+			pnp_build_resource(dev,dependent);
+			depnum = pnp_get_max_depnum(dev);
+                        break;
+                }
+                case 0x07: // end dep
+                {
+			if (len != 0)
+				goto __skip;
+			depnum = 0;
+                        break;
+                }
+                case 0x08: // io
+                {
+			if (len != 7)
+				goto __skip;
+			read_smtag_port(p,len,depnum,dev);
+                        break;
+                }
+		case 0x09: // fixed location io
+		{
+			if (len != 3)
+				goto __skip;
+			read_smtag_fport(p,len,depnum,dev);
+			break;
+		}
+                } /* switch */
+		__skip:
+                p += len + 1;
+
+        } /* while */
+
+        return NULL;
+}
+
+
+/* pnp resource writing functions */
+
+static void write_lgtag_mem(unsigned char *p, int size, struct pnp_mem *mem)
+{
+	if (!mem)
+		return;
+	p[2] = (mem->min >> 8) & 0xff;
+	p[3] = ((mem->min >> 8) >> 8) & 0xff;
+	p[4] = (mem->max >> 8) & 0xff;
+	p[5] = ((mem->max >> 8) >> 8) & 0xff;
+	p[6] = mem->align & 0xff;
+	p[7] = (mem->align >> 8) & 0xff;
+	p[8] = (mem->size >> 8) & 0xff;
+	p[9] = ((mem->size >> 8) >> 8) & 0xff;
+	p[1] = mem->flags & 0xff;
+	return;
+}
+
+static void write_smtag_irq(unsigned char *p, int size, struct pnp_irq *irq)
+{
+	if (!irq)
+		return;
+	p[1] = irq->map & 0xff;
+	p[2] = (irq->map >> 8) & 0xff;
+	if (size > 2)
+		p[3] = irq->flags & 0xff;
+	return;
+}
+
+static void write_smtag_dma(unsigned char *p, int size, struct pnp_dma *dma)
+{
+	if (!dma)
+		return;
+	p[1] = dma->map & 0xff;
+	p[2] = dma->flags & 0xff;
+	return;
+}
+
+static void write_smtag_port(unsigned char *p, int size, struct pnp_port *port)
+{
+	if (!port)
+		return;
+	p[2] = port->min & 0xff;
+	p[3] = (port->min >> 8) & 0xff;
+	p[4] = port->max & 0xff;
+	p[5] = (port->max >> 8) & 0xff;
+	p[6] = port->align & 0xff;
+	p[7] = port->size & 0xff;
+	p[1] = port->flags & 0xff;
+	return;
+}
+
+static void write_smtag_fport(unsigned char *p, int size, struct pnp_port *port)
+{
+	if (!port)
+		return;
+	p[1] = port->min & 0xff;
+	p[2] = (port->min >> 8) & 0xff;
+	p[3] = port->size & 0xff;
+	return;
+}
+
+static int node_set_resources(struct pnp_bios_node *node, struct pnp_cfg *config)
+{
+	int error = 0;
+	if (!node)
+		return -EINVAL;
+	unsigned char *p = (char *)node->data, *lastp = NULL;
+	if ((char *)p == NULL)
+		return -EINVAL;
+	int len, port = 0, irq = 0, dma = 0, mem = 0;
+
+        while ( (char *)p < ((char *)node->data + node->size )) {
+
+                if( p[0] & 0x80 ) {// large item
+			len = (p[2] << 8) | p[1];
+			switch (p[0] & 0x7f) {
+			case 0x01: // memory
+			{
+				if (len != 9)
+					goto __skip;
+				write_lgtag_mem(p,len,config->mem[mem]);
+				mem++;
+				break;
+			}
+			case 0x05: // 32-bit memory
+			{
+				if (len != 17)
+					goto __skip;
+				/* FIXME */
+				break;
+			}
+			case 0x06: // fixed location 32-bit memory
+			{
+				if (len != 17)
+					goto __skip;
+				/* FIXME */
+				break;
+			}
+			} /* switch */
+                        lastp = p+3;
+                        p = p + p[1] + p[2]*256 + 3;
+                        continue;
+                }
+		len = p[0] & 0x07;
+                switch ((p[0]>>3) & 0x0f) {
+		case 0x0f:
+		{
+        		goto done;
+			break;
+		}
+                case 0x04: // irq
+                {
+			if (len < 2 || len > 3)
+				goto __skip;
+			write_smtag_irq(p,len,config->irq[irq]);
+			irq++;
+			break;
+                }
+                case 0x05: // dma
+                {
+			if (len != 2)
+				goto __skip;
+			write_smtag_dma(p,len,config->dma[dma]);
+			dma++;
+                        break;
+                }
+                case 0x08: // io
+                {
+			if (len != 7)
+				goto __skip;
+			write_smtag_port(p,len,config->port[port]);
+			port++;
+                        break;
+                }
+		case 0x09: // fixed location io
+		{
+			if (len != 3)
+				goto __skip;
+			write_smtag_fport(p,len,config->port[port]);
+			port++;
+			break;
+		}
+                } /* switch */
+		__skip:
+                p += len + 1;
+
+        } /* while */
+
+	/* we never got an end tag so this data is corrupt or invalid */
+	return -EINVAL;
+
+	done:
+	error = pnp_bios_set_dev_node(node->handle, (char)0, node);
+        return error;
+}
+
+static int pnpbios_get_resources(struct pnp_dev *dev)
+{
+	struct pnp_dev_node_info node_info;
+	if (pnp_bios_dev_node_info(&node_info) != 0)
+		return -ENODEV;
+	u8 nodenum = dev->number;
+	struct pnp_bios_node * node;
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node)
+		return -1;
+	if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
+		return -ENODEV;
+	node_current_resource_data_to_dev(node,dev);
+	kfree(node);
+	return 0;
+}
+
+static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg *config, char flags)
+{
+	struct pnp_dev_node_info node_info;
+	u8 nodenum = dev->number;
+
+	if (pnp_bios_dev_node_info(&node_info) != 0)
+		return -ENODEV;
+	struct pnp_bios_node * node;
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node)
+		return -1;
+	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+		return -ENODEV;
+	if(node_set_resources(node, config)<0){
+		return -1;
+	}
+	kfree(node);
+	return 0;
+}
+
+static int pnpbios_disable_resources(struct pnp_dev *dev)
+{
+	if (!dev || !dev->active)
+		return -EINVAL;
+	struct pnp_cfg * config = kmalloc(sizeof(struct pnp_cfg), GFP_KERNEL);
+	if (!config)
+		return -1;
+	memset(config, 0, sizeof(struct pnp_cfg));
+	/* first we need to set everything to a disabled value */
+	struct pnp_port	port = {
+	max:	0,
+	min:	0,
+	align:	0,
+	size:	0,
+	flags:	0,
+	pad:	0,
+	};
+	struct pnp_mem	mem = {
+	max:	0,
+	min:	0,
+	align:	0,
+	size:	0,
+	flags:	0,
+	pad:	0,
+	};
+	struct pnp_dma	dma = {
+	map:	0,
+	flags:	0,
+	};
+	struct pnp_irq	irq = {
+	map:	0,
+	flags:	0,
+	pad:	0,
+	};
+	int i;
+	for (i=0; i <= 8; i++)
+		config->port[i] = &port;
+	for (i=0; i <= 4; i++)
+		config->mem[i] = &mem;
+	for (i=0; i <= 2; i++)
+		config->irq[i] = &irq;
+	for (i=0; i <= 2; i++)
+		config->dma[i] = &dma;
+	dev->active = 0;
+	struct pnp_dev_node_info node_info;
+	u8 nodenum = dev->number;
+
+	if (pnp_bios_dev_node_info(&node_info) != 0)
+		return -ENODEV;
+	struct pnp_bios_node * node;
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node)
+		return -1;
+	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+		goto failed;
+	if(node_set_resources(node, config)<0)
+		goto failed;
+	kfree(config);
+	kfree(node);
+	return 0;
+ failed:
+	kfree(node);
+	kfree(config);
+	return -1;
+}
+
+
+/* PnP Layer support */
+
+static struct pnp_protocol pnpbios_protocol = {
+	name:	"Plug and Play BIOS",
+	get:	pnpbios_get_resources,
+	set:	pnpbios_set_resources,
+	disable:pnpbios_disable_resources,
+};
+
+static int inline insert_device(struct pnp_dev *dev)
+{
+	struct list_head * pos;
+	struct pnp_dev * pnp_dev;
+	list_for_each (pos, &pnpbios_protocol.devices){
+		pnp_dev = list_entry(pos, struct pnp_dev, dev_list);
+		if (dev->number == pnp_dev->number)
+			return -1;
+	}
+	pnp_add_device(dev);
+	return 0;
+}
+
+#define HEX(id,a) hex[((id)>>a) & 15]
+#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+//
+
+static void inline pnpid32_to_pnpid(u32 id, char *str)
+{
+	const char *hex = "0123456789abcdef";
+
+	id = be32_to_cpu(id);
+	str[0] = CHAR(id, 26);
+	str[1] = CHAR(id, 21);
+	str[2] = CHAR(id,16);
+	str[3] = HEX(id, 12);
+	str[4] = HEX(id, 8);
+	str[5] = HEX(id, 4);
+	str[6] = HEX(id, 0);
+	str[7] = '\0';
+
+	return;
+}
+//
+#undef CHAR
+#undef HEX
+
+
+static void __init build_devlist(void)
+{
+	u8 nodenum;
+	char id[7];
+	unsigned char *pos;
+	unsigned int nodes_got = 0;
+	unsigned int devs = 0;
+	struct pnp_bios_node *node;
+	struct pnp_dev_node_info node_info;
+	struct pnp_dev *dev;
+	struct pnp_id *dev_id;
+
+	if (!pnp_bios_present())
+		return;
+
+	if (pnp_bios_dev_node_info(&node_info) != 0)
+		return;
+
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node)
+		return;
+
+	for(nodenum=0; nodenum<0xff; ) {
+		u8 thisnodenum = nodenum;
+		/* We build the list from the "boot" config because
+		 * asking for the "current" config causes some
+		 * BIOSes to crash.
+		 */
+		if (pnp_bios_get_dev_node(&nodenum, (char )0 , node))
+			break;
+		nodes_got++;
+		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
+		if (!dev)
+			break;
+		memset(dev,0,sizeof(struct pnp_dev));
+		dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
+		if (!dev_id)
+			break;
+		memset(dev_id,0,sizeof(struct pnp_id));
+		pnp_init_device(dev);
+		dev->number = thisnodenum;
+		memcpy(dev->name,"Unknown Device",14);
+		pnpid32_to_pnpid(node->eisa_id,id);
+		memcpy(dev_id->id,id,8);
+		pnp_add_id(dev_id, dev);
+		pos = node_current_resource_data_to_dev(node,dev);
+		node_possible_resource_data_to_dev(pos,node,dev);
+
+		dev->protocol = &pnpbios_protocol;
+
+		if(insert_device(dev)<0)
+			kfree(dev);
+		else
+			devs++;
+		if (nodenum <= thisnodenum) {
+			printk(KERN_ERR "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (unsigned int)nodenum, (unsigned int)thisnodenum);
+			break;
+		}
+	}
+	kfree(node);
+
+	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver\n",
+		nodes_got, nodes_got != 1 ? "s" : "", devs);
+}
+
+/*
+ *
+ * INIT AND EXIT
+ *
+ */
+
+extern int is_sony_vaio_laptop;
+
+static int pnpbios_disabled; /* = 0 */
+static int dont_reserve_resources; /* = 0 */
+int pnpbios_dont_use_current_config; /* = 0 */
+
+#ifndef MODULE
+static int __init pnpbios_setup(char *str)
+{
+	int invert;
+
+	while ((str != NULL) && (*str != '\0')) {
+		if (strncmp(str, "off", 3) == 0)
+			pnpbios_disabled=1;
+		if (strncmp(str, "on", 2) == 0)
+			pnpbios_disabled=0;
+		invert = (strncmp(str, "no-", 3) == 0);
+		if (invert)
+			str += 3;
+		if (strncmp(str, "curr", 4) == 0)
+			pnpbios_dont_use_current_config = invert;
+		if (strncmp(str, "res", 3) == 0)
+			dont_reserve_resources = invert;
+		str = strchr(str, ',');
+		if (str != NULL)
+			str += strspn(str, ", \t");
+	}
+
+	return 1;
+}
+
+__setup("pnpbios=", pnpbios_setup);
+#endif
+
+subsys_initcall(pnpbios_init);
+
+int __init pnpbios_init(void)
+{
+	union pnp_bios_expansion_header *check;
+	u8 sum;
+	int i, length, r;
+
+	spin_lock_init(&pnp_bios_lock);
+
+	if(pnpbios_disabled) {
+		printk(KERN_INFO "PnPBIOS: Disabled\n");
+		return -ENODEV;
+	}
+
+	if ( is_sony_vaio_laptop )
+		pnpbios_dont_use_current_config = 1;
+
+	/*
+ 	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
+	 * structure and, if one is found, sets up the selectors and
+	 * entry points
+	 */
+	for (check = (union pnp_bios_expansion_header *) __va(0xf0000);
+	     check < (union pnp_bios_expansion_header *) __va(0xffff0);
+	     ((void *) (check)) += 16) {
+		if (check->fields.signature != PNP_SIGNATURE)
+			continue;
+		length = check->fields.length;
+		if (!length)
+			continue;
+		for (sum = 0, i = 0; i < length; i++)
+			sum += check->chars[i];
+		if (sum)
+			continue;
+		if (check->fields.version < 0x10) {
+			printk(KERN_WARNING "PnPBIOS: PnP BIOS version %d.%d is not supported\n",
+			       check->fields.version >> 4,
+			       check->fields.version & 15);
+			continue;
+		}
+		printk(KERN_INFO "PnPBIOS: Found PnP BIOS installation structure at 0x%p\n", check);
+		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x\n",
+                       check->fields.version >> 4, check->fields.version & 15,
+		       check->fields.pm16cseg, check->fields.pm16offset,
+		       check->fields.pm16dseg);
+		pnp_bios_callpoint.offset = check->fields.pm16offset;
+		pnp_bios_callpoint.segment = PNP_CS16;
+		pnp_bios_hdr = check;
+
+		for(i=0; i < NR_CPUS; i++)
+		{
+			Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
+			Q_SET_SEL(i, PNP_CS16, check->fields.pm16cseg, 64 * 1024);
+			Q_SET_SEL(i, PNP_DS, check->fields.pm16dseg, 64 * 1024);
+		}
+		break;
+	}
+	if (!pnp_bios_present())
+		return -ENODEV;
+	pnp_protocol_register(&pnpbios_protocol);
+	build_devlist();
+	/*if ( ! dont_reserve_resources )*/
+		/*reserve_resources();*/
+#ifdef CONFIG_PROC_FS
+	r = pnpbios_proc_init();
+	if (r)
+		return r;
+#endif
+	return 0;
+}
+
+static int __init pnpbios_thread_init(void)
+{
+#ifdef CONFIG_HOTPLUG
+	init_completion(&unload_sem);
+	if (kernel_thread(pnp_dock_thread, NULL, CLONE_KERNEL) > 0)
+		unloading = 0;
+#endif
+	return 0;
+}
+
+#ifndef MODULE
+
+/* init/main.c calls pnpbios_init early */
+
+/* Start the kernel thread later: */
+module_init(pnpbios_thread_init);
+
+#else
+
+/*
+ * N.B.: Building pnpbios as a module hasn't been fully implemented
+ */
+
+MODULE_LICENSE("GPL");
+
+static int __init pnpbios_init_all(void)
+{
+	int r;
+
+	r = pnpbios_init();
+	if (r)
+		return r;
+	r = pnpbios_thread_init();
+	if (r)
+		return r;
+	return 0;
+}
+
+static void __exit pnpbios_exit(void)
+{
+#ifdef CONFIG_HOTPLUG
+	unloading = 1;
+	wait_for_completion(&unload_sem);
+#endif
+	pnpbios_proc_exit();
+	/* We ought to free resources here */
+	return;
+}
+
+module_init(pnpbios_init_all);
+module_exit(pnpbios_exit);
+
+#endif
diff -ur --new-file --exclude *.flags a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
--- a/drivers/pnp/pnpbios/proc.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/pnpbios/proc.c	Mon Oct 14 11:38:31 2002
@@ -0,0 +1,279 @@
+/*
+ * /proc/bus/pnp interface for Plug and Play devices
+ *
+ * Written by David Hinds, dahinds-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
+ * Modified by Thomas Hood, jdthood-O5WfVfzUwx8@public.gmane.org
+ *
+ * The .../devices and .../<node> and .../boot/<node> files are
+ * utilized by the lspnp and setpnp utilities, supplied with the
+ * pcmcia-cs package.
+ *     http://pcmcia-cs.sourceforge.net
+ *
+ * The .../escd file is utilized by the lsescd utility written by
+ * Gunther Mayer.
+ *     http://home.t-online.de/home/gunther.mayer/lsescd
+ *
+ * The .../legacy_device_resources file is not used yet.
+ *
+ * The other files are human-readable.
+ */
+
+//#include <pcmcia/config.h>
+#define __NO_VERSION__
+//#include <pcmcia/k_compat.h>
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/pnpbios.h>
+#include <linux/init.h>
+
+static struct proc_dir_entry *proc_pnp = NULL;
+static struct proc_dir_entry *proc_pnp_boot = NULL;
+static struct pnp_dev_node_info node_info;
+
+static int proc_read_pnpconfig(char *buf, char **start, off_t pos,
+                               int count, int *eof, void *data)
+{
+	struct pnp_isa_config_struc pnps;
+
+	if (pnp_bios_isapnp_config(&pnps))
+		return -EIO;
+	return snprintf(buf, count,
+		"structure_revision %d\n"
+		"number_of_CSNs %d\n"
+		"ISA_read_data_port 0x%x\n",
+		pnps.revision,
+		pnps.no_csns,
+		pnps.isa_rd_data_port
+	);
+}
+
+static int proc_read_escdinfo(char *buf, char **start, off_t pos,
+                              int count, int *eof, void *data)
+{
+	struct escd_info_struc escd;
+
+	if (pnp_bios_escd_info(&escd))
+		return -EIO;
+	return snprintf(buf, count,
+		"min_ESCD_write_size %d\n"
+		"ESCD_size %d\n"
+		"NVRAM_base 0x%x\n",
+		escd.min_escd_write_size,
+		escd.escd_size,
+		escd.nv_storage_base
+	);
+}
+
+#define MAX_SANE_ESCD_SIZE (32*1024)
+static int proc_read_escd(char *buf, char **start, off_t pos,
+                          int count, int *eof, void *data)
+{
+	struct escd_info_struc escd;
+	char *tmpbuf;
+	int escd_size, escd_left_to_read, n;
+
+	if (pnp_bios_escd_info(&escd))
+		return -EIO;
+
+	/* sanity check */
+	if (escd.escd_size > MAX_SANE_ESCD_SIZE) {
+		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
+		return -EFBIG;
+	}
+
+	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
+	if (!tmpbuf) return -ENOMEM;
+
+	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base))
+		return -EIO;
+
+	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;
+
+	/* sanity check */
+	if (escd_size > MAX_SANE_ESCD_SIZE) {
+		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS read_escd call is too great\n");
+		return -EFBIG;
+	}
+
+	escd_left_to_read = escd_size - pos;
+	if (escd_left_to_read < 0) escd_left_to_read = 0;
+	if (escd_left_to_read == 0) *eof = 1;
+	n = min(count,escd_left_to_read);
+	memcpy(buf, tmpbuf + pos, n);
+	kfree(tmpbuf);
+	*start = buf;
+	return n;
+}
+
+static int proc_read_legacyres(char *buf, char **start, off_t pos,
+                               int count, int *eof, void *data)
+{
+	/* Assume that the following won't overflow the buffer */
+	if (pnp_bios_get_stat_res(buf)) 
+		return -EIO;
+
+	return count;  // FIXME: Return actual length
+}
+
+static int proc_read_devices(char *buf, char **start, off_t pos,
+                             int count, int *eof, void *data)
+{
+	struct pnp_bios_node *node;
+	u8 nodenum;
+	char *p = buf;
+
+	if (pos >= 0xff)
+		return 0;
+
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node) return -ENOMEM;
+
+	for (nodenum=pos; nodenum<0xff; ) {
+		u8 thisnodenum = nodenum;
+		/* 26 = the number of characters per line sprintf'ed */
+		if ((p - buf + 26) > count)
+			break;
+		if (pnp_bios_get_dev_node(&nodenum, 1, node))
+			break;
+		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
+			     node->handle, node->eisa_id,
+			     node->type_code[0], node->type_code[1],
+			     node->type_code[2], node->flags);
+		if (nodenum <= thisnodenum) {
+			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_read_devices:", (unsigned int)nodenum, (unsigned int)thisnodenum);
+			*eof = 1;
+			break;
+		}
+	}
+	kfree(node);
+	if (nodenum == 0xff)
+		*eof = 1;
+	*start = (char *)((off_t)nodenum - pos);
+	return p - buf;
+}
+
+static int proc_read_node(char *buf, char **start, off_t pos,
+                          int count, int *eof, void *data)
+{
+	struct pnp_bios_node *node;
+	int boot = (long)data >> 8;
+	u8 nodenum = (long)data;
+	int len;
+
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node) return -ENOMEM;
+	if (pnp_bios_get_dev_node(&nodenum, boot, node))
+		return -EIO;
+	len = node->size - sizeof(struct pnp_bios_node);
+	memcpy(buf, node->data, len);
+	kfree(node);
+	return len;
+}
+
+static int proc_write_node(struct file *file, const char *buf,
+                           unsigned long count, void *data)
+{
+	struct pnp_bios_node *node;
+	int boot = (long)data >> 8;
+	u8 nodenum = (long)data;
+
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node) return -ENOMEM;
+	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+		return -EIO;
+	if (count != node->size - sizeof(struct pnp_bios_node))
+		return -EINVAL;
+	memcpy(node->data, buf, count);
+	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
+	    return -EINVAL;
+	kfree(node);
+	return count;
+}
+
+/*
+ * When this is called, pnpbios functions are assumed to
+ * work and the pnpbios_dont_use_current_config flag
+ * should already have been set to the appropriate value
+ */
+int __init pnpbios_proc_init( void )
+{
+	struct pnp_bios_node *node;
+	struct proc_dir_entry *ent;
+	char name[3];
+	u8 nodenum;
+
+	if (pnp_bios_dev_node_info(&node_info))
+		return -EIO;
+	
+	proc_pnp = proc_mkdir("pnp", proc_bus);
+	if (!proc_pnp)
+		return -EIO;
+	proc_pnp_boot = proc_mkdir("boot", proc_pnp);
+	if (!proc_pnp_boot)
+		return -EIO;
+	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
+	create_proc_read_entry("configuration_info", 0, proc_pnp, proc_read_pnpconfig, NULL);
+	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo, NULL);
+	create_proc_read_entry("escd", S_IRUSR, proc_pnp, proc_read_escd, NULL);
+	create_proc_read_entry("legacy_device_resources", 0, proc_pnp, proc_read_legacyres, NULL);
+	
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	for (nodenum=0; nodenum<0xff; ) {
+		u8 thisnodenum = nodenum;
+		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
+			break;
+		sprintf(name, "%02x", node->handle);
+		if ( !pnpbios_dont_use_current_config ) {
+			ent = create_proc_entry(name, 0, proc_pnp);
+			if (ent) {
+				ent->read_proc = proc_read_node;
+				ent->write_proc = proc_write_node;
+				ent->data = (void *)(long)(node->handle);
+			}
+		}
+		ent = create_proc_entry(name, 0, proc_pnp_boot);
+		if (ent) {
+			ent->read_proc = proc_read_node;
+			ent->write_proc = proc_write_node;
+			ent->data = (void *)(long)(node->handle+0x100);
+		}
+		if (nodenum <= thisnodenum) {
+			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_init:", (unsigned int)nodenum, (unsigned int)thisnodenum);
+			break;
+		}
+	}
+	kfree(node);
+
+	return 0;
+}
+
+void __exit pnpbios_proc_exit(void)
+{
+	int i;
+	char name[3];
+	
+	if (!proc_pnp) return;
+
+	for (i=0; i<0xff; i++) {
+		sprintf(name, "%02x", i);
+		if ( !pnpbios_dont_use_current_config )
+			remove_proc_entry(name, proc_pnp);
+		remove_proc_entry(name, proc_pnp_boot);
+	}
+	remove_proc_entry("legacy_device_resources", proc_pnp);
+	remove_proc_entry("escd", proc_pnp);
+	remove_proc_entry("escd_info", proc_pnp);
+	remove_proc_entry("configuration_info", proc_pnp);
+	remove_proc_entry("devices", proc_pnp);
+	remove_proc_entry("boot", proc_pnp);
+	remove_proc_entry("pnp", proc_bus);
+
+	return;
+}
diff -ur --new-file --exclude *.flags a/drivers/pnp/pnpbios_core.c b/drivers/pnp/pnpbios_core.c
--- a/drivers/pnp/pnpbios_core.c	Tue Oct 15 17:31:32 2002
+++ b/drivers/pnp/pnpbios_core.c	Thu Jan  1 00:00:00 1970
@@ -1,1350 +0,0 @@
-/*
- * pnpbios -- PnP BIOS driver
- *
- * This driver provides access to Plug-'n'-Play services provided by
- * the PnP BIOS firmware, described in the following documents:
- *   Plug and Play BIOS Specification, Version 1.0A, 5 May 1994
- *   Plug and Play BIOS Clarification Paper, 6 October 1994
- *     Compaq Computer Corporation, Phoenix Technologies Ltd., Intel Corp.
- * 
- * Originally (C) 1998 Christian Schmidt <schmidt-IABvq36EpHazQB+pC5nmwQ@public.gmane.org>
- * Modifications (C) 1998 Tom Lees <tom-jMAA5W8IFouX/4koqx8SDw@public.gmane.org>
- * Minor reorganizations by David Hinds <dahinds-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
- * Further modifications (C) 2001, 2002 by:
- *   Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- *   Thomas Hood <jdthood-O5WfVfzUwx8@public.gmane.org>
- *   Brian Gerst <bgerst-Gk3hQYvpvHrdtAWm4Da02A@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2, or (at your option) any
- * later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/linkage.h>
-#include <linux/kernel.h>
-#include <linux/pnpbios.h>
-#include <asm/page.h>
-#include <asm/system.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <asm/desc.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
-#include <linux/kmod.h>
-#include <linux/completion.h>
-#include <linux/spinlock.h>
-#include <asm/system.h>
-#include <asm/byteorder.h>
-
-
-/*
- *
- * PnP BIOS INTERFACE
- *
- */
-
-/* PnP BIOS signature: "$PnP" */
-#define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
-
-#pragma pack(1)
-union pnp_bios_expansion_header {
-	struct {
-		u32 signature;    /* "$PnP" */
-		u8 version;	  /* in BCD */
-		u8 length;	  /* length in bytes, currently 21h */
-		u16 control;	  /* system capabilities */
-		u8 checksum;	  /* all bytes must add up to 0 */
-
-		u32 eventflag;    /* phys. address of the event flag */
-		u16 rmoffset;     /* real mode entry point */
-		u16 rmcseg;
-		u16 pm16offset;   /* 16 bit protected mode entry */
-		u32 pm16cseg;
-		u32 deviceID;	  /* EISA encoded system ID or 0 */
-		u16 rmdseg;	  /* real mode data segment */
-		u32 pm16dseg;	  /* 16 bit pm data segment base */
-	} fields;
-	char chars[0x21];	  /* To calculate the checksum */
-};
-#pragma pack()
-
-static struct {
-	u16	offset;
-	u16	segment;
-} pnp_bios_callpoint;
-
-static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
-
-/* The PnP BIOS entries in the GDT */
-#define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
-
-#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
-#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
-#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
-#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
-
-/* 
- * These are some opcodes for a "static asmlinkage"
- * As this code is *not* executed inside the linux kernel segment, but in a
- * alias at offset 0, we need a far return that can not be compiled by
- * default (please, prove me wrong! this is *really* ugly!) 
- * This is the only way to get the bios to return into the kernel code,
- * because the bios code runs in 16 bit protected mode and therefore can only
- * return to the caller if the call is within the first 64kB, and the linux
- * kernel begins at offset 3GB...
- */
-
-asmlinkage void pnp_bios_callfunc(void);
-
-__asm__(
-	".text			\n"
-	__ALIGN_STR "\n"
-	"pnp_bios_callfunc:\n"
-	"	pushl %edx	\n"
-	"	pushl %ecx	\n"
-	"	pushl %ebx	\n"
-	"	pushl %eax	\n"
-	"	lcallw *pnp_bios_callpoint\n"
-	"	addl $16, %esp	\n"
-	"	lret		\n"
-	".previous		\n"
-);
-
-#define Q_SET_SEL(cpu, selname, address, size) \
-do { \
-set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
-} while(0)
-
-#define Q2_SET_SEL(cpu, selname, address, size) \
-do { \
-set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
-} while(0)
-
-/*
- * At some point we want to use this stack frame pointer to unwind
- * after PnP BIOS oopses. 
- */
- 
-u32 pnp_bios_fault_esp;
-u32 pnp_bios_fault_eip;
-u32 pnp_bios_is_utter_crap = 0;
-
-static spinlock_t pnp_bios_lock;
-
-static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
-				u16 arg4, u16 arg5, u16 arg6, u16 arg7,
-				void *ts1_base, u32 ts1_size,
-				void *ts2_base, u32 ts2_size)
-{
-	unsigned long flags;
-	u16 status;
-
-	/*
-	 * PnP BIOSes are generally not terribly re-entrant.
-	 * Also, don't rely on them to save everything correctly.
-	 */
-	if(pnp_bios_is_utter_crap)
-		return PNP_FUNCTION_NOT_SUPPORTED;
-
-	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
-	spin_lock_irqsave(&pnp_bios_lock, flags);
-
-	/* The lock prevents us bouncing CPU here */
-	if (ts1_size)
-		Q2_SET_SEL(smp_processor_id(), PNP_TS1, ts1_base, ts1_size);
-	if (ts2_size)
-		Q2_SET_SEL(smp_processor_id(), PNP_TS2, ts2_base, ts2_size);
-
-	__asm__ __volatile__(
-	        "pushl %%ebp\n\t"
-		"pushl %%edi\n\t"
-		"pushl %%esi\n\t"
-		"pushl %%ds\n\t"
-		"pushl %%es\n\t"
-		"pushl %%fs\n\t"
-		"pushl %%gs\n\t"
-		"pushfl\n\t"
-		"movl %%esp, pnp_bios_fault_esp\n\t"
-		"movl $1f, pnp_bios_fault_eip\n\t"
-		"lcall %5,%6\n\t"
-		"1:popfl\n\t"
-		"popl %%gs\n\t"
-		"popl %%fs\n\t"
-		"popl %%es\n\t"
-		"popl %%ds\n\t"
-	        "popl %%esi\n\t"
-		"popl %%edi\n\t"
-		"popl %%ebp\n\t"
-		: "=a" (status)
-		: "0" ((func) | (((u32)arg1) << 16)),
-		  "b" ((arg2) | (((u32)arg3) << 16)),
-		  "c" ((arg4) | (((u32)arg5) << 16)),
-		  "d" ((arg6) | (((u32)arg7) << 16)),
-		  "i" (PNP_CS32),
-		  "i" (0)
-		: "memory"
-	);
-	spin_unlock_irqrestore(&pnp_bios_lock, flags);
-	
-	/* If we get here and this is set then the PnP BIOS faulted on us. */
-	if(pnp_bios_is_utter_crap)
-	{
-		printk(KERN_ERR "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue\n");
-		printk(KERN_ERR "PnPBIOS: You may need to reboot with the \"nobiospnp\" option to operate stably\n");
-		printk(KERN_ERR "PnPBIOS: Check with your vendor for an updated BIOS\n");
-	}
-
-	return status;
-}
-
-
-/*
- *
- * UTILITY FUNCTIONS
- *
- */
-
-static void pnpbios_warn_unexpected_status(const char * module, u16 status)
-{
-	printk(KERN_ERR "PnPBIOS: %s: Unexpected status 0x%x\n", module, status);
-}
-
-void *pnpbios_kmalloc(size_t size, int f)
-{
-	void *p = kmalloc( size, f );
-	if ( p == NULL )
-		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
-	return p;
-}
-
-/*
- * Call this only after init time
- */
-static int pnp_bios_present(void)
-{
-	return (pnp_bios_hdr != NULL);
-}
-
-/* Forward declaration */
-static void update_devlist( u8 nodenum, struct pnp_bios_node *data );
-
-
-/*
- *
- * PnP BIOS ACCESS FUNCTIONS
- *
- */
-
-#define PNP_GET_NUM_SYS_DEV_NODES       0x00
-#define PNP_GET_SYS_DEV_NODE            0x01
-#define PNP_SET_SYS_DEV_NODE            0x02
-#define PNP_GET_EVENT                   0x03
-#define PNP_SEND_MESSAGE                0x04
-#define PNP_GET_DOCKING_STATION_INFORMATION 0x05
-#define PNP_SET_STATIC_ALLOCED_RES_INFO 0x09
-#define PNP_GET_STATIC_ALLOCED_RES_INFO 0x0a
-#define PNP_GET_APM_ID_TABLE            0x0b
-#define PNP_GET_PNP_ISA_CONFIG_STRUC    0x40
-#define PNP_GET_ESCD_INFO               0x41
-#define PNP_READ_ESCD                   0x42
-#define PNP_WRITE_ESCD                  0x43
-
-/*
- * Call PnP BIOS with function 0x00, "get number of system device nodes"
- */
-static int __pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0,
-			       data, sizeof(struct pnp_dev_node_info), 0, 0);
-	data->no_nodes &= 0xff;
-	return status;
-}
-
-int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
-{
-	int status = __pnp_bios_dev_node_info( data );
-	if ( status )
-		pnpbios_warn_unexpected_status( "dev_node_info", status );
-	return status;
-}
-
-/*
- * Note that some PnP BIOSes (e.g., on Sony Vaio laptops) die a horrible
- * death if they are asked to access the "current" configuration.
- * Therefore, if it's a matter of indifference, it's better to call
- * get_dev_node() and set_dev_node() with boot=1 rather than with boot=0.
- */
-
-/* 
- * Call PnP BIOS with function 0x01, "get system device node"
- * Input: *nodenum = desired node, 
- *        boot = whether to get nonvolatile boot (!=0)
- *               or volatile current (0) config
- * Output: *nodenum=next node or 0xff if no more nodes
- */
-static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	if ( !boot & pnpbios_dont_use_current_config )
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0,
-			       nodenum, sizeof(char), data, 65536);
-	return status;
-}
-
-int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
-{
-	int status;
-	status =  __pnp_bios_get_dev_node( nodenum, boot, data );
-	if ( status )
-		pnpbios_warn_unexpected_status( "get_dev_node", status );
-	return status;
-}
-
-
-/*
- * Call PnP BIOS with function 0x02, "set system device node"
- * Input: *nodenum = desired node, 
- *        boot = whether to set nonvolatile boot (!=0)
- *               or volatile current (0) config
- */
-static int __pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	if ( !boot & pnpbios_dont_use_current_config )
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0,
-			       data, 65536, 0, 0);
-	return status;
-}
-
-int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
-{
-	int status;
-	status =  __pnp_bios_set_dev_node( nodenum, boot, data );
-	if ( status ) {
-		pnpbios_warn_unexpected_status( "set_dev_node", status );
-		return status;
-	}
-	if ( !boot ) { /* Update devlist */
-		u8 thisnodenum = nodenum;
-		status =  pnp_bios_get_dev_node( &nodenum, boot, data );
-		if ( status )
-			return status;
-		update_devlist( thisnodenum, data );
-	}
-	return status;
-}
-
-#if needed
-/*
- * Call PnP BIOS with function 0x03, "get event"
- */
-static int pnp_bios_get_event(u16 *event)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0,
-			       event, sizeof(u16), 0, 0);
-	return status;
-}
-#endif
-
-#if needed
-/* 
- * Call PnP BIOS with function 0x04, "send message"
- */
-static int pnp_bios_send_message(u16 message)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0, 0, 0, 0, 0);
-	return status;
-}
-#endif
-
-#ifdef CONFIG_HOTPLUG
-/*
- * Call PnP BIOS with function 0x05, "get docking station information"
- */
-static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       data, sizeof(struct pnp_docking_station_info), 0, 0);
-	return status;
-}
-#endif
-
-#if needed
-/*
- * Call PnP BIOS with function 0x09, "set statically allocated resource
- * information"
- */
-static int pnp_bios_set_stat_res(char *info)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       info, *((u16 *) info), 0, 0);
-	return status;
-}
-#endif
-
-/*
- * Call PnP BIOS with function 0x0a, "get statically allocated resource
- * information"
- */
-static int __pnp_bios_get_stat_res(char *info)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       info, 65536, 0, 0);
-	return status;
-}
-
-int pnp_bios_get_stat_res(char *info)
-{
-	int status;
-	status = __pnp_bios_get_stat_res( info );
-	if ( status )
-		pnpbios_warn_unexpected_status( "get_stat_res", status );
-	return status;
-}
-
-#if needed
-/*
- * Call PnP BIOS with function 0x0b, "get APM id table"
- */
-static int pnp_bios_apm_id_table(char *table, u16 *size)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0,
-			       table, *size, size, sizeof(u16));
-	return status;
-}
-#endif
-
-/*
- * Call PnP BIOS with function 0x40, "get isa pnp configuration structure"
- */
-static int __pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
-			       data, sizeof(struct pnp_isa_config_struc), 0, 0);
-	return status;
-}
-
-int pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
-{
-	int status;
-	status = __pnp_bios_isapnp_config( data );
-	if ( status )
-		pnpbios_warn_unexpected_status( "isapnp_config", status );
-	return status;
-}
-
-/*
- * Call PnP BIOS with function 0x41, "get ESCD info"
- */
-static int __pnp_bios_escd_info(struct escd_info_struc *data)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return ESCD_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS,
-			       data, sizeof(struct escd_info_struc), 0, 0);
-	return status;
-}
-
-int pnp_bios_escd_info(struct escd_info_struc *data)
-{
-	int status;
-	status = __pnp_bios_escd_info( data );
-	if ( status )
-		pnpbios_warn_unexpected_status( "escd_info", status );
-	return status;
-}
-
-/*
- * Call PnP BIOS function 0x42, "read ESCD"
- * nvram_base is determined by calling escd_info
- */
-static int __pnp_bios_read_escd(char *data, u32 nvram_base)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return ESCD_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, (void *)nvram_base, 65536);
-	return status;
-}
-
-int pnp_bios_read_escd(char *data, u32 nvram_base)
-{
-	int status;
-	status = __pnp_bios_read_escd( data, nvram_base );
-	if ( status )
-		pnpbios_warn_unexpected_status( "read_escd", status );
-	return status;
-}
-
-#if needed
-/*
- * Call PnP BIOS function 0x43, "write ESCD"
- */
-static int pnp_bios_write_escd(char *data, u32 nvram_base)
-{
-	u16 status;
-	if (!pnp_bios_present())
-		return ESCD_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, nvram_base, 65536);
-	return status;
-}
-#endif
-
-
-/*
- *
- * DOCKING FUNCTIONS
- *
- */
-
-#ifdef CONFIG_HOTPLUG
-
-static int unloading = 0;
-static struct completion unload_sem;
-
-/*
- * (Much of this belongs in a shared routine somewhere)
- */
- 
-static int pnp_dock_event(int dock, struct pnp_docking_station_info *info)
-{
-	char *argv [3], **envp, *buf, *scratch;
-	int i = 0, value;
-
-	if (!hotplug_path [0])
-		return -ENOENT;
-	if (!current->fs->root) {
-		return -EAGAIN;
-	}
-	if (!(envp = (char **) pnpbios_kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
-		return -ENOMEM;
-	}
-	if (!(buf = pnpbios_kmalloc (256, GFP_KERNEL))) {
-		kfree (envp);
-		return -ENOMEM;
-	}
-
-	/* only one standardized param to hotplug command: type */
-	argv [0] = hotplug_path;
-	argv [1] = "dock";
-	argv [2] = 0;
-
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-#ifdef	DEBUG
-	/* hint that policy agent should enter no-stdout debug mode */
-	envp [i++] = "DEBUG=kernel";
-#endif
-	/* extensible set of named bus-specific parameters,
-	 * supporting multiple driver selection algorithms.
-	 */
-	scratch = buf;
-
-	/* action:  add, remove */
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "ACTION=%s", dock?"add":"remove") + 1;
-
-	/* Report the ident for the dock */
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DOCK=%x/%x/%x",
-		info->location_id, info->serial, info->capabilities);
-	envp[i] = 0;
-	
-	value = call_usermodehelper (argv [0], argv, envp);
-	kfree (buf);
-	kfree (envp);
-	return 0;
-}
-
-/*
- * Poll the PnP docking at regular intervals
- */
-static int pnp_dock_thread(void * unused)
-{
-	static struct pnp_docking_station_info now;
-	int docked = -1, d = 0;
-	daemonize();
-	strcpy(current->comm, "kpnpbiosd");
-	while(!unloading && !signal_pending(current))
-	{
-		int status;
-		
-		/*
-		 * Poll every 2 seconds
-		 */
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ*2);
-		if(signal_pending(current))
-			break;
-
-		status = pnp_bios_dock_station_info(&now);
-
-		switch(status)
-		{
-			/*
-			 * No dock to manage
-			 */
-			case PNP_FUNCTION_NOT_SUPPORTED:
-				complete_and_exit(&unload_sem, 0);
-			case PNP_SYSTEM_NOT_DOCKED:
-				d = 0;
-				break;
-			case PNP_SUCCESS:
-				d = 1;
-				break;
-			default:
-				pnpbios_warn_unexpected_status( "pnp_dock_thread", status );
-				continue;
-		}
-		if(d != docked)
-		{
-			if(pnp_dock_event(d, &now)==0)
-			{
-				docked = d;
-#if 0
-				printk(KERN_INFO "PnPBIOS: Docking station %stached\n", docked?"at":"de");
-#endif
-			}
-		}
-	}	
-	complete_and_exit(&unload_sem, 0);
-}
-
-#endif   /* CONFIG_HOTPLUG */
-
-
-/*
- *
- * NODE DATA PARSING FUNCTIONS
- *
- */
-
-static void add_irqresource(struct pci_dev *dev, int irq)
-{
-	int i = 0;
-	while (!(dev->irq_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_IRQ) i++;
-	if (i < DEVICE_COUNT_IRQ) {
-		dev->irq_resource[i].start = (unsigned long) irq;
-		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
-	}
-}
-
-static void add_dmaresource(struct pci_dev *dev, int dma)
-{
-	int i = 0;
-	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_DMA) i++;
-	if (i < DEVICE_COUNT_DMA) {
-		dev->dma_resource[i].start = (unsigned long) dma;
-		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
-	}
-}
-
-static void add_ioresource(struct pci_dev *dev, int io, int len)
-{
-	int i = 0;
-	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
-	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = (unsigned long) io;
-		dev->resource[i].end = (unsigned long)(io + len - 1);
-		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
-	}
-}
-
-static void add_memresource(struct pci_dev *dev, int mem, int len)
-{
-	int i = 0;
-	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
-	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = (unsigned long) mem;
-		dev->resource[i].end = (unsigned long)(mem + len - 1);
-		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
-	}
-}
-
-static void node_resource_data_to_dev(struct pnp_bios_node *node, struct pci_dev *dev)
-{
-	unsigned char *p = node->data, *lastp=NULL;
-	int i;
-
-	/*
-	 * First, set resource info to default values
-	 */
-	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
-		dev->resource[i].start = 0;  // "disabled"
-		dev->resource[i].flags = IORESOURCE_UNSET;
-	}
-	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
-		dev->irq_resource[i].start = (unsigned long)-1;  // "disabled"
-		dev->irq_resource[i].flags = IORESOURCE_UNSET;
-	}
-	for (i=0;i<DEVICE_COUNT_DMA;i++) {
-		dev->dma_resource[i].start = (unsigned long)-1;  // "disabled"
-		dev->dma_resource[i].flags = IORESOURCE_UNSET;
-	}
-
-	/*
-	 * Fill in dev resource info
-	 */
-        while ( (char *)p < ((char *)node->data + node->size )) {
-        	if(p==lastp) break;
-
-                if( p[0] & 0x80 ) {// large item
-			switch (p[0] & 0x7f) {
-			case 0x01: // memory
-			{
-				int io = *(short *) &p[4];
-				int len = *(short *) &p[10];
-				add_memresource(dev, io, len);
-				break;
-			}
-			case 0x02: // device name
-			{
-				int len = *(short *) &p[1];
-				memcpy(dev->name, p + 3, len >= 80 ? 79 : len);
-				break;
-			}
-			case 0x05: // 32-bit memory
-			{
-				int io = *(int *) &p[4];
-				int len = *(int *) &p[16];
-				add_memresource(dev, io, len);
-				break;
-			}
-			case 0x06: // fixed location 32-bit memory
-			{
-				int io = *(int *) &p[4];
-				int len = *(int *) &p[8];
-				add_memresource(dev, io, len);
-				break;
-			}
-			} /* switch */
-                        lastp = p+3;
-                        p = p + p[1] + p[2]*256 + 3;
-                        continue;
-                }
-                if ((p[0]>>3) == 0x0f) // end tag
-                        break;
-                switch (p[0]>>3) {
-                case 0x04: // irq
-                {
-                        int i, mask, irq = -1;
-                        mask= p[1] + p[2]*256;
-                        for (i=0;i<16;i++, mask=mask>>1)
-                                if(mask & 0x01) irq=i;
-			add_irqresource(dev, irq);
-                        break;
-                }
-                case 0x05: // dma
-                {
-                        int i, mask, dma = -1;
-                        mask = p[1];
-                        for (i=0;i<8;i++, mask = mask>>1)
-                                if(mask & 0x01) dma=i;
-			add_dmaresource(dev, dma);
-                        break;
-                }
-                case 0x08: // io
-                {
-			int io= p[2] + p[3] *256;
-			int len = p[7];
-			add_ioresource(dev, io, len);
-                        break;
-                }
-		case 0x09: // fixed location io
-		{
-			int io = p[1] + p[2] * 256;
-			int len = p[3];
-			add_ioresource(dev, io, len);
-			break;
-		}
-                } /* switch */
-                lastp=p+1;
-                p = p + (p[0] & 0x07) + 1;
-
-        } /* while */
-
-        return;
-}
-
-
-/*
- *
- * DEVICE LIST MANAGEMENT FUNCTIONS
- *
- *
- * Some of these are exported to give public access
- *
- * Question: Why maintain a device list when the PnP BIOS can 
- * list devices for us?  Answer: Some PnP BIOSes can't report
- * the current configuration, only the boot configuration.
- * The boot configuration can be changed, so we need to keep
- * a record of what the configuration was when we booted;
- * presumably it continues to describe the current config.
- * For those BIOSes that can change the current config, we
- * keep the information in the devlist up to date.
- *
- * Note that it is currently assumed that the list does not
- * grow or shrink in size after init time, and slot_name
- * never changes.  The list is protected by a spinlock.
- */
-
-static LIST_HEAD(pnpbios_devices);
-
-static spinlock_t pnpbios_devices_lock;
-
-static int inline insert_device(struct pci_dev *dev)
-{
-
-	/*
-	 * FIXME: Check for re-add of existing node;
-	 * return -1 if node already present
-	 */
-
-	/* We don't lock because we only do this at init time */
-	list_add_tail(&dev->global_list, &pnpbios_devices);
-
-	return 0;
-}
-
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
-//
-static void inline pnpid32_to_pnpid(u32 id, char *str)
-{
-	const char *hex = "0123456789abcdef";
-
-	id = be32_to_cpu(id);
-	str[0] = CHAR(id, 26);
-	str[1] = CHAR(id, 21);
-	str[2] = CHAR(id,16);
-	str[3] = HEX(id, 12);
-	str[4] = HEX(id, 8);
-	str[5] = HEX(id, 4);
-	str[6] = HEX(id, 0);
-	str[7] = '\0';
-
-	return;
-}                                              
-//
-#undef CHAR
-#undef HEX 
-
-/*
- * Build a linked list of pci_devs in order of ascending node number
- * Called only at init time.
- */
-static void __init build_devlist(void)
-{
-	u8 nodenum;
-	unsigned int nodes_got = 0;
-	unsigned int devs = 0;
-	struct pnp_bios_node *node;
-	struct pnp_dev_node_info node_info;
-	struct pci_dev *dev;
-	
-	if (!pnp_bios_present())
-		return;
-
-	if (pnp_bios_dev_node_info(&node_info) != 0)
-		return;
-
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node)
-		return;
-
-	for(nodenum=0; nodenum<0xff; ) {
-		u8 thisnodenum = nodenum;
-		/* We build the list from the "boot" config because
-		 * asking for the "current" config causes some
-		 * BIOSes to crash.
-		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )1 , node))
-			break;
-		nodes_got++;
-		dev =  pnpbios_kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
-		if (!dev)
-			break;
-		memset(dev,0,sizeof(struct pci_dev));
-		dev->devfn = thisnodenum;
-		memcpy(dev->name,"PNPBIOS",8);
-		pnpid32_to_pnpid(node->eisa_id,dev->slot_name);
-		node_resource_data_to_dev(node,dev);
-		if(insert_device(dev)<0)
-			kfree(dev);
-		else
-			devs++;
-		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (unsigned int)nodenum, (unsigned int)thisnodenum);
-			break;
-		}
-	}
-	kfree(node);
-
-	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver\n",
-		nodes_got, nodes_got != 1 ? "s" : "", devs);
-}
-
-static struct pci_dev *find_device_by_nodenum( u8 nodenum )
-{
-	struct pci_dev *dev;
-
-	pnpbios_for_each_dev(dev) {
-		if(dev->devfn == nodenum)
-			return dev;
-	}
-
-	return NULL;
-}
-
-static void update_devlist( u8 nodenum, struct pnp_bios_node *data )
-{
-	unsigned long flags;
-	struct pci_dev *dev;
-
-	spin_lock_irqsave(&pnpbios_devices_lock, flags);
-	dev = find_device_by_nodenum( nodenum );
-	if ( dev ) {
-		node_resource_data_to_dev(data,dev);
-	}
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
-
-	return;
-}
-
-
-/*
- *
- * DRIVER REGISTRATION FUNCTIONS
- *
- *
- * Exported to give public access
- *
- */
-
-static LIST_HEAD(pnpbios_drivers);
-
-static const struct pnpbios_device_id *
-match_device(const struct pnpbios_device_id *ids, const struct pci_dev *dev)
-{
-	while (*ids->id)
-	{
-		if(memcmp(ids->id, dev->slot_name, 7)==0)
-			return ids;
-		ids++;
-	}
-	return NULL;
-}
-
-static int announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
-{
-	const struct pnpbios_device_id *id;
-	struct pci_dev tmpdev;
-	int ret;
-
-	if (drv->id_table) {
-		id = match_device(drv->id_table, dev);
-		if (!id)
-			return 0;
-	} else
-		id = NULL;
-
-	memcpy( &tmpdev, dev, sizeof(struct pci_dev));
-	tmpdev.global_list.prev = NULL;
-	tmpdev.global_list.next = NULL;
-
-	dev_probe_lock();
-	/* Obviously, probe() should not call any pnpbios functions */
-	ret = drv->probe(&tmpdev, id);
-	dev_probe_unlock();
-	if (ret < 1)
-		return 0;
-
-	dev->driver = (void *)drv;
-
-	return 1;
-}
-
-/**
- * pnpbios_register_driver - register a new pci driver
- * @drv: the driver structure to register
- * 
- * Adds the driver structure to the list of registered drivers
- *
- * For each device in the pnpbios device list that matches one of
- * the ids in drv->id_table, calls the driver's "probe" function with
- * arguments (1) a pointer to a *temporary* struct pci_dev containing
- * resource info for the device, and (2) a pointer to the id string
- * of the device.  Expects the probe function to return 1 if the
- * driver claims the device (otherwise 0) in which case, marks the
- * device as having this driver.
- * 
- * Returns the number of pci devices which were claimed by the driver
- * during registration.  The driver remains registered even if the
- * return value is zero.
- */
-int pnpbios_register_driver(struct pnpbios_driver *drv)
-{
-	struct pci_dev *dev;
-	unsigned long flags;
-	int count = 0;
-
-	list_add_tail(&drv->node, &pnpbios_drivers);
-	spin_lock_irqsave(&pnpbios_devices_lock, flags);
-	pnpbios_for_each_dev(dev) {
-		if (!pnpbios_dev_driver(dev))
-			count += announce_device(drv, dev);
-	}
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
-	return count;
-}
-
-EXPORT_SYMBOL(pnpbios_register_driver);
-
-/**
- * pnpbios_unregister_driver - unregister a pci driver
- * @drv: the driver structure to unregister
- * 
- * Deletes the driver structure from the list of registered PnPBIOS
- * drivers, gives it a chance to clean up by calling its "remove"
- * function for each device it was responsible for, and marks those
- * devices as driverless.
- */
-void pnpbios_unregister_driver(struct pnpbios_driver *drv)
-{
-	unsigned long flags;
-	struct pci_dev *dev;
-
-	list_del(&drv->node);
-	spin_lock_irqsave(&pnpbios_devices_lock, flags);
-	pnpbios_for_each_dev(dev) {
-		if (dev->driver == (void *)drv) {
-			if (drv->remove)
-				drv->remove(dev);
-			dev->driver = NULL;
-		}
-	}
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
-}
-
-EXPORT_SYMBOL(pnpbios_unregister_driver);
-
-
-/*
- *
- * RESOURCE RESERVATION FUNCTIONS
- *
- *
- * Used only at init time
- *
- */
-
-static void __init reserve_ioport_range(char *pnpid, int start, int end)
-{
-	struct resource *res;
-	char *regionid;
-
-	regionid = pnpbios_kmalloc(16, GFP_KERNEL);
-	if ( regionid == NULL )
-		return;
-	snprintf(regionid, 16, "PnPBIOS %s", pnpid);
-	res = request_region(start,end-start+1,regionid);
-	if ( res == NULL )
-		kfree( regionid );
-	else
-		res->flags &= ~IORESOURCE_BUSY;
-	/*
-	 * Failures at this point are usually harmless. pci quirks for
-	 * example do reserve stuff they know about too, so we may well
-	 * have double reservations.
-	 */
-	printk(KERN_INFO
-		"PnPBIOS: %s: ioport range 0x%x-0x%x %s reserved\n",
-		pnpid, start, end,
-		NULL != res ? "has been" : "could not be"
-	);
-
-	return;
-}
-
-static void __init reserve_resources_of_dev( struct pci_dev *dev )
-{
-	int i;
-
-	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
-		if ( dev->resource[i].flags & IORESOURCE_UNSET )
-			/* end of resources */
-			break;
-		if (dev->resource[i].flags & IORESOURCE_IO) {
-			/* ioport */
-			if ( dev->resource[i].start == 0 )
-				/* disabled */
-				/* Do nothing */
-				continue;
-			if ( dev->resource[i].start < 0x100 )
-				/*
-				 * Below 0x100 is only standard PC hardware
-				 * (pics, kbd, timer, dma, ...)
-				 * We should not get resource conflicts there,
-				 * and the kernel reserves these anyway
-				 * (see arch/i386/kernel/setup.c).
-				 * So, do nothing
-				 */
-				continue;
-			if ( dev->resource[i].end < dev->resource[i].start )
-				/* invalid endpoint */
-				/* Do nothing */
-				continue;
-			reserve_ioport_range(
-				dev->slot_name,
-				dev->resource[i].start,
-				dev->resource[i].end
-			);
-		} else if (dev->resource[i].flags & IORESOURCE_MEM) {
-			/* iomem */
-			/* For now do nothing */
-			continue;
-		} else {
-			/* Neither ioport nor iomem */
-			/* Do nothing */
-			continue;
-		}
-	}
-
-	return;
-}
-
-static void __init reserve_resources( void )
-{
-	struct pci_dev *dev;
-
-	pnpbios_for_each_dev(dev) {
-		if (
-			0 != strcmp(dev->slot_name,"PNP0c01") &&  /* memory controller */
-			0 != strcmp(dev->slot_name,"PNP0c02")     /* system peripheral: other */
-		) {
-			continue;
-		}  
-		reserve_resources_of_dev(dev);
-	}
-
-	return;
-}
-
-
-/* 
- *
- * INIT AND EXIT
- *
- */
-
-extern int is_sony_vaio_laptop;
-
-static int pnpbios_disabled; /* = 0 */
-static int dont_reserve_resources; /* = 0 */
-int pnpbios_dont_use_current_config; /* = 0 */
-
-#ifndef MODULE
-static int __init pnpbios_setup(char *str)
-{
-	int invert;
-
-	while ((str != NULL) && (*str != '\0')) {
-		if (strncmp(str, "off", 3) == 0)
-			pnpbios_disabled=1;
-		if (strncmp(str, "on", 2) == 0)
-			pnpbios_disabled=0;
-		invert = (strncmp(str, "no-", 3) == 0);
-		if (invert)
-			str += 3;
-		if (strncmp(str, "curr", 4) == 0)
-			pnpbios_dont_use_current_config = invert;
-		if (strncmp(str, "res", 3) == 0)
-			dont_reserve_resources = invert;
-		str = strchr(str, ',');
-		if (str != NULL)
-			str += strspn(str, ", \t");
-	}
-
-	return 1;
-}
-
-__setup("pnpbios=", pnpbios_setup);
-#endif
-
-subsys_initcall(pnpbios_init);
-
-int __init pnpbios_init(void)
-{
-	union pnp_bios_expansion_header *check;
-	u8 sum;
-	int i, length, r;
-
-	spin_lock_init(&pnp_bios_lock);
-	spin_lock_init(&pnpbios_devices_lock);
-
-	if(pnpbios_disabled) {
-		printk(KERN_INFO "PnPBIOS: Disabled\n");
-		return -ENODEV;
-	}
-
-	if ( is_sony_vaio_laptop )
-		pnpbios_dont_use_current_config = 1;
-
-	/*
- 	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
-	 * structure and, if one is found, sets up the selectors and
-	 * entry points
-	 */
-	for (check = (union pnp_bios_expansion_header *) __va(0xf0000);
-	     check < (union pnp_bios_expansion_header *) __va(0xffff0);
-	     ((void *) (check)) += 16) {
-		if (check->fields.signature != PNP_SIGNATURE)
-			continue;
-		length = check->fields.length;
-		if (!length)
-			continue;
-		for (sum = 0, i = 0; i < length; i++)
-			sum += check->chars[i];
-		if (sum)
-			continue;
-		if (check->fields.version < 0x10) {
-			printk(KERN_WARNING "PnPBIOS: PnP BIOS version %d.%d is not supported\n",
-			       check->fields.version >> 4,
-			       check->fields.version & 15);
-			continue;
-		}
-		printk(KERN_INFO "PnPBIOS: Found PnP BIOS installation structure at 0x%p\n", check);
-		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x\n",
-                       check->fields.version >> 4, check->fields.version & 15,
-		       check->fields.pm16cseg, check->fields.pm16offset,
-		       check->fields.pm16dseg);
-		pnp_bios_callpoint.offset = check->fields.pm16offset;
-		pnp_bios_callpoint.segment = PNP_CS16;
-		pnp_bios_hdr = check;
-
-		for(i=0; i < NR_CPUS; i++)
-		{
-			Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
-			Q_SET_SEL(i, PNP_CS16, check->fields.pm16cseg, 64 * 1024);
-			Q_SET_SEL(i, PNP_DS, check->fields.pm16dseg, 64 * 1024);
-		}
-		break;
-	}
-	if (!pnp_bios_present())
-		return -ENODEV;
-	build_devlist();
-	if ( ! dont_reserve_resources )
-		reserve_resources();
-#ifdef CONFIG_PROC_FS
-	r = pnpbios_proc_init();
-	if (r)
-		return r;
-#endif
-	return 0;
-}
-
-static int __init pnpbios_thread_init(void)
-{
-#ifdef CONFIG_HOTPLUG	
-	init_completion(&unload_sem);
-	if (kernel_thread(pnp_dock_thread, NULL, CLONE_KERNEL) > 0)
-		unloading = 0;
-#endif		
-	return 0;
-}
-
-#ifndef MODULE
-
-/* init/main.c calls pnpbios_init early */
-
-/* Start the kernel thread later: */
-module_init(pnpbios_thread_init);
-
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
diff -ur --new-file --exclude *.flags a/drivers/pnp/pnpbios_proc.c b/drivers/pnp/pnpbios_proc.c
--- a/drivers/pnp/pnpbios_proc.c	Tue Oct 15 17:31:32 2002
+++ b/drivers/pnp/pnpbios_proc.c	Thu Jan  1 00:00:00 1970
@@ -1,279 +0,0 @@
-/*
- * /proc/bus/pnp interface for Plug and Play devices
- *
- * Written by David Hinds, dahinds-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
- * Modified by Thomas Hood, jdthood-O5WfVfzUwx8@public.gmane.org
- *
- * The .../devices and .../<node> and .../boot/<node> files are
- * utilized by the lspnp and setpnp utilities, supplied with the
- * pcmcia-cs package.
- *     http://pcmcia-cs.sourceforge.net
- *
- * The .../escd file is utilized by the lsescd utility written by
- * Gunther Mayer.
- *     http://home.t-online.de/home/gunther.mayer/lsescd
- *
- * The .../legacy_device_resources file is not used yet.
- *
- * The other files are human-readable.
- */
-
-//#include <pcmcia/config.h>
-#define __NO_VERSION__
-//#include <pcmcia/k_compat.h>
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/pnpbios.h>
-#include <linux/init.h>
-
-static struct proc_dir_entry *proc_pnp = NULL;
-static struct proc_dir_entry *proc_pnp_boot = NULL;
-static struct pnp_dev_node_info node_info;
-
-static int proc_read_pnpconfig(char *buf, char **start, off_t pos,
-                               int count, int *eof, void *data)
-{
-	struct pnp_isa_config_struc pnps;
-
-	if (pnp_bios_isapnp_config(&pnps))
-		return -EIO;
-	return snprintf(buf, count,
-		"structure_revision %d\n"
-		"number_of_CSNs %d\n"
-		"ISA_read_data_port 0x%x\n",
-		pnps.revision,
-		pnps.no_csns,
-		pnps.isa_rd_data_port
-	);
-}
-
-static int proc_read_escdinfo(char *buf, char **start, off_t pos,
-                              int count, int *eof, void *data)
-{
-	struct escd_info_struc escd;
-
-	if (pnp_bios_escd_info(&escd))
-		return -EIO;
-	return snprintf(buf, count,
-		"min_ESCD_write_size %d\n"
-		"ESCD_size %d\n"
-		"NVRAM_base 0x%x\n",
-		escd.min_escd_write_size,
-		escd.escd_size,
-		escd.nv_storage_base
-	);
-}
-
-#define MAX_SANE_ESCD_SIZE (32*1024)
-static int proc_read_escd(char *buf, char **start, off_t pos,
-                          int count, int *eof, void *data)
-{
-	struct escd_info_struc escd;
-	char *tmpbuf;
-	int escd_size, escd_left_to_read, n;
-
-	if (pnp_bios_escd_info(&escd))
-		return -EIO;
-
-	/* sanity check */
-	if (escd.escd_size > MAX_SANE_ESCD_SIZE) {
-		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
-		return -EFBIG;
-	}
-
-	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
-	if (!tmpbuf) return -ENOMEM;
-
-	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base))
-		return -EIO;
-
-	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;
-
-	/* sanity check */
-	if (escd_size > MAX_SANE_ESCD_SIZE) {
-		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS read_escd call is too great\n");
-		return -EFBIG;
-	}
-
-	escd_left_to_read = escd_size - pos;
-	if (escd_left_to_read < 0) escd_left_to_read = 0;
-	if (escd_left_to_read == 0) *eof = 1;
-	n = min(count,escd_left_to_read);
-	memcpy(buf, tmpbuf + pos, n);
-	kfree(tmpbuf);
-	*start = buf;
-	return n;
-}
-
-static int proc_read_legacyres(char *buf, char **start, off_t pos,
-                               int count, int *eof, void *data)
-{
-	/* Assume that the following won't overflow the buffer */
-	if (pnp_bios_get_stat_res(buf)) 
-		return -EIO;
-
-	return count;  // FIXME: Return actual length
-}
-
-static int proc_read_devices(char *buf, char **start, off_t pos,
-                             int count, int *eof, void *data)
-{
-	struct pnp_bios_node *node;
-	u8 nodenum;
-	char *p = buf;
-
-	if (pos >= 0xff)
-		return 0;
-
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return -ENOMEM;
-
-	for (nodenum=pos; nodenum<0xff; ) {
-		u8 thisnodenum = nodenum;
-		/* 26 = the number of characters per line sprintf'ed */
-		if ((p - buf + 26) > count)
-			break;
-		if (pnp_bios_get_dev_node(&nodenum, 1, node))
-			break;
-		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
-			     node->handle, node->eisa_id,
-			     node->type_code[0], node->type_code[1],
-			     node->type_code[2], node->flags);
-		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_read_devices:", (unsigned int)nodenum, (unsigned int)thisnodenum);
-			*eof = 1;
-			break;
-		}
-	}
-	kfree(node);
-	if (nodenum == 0xff)
-		*eof = 1;
-	*start = (char *)((off_t)nodenum - pos);
-	return p - buf;
-}
-
-static int proc_read_node(char *buf, char **start, off_t pos,
-                          int count, int *eof, void *data)
-{
-	struct pnp_bios_node *node;
-	int boot = (long)data >> 8;
-	u8 nodenum = (long)data;
-	int len;
-
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return -ENOMEM;
-	if (pnp_bios_get_dev_node(&nodenum, boot, node))
-		return -EIO;
-	len = node->size - sizeof(struct pnp_bios_node);
-	memcpy(buf, node->data, len);
-	kfree(node);
-	return len;
-}
-
-static int proc_write_node(struct file *file, const char *buf,
-                           unsigned long count, void *data)
-{
-	struct pnp_bios_node *node;
-	int boot = (long)data >> 8;
-	u8 nodenum = (long)data;
-
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return -ENOMEM;
-	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
-		return -EIO;
-	if (count != node->size - sizeof(struct pnp_bios_node))
-		return -EINVAL;
-	memcpy(node->data, buf, count);
-	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
-	    return -EINVAL;
-	kfree(node);
-	return count;
-}
-
-/*
- * When this is called, pnpbios functions are assumed to
- * work and the pnpbios_dont_use_current_config flag
- * should already have been set to the appropriate value
- */
-int __init pnpbios_proc_init( void )
-{
-	struct pnp_bios_node *node;
-	struct proc_dir_entry *ent;
-	char name[3];
-	u8 nodenum;
-
-	if (pnp_bios_dev_node_info(&node_info))
-		return -EIO;
-	
-	proc_pnp = proc_mkdir("pnp", proc_bus);
-	if (!proc_pnp)
-		return -EIO;
-	proc_pnp_boot = proc_mkdir("boot", proc_pnp);
-	if (!proc_pnp_boot)
-		return -EIO;
-	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
-	create_proc_read_entry("configuration_info", 0, proc_pnp, proc_read_pnpconfig, NULL);
-	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo, NULL);
-	create_proc_read_entry("escd", S_IRUSR, proc_pnp, proc_read_escd, NULL);
-	create_proc_read_entry("legacy_device_resources", 0, proc_pnp, proc_read_legacyres, NULL);
-	
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
-	for (nodenum=0; nodenum<0xff; ) {
-		u8 thisnodenum = nodenum;
-		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
-			break;
-		sprintf(name, "%02x", node->handle);
-		if ( !pnpbios_dont_use_current_config ) {
-			ent = create_proc_entry(name, 0, proc_pnp);
-			if (ent) {
-				ent->read_proc = proc_read_node;
-				ent->write_proc = proc_write_node;
-				ent->data = (void *)(long)(node->handle);
-			}
-		}
-		ent = create_proc_entry(name, 0, proc_pnp_boot);
-		if (ent) {
-			ent->read_proc = proc_read_node;
-			ent->write_proc = proc_write_node;
-			ent->data = (void *)(long)(node->handle+0x100);
-		}
-		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_init:", (unsigned int)nodenum, (unsigned int)thisnodenum);
-			break;
-		}
-	}
-	kfree(node);
-
-	return 0;
-}
-
-void __exit pnpbios_proc_exit(void)
-{
-	int i;
-	char name[3];
-	
-	if (!proc_pnp) return;
-
-	for (i=0; i<0xff; i++) {
-		sprintf(name, "%02x", i);
-		if ( !pnpbios_dont_use_current_config )
-			remove_proc_entry(name, proc_pnp);
-		remove_proc_entry(name, proc_pnp_boot);
-	}
-	remove_proc_entry("legacy_device_resources", proc_pnp);
-	remove_proc_entry("escd", proc_pnp);
-	remove_proc_entry("escd_info", proc_pnp);
-	remove_proc_entry("configuration_info", proc_pnp);
-	remove_proc_entry("devices", proc_pnp);
-	remove_proc_entry("boot", proc_pnp);
-	remove_proc_entry("pnp", proc_bus);
-
-	return;
-}
diff -ur --new-file --exclude *.flags a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
--- a/drivers/pnp/quirks.c	Tue Oct 15 17:31:32 2002
+++ b/drivers/pnp/quirks.c	Mon Oct 14 12:48:46 2002
@@ -1,5 +1,5 @@
 /*
- *  This file contains quirk handling code for ISAPnP devices
+ *  This file contains quirk handling code for PnP devices
  *  Some devices do not report all their resources, and need to have extra
  *  resources added. This is most easily accomplished at initialisation time
  *  when building up the resource structure for the first time.
@@ -11,21 +11,25 @@
  *  Copyright (c) 1999 Martin Mares <mj-+ZI9xUNit7I@public.gmane.org>
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/isapnp.h>
 #include <linux/string.h>
 
-#if 0
-#define ISAPNP_DEBUG
+#ifdef CONFIG_PNP_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
 #endif
 
-static void __init quirk_awe32_resources(struct pci_dev *dev)
+#include <linux/pnp.h>
+#include "base.h"
+
+
+static void quirk_awe32_resources(struct pnp_dev *dev)
 {
-	struct isapnp_port *port, *port2, *port3;
-	struct isapnp_resources *res = dev->sysdata;
+	struct pnp_port *port, *port2, *port3;
+	struct pnp_resources *res = dev->res->dep;
 
 	/*
 	 * Unfortunately the isapnp_add_port_resource is too tightly bound
@@ -33,14 +37,14 @@
 	 * two extra ports (at offset 0x400 and 0x800 from the one given) by
 	 * hand.
 	 */
-	for ( ; res ; res = res->alt ) {
-		port2 = isapnp_alloc(sizeof(struct isapnp_port));
-		port3 = isapnp_alloc(sizeof(struct isapnp_port));
+	for ( ; res ; res = res->dep ) {
+		port2 = pnp_alloc(sizeof(struct pnp_port));
+		port3 = pnp_alloc(sizeof(struct pnp_port));
 		if (!port2 || !port3)
 			return;
 		port = res->port;
-		memcpy(port2, port, sizeof(struct isapnp_port));
-		memcpy(port3, port, sizeof(struct isapnp_port));
+		memcpy(port2, port, sizeof(struct pnp_port));
+		memcpy(port3, port, sizeof(struct pnp_port));
 		port->next = port2;
 		port2->next = port3;
 		port2->min += 0x400;
@@ -48,18 +52,18 @@
 		port3->min += 0x800;
 		port3->max += 0x800;
 	}
-	printk(KERN_INFO "isapnp: AWE32 quirk - adding two ports\n");
+	printk(KERN_INFO "pnp: AWE32 quirk - adding two ports\n");
 }
 
-static void __init quirk_cmi8330_resources(struct pci_dev *dev)
+static void quirk_cmi8330_resources(struct pnp_dev *dev)
 {
-	struct isapnp_resources *res = dev->sysdata;
+	struct pnp_resources *res = dev->res->dep;
 
-	for ( ; res ; res = res->alt ) {
+	for ( ; res ; res = res->dep ) {
+
+		struct pnp_irq *irq;
+		struct pnp_dma *dma;
 
-		struct isapnp_irq *irq;
-		struct isapnp_dma *dma;
-	
 		for( irq = res->irq; irq; irq = irq->next )	// Valid irqs are 5, 7, 10
 			irq->map = 0x04A0;						// 0000 0100 1010 0000
 
@@ -67,22 +71,22 @@
 			if( ( dma->flags & IORESOURCE_DMA_TYPE_MASK ) == IORESOURCE_DMA_8BIT )
 				dma->map = 0x000A;
 	}
-	printk(KERN_INFO "isapnp: CMI8330 quirk - fixing interrupts and dma\n");
+	printk(KERN_INFO "pnp: CMI8330 quirk - fixing interrupts and dma\n");
 }
 
-static void __init quirk_sb16audio_resources(struct pci_dev *dev)
+static void quirk_sb16audio_resources(struct pnp_dev *dev)
 {
-	struct isapnp_port *port;
-	struct isapnp_resources *res = dev->sysdata;
+	struct pnp_port *port;
+	struct pnp_resources *res = dev->res->dep;
 	int    changed = 0;
 
-	/* 
+	/*
 	 * The default range on the mpu port for these devices is 0x388-0x388.
 	 * Here we increase that range so that two such cards can be
 	 * auto-configured.
 	 */
-	
-	for( ; res ; res = res->alt ) {
+
+	for( ; res ; res = res->dep ) {
 		port = res->port;
 		if(!port)
 			continue;
@@ -98,82 +102,68 @@
 		changed = 1;
 	}
 	if(changed)
-		printk(KERN_INFO "isapnp: SB audio device quirk - increasing port range\n");
+		printk(KERN_INFO "pnp: SB audio device quirk - increasing port range\n");
 	return;
 }
 
-extern int isapnp_allow_dma0;
-static void __init quirk_opl3sax_resources(struct pci_dev *dev)
+extern int pnp_allow_dma0;
+static void quirk_opl3sax_resources(struct pnp_dev *dev)
 {
 	/* This really isn't a device quirk but isapnp core code
 	 * doesn't allow a DMA channel of 0, afflicted card is an
 	 * OPL3Sax where x=4.
 	 */
-	struct isapnp_resources *res;
+	struct pnp_resources *res;
 	int max;
-	res = (struct isapnp_resources *)dev->sysdata;
-	max = res->dma->map;
-	for (res = res->alt; res; res = res->alt) {
+	res = dev->res;
+	max = 0;
+	for (res = res->dep; res; res = res->dep) {
 		if (res->dma->map > max)
 			max = res->dma->map;
 	}
-	if (max == 1 && isapnp_allow_dma0 == -1) {
-		printk(KERN_INFO "isapnp: opl3sa4 quirk: Allowing dma 0.\n");
-		isapnp_allow_dma0 = 1;
+	if (max == 1 && pnp_allow_dma0 == -1) {
+		printk(KERN_INFO "pnp: opl3sa4 quirk: Allowing dma 0.\n");
+		pnp_allow_dma0 = 1;
 	}
 	return;
 }
 
 /*
- *  ISAPnP Quirks
- *  Cards or devices that need some tweaking due to broken hardware
+ *  PnP Quirks
+ *  Cards or devices that need some tweaking due to incomplete resource info
  */
 
-static struct isapnp_fixup isapnp_fixups[] __initdata = {
+static struct pnp_fixup pnp_fixups[] = {
 	/* Soundblaster awe io port quirk */
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0021),
-		quirk_awe32_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0022),
-		quirk_awe32_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0023),
-		quirk_awe32_resources },
+	{ "CTL0021", quirk_awe32_resources },
+	{ "CTL0022", quirk_awe32_resources },
+	{ "CTL0023", quirk_awe32_resources },
 	/* CMI 8330 interrupt and dma fix */
-	{ ISAPNP_VENDOR('@','X','@'), ISAPNP_DEVICE(0x0001),
-		quirk_cmi8330_resources },
+	{ "@X@0001", quirk_cmi8330_resources },
 	/* Soundblaster audio device io port range quirk */
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0001),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0031),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0041),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0042),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0043),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0044),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0045),
-		quirk_sb16audio_resources },
-	{ ISAPNP_VENDOR('Y','M','H'), ISAPNP_DEVICE(0x0021),
-		quirk_opl3sax_resources },
-	{ 0 }
+	{ "CTL0001", quirk_sb16audio_resources },
+	{ "CTL0031", quirk_sb16audio_resources },
+	{ "CTL0041", quirk_sb16audio_resources },
+	{ "CTL0042", quirk_sb16audio_resources },
+	{ "CTL0043", quirk_sb16audio_resources },
+	{ "CTL0044", quirk_sb16audio_resources },
+	{ "CTL0045", quirk_sb16audio_resources },
+	{ "YMH0021", quirk_opl3sax_resources },
+	{ "" }
 };
 
-void isapnp_fixup_device(struct pci_dev *dev)
+void pnp_fixup_device(struct pnp_dev *dev)
 {
 	int i = 0;
 
-	while (isapnp_fixups[i].vendor != 0) {
-		if ((isapnp_fixups[i].vendor == dev->vendor) &&
-		    (isapnp_fixups[i].device == dev->device)) {
-#ifdef ISAPNP_DEBUG
-			printk(KERN_DEBUG "isapnp: Calling quirk for %02x:%02x\n",
-			       dev->bus->number, dev->devfn);
-#endif
-			isapnp_fixups[i].quirk_function(dev);
+	while (*pnp_fixups[i].id) {
+		if (compare_pnp_id(&dev->ids,pnp_fixups[i].id)) {
+			pnp_dbg("Calling quirk for %s",
+		                  dev->dev.bus_id);
+			pnp_fixups[i].quirk_function(dev);
 		}
 		i++;
 	}
+	return;
 }
 
diff -ur --new-file --exclude *.flags a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/resource.c	Tue Oct 15 16:37:04 2002
@@ -0,0 +1,798 @@
+/*
+ * resource.c - contains resource management algorithms
+ *
+ * Some code is based on isapnp.c resource management (c) Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/irq.h>
+#include <linux/ioport.h>
+#include <linux/config.h>
+#include <linux/init.h>
+
+#ifdef CONFIG_PNP_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+
+#include <linux/pnp.h>
+#include "base.h"
+
+int pnp_allow_dma0 = -1;		        /* allow dma 0 during auto activation: -1=off (:default), 0=off (set by user), 1=on */
+int pnp_skip_pci_scan;				/* skip PCI resource scanning */
+int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
+int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
+int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
+int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
+
+
+/* resource information storage functions */
+
+struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent)
+{
+	struct pnp_resources *res, *ptr, *ptra;
+
+	res = pnp_alloc(sizeof(struct pnp_resources));
+	if (!res)
+		return NULL;
+	ptr = dev->res;
+	if (ptr && ptr->dependent && dependent) { /* add to another list */
+		ptra = ptr->dep;
+		while (ptra && ptra->dep)
+			ptra = ptra->dep;
+		if (!ptra)
+			ptr->dep = res;
+		else
+			ptra->dep = res;
+	} else {
+		if (!ptr){
+			dev->res = res;
+		}
+		else{
+			kfree(res);
+			return NULL;
+		}
+	}
+	if (dependent) {
+		res->priority = dependent & 0xff;
+		if (res->priority > PNP_RES_PRIORITY_FUNCTIONAL)
+			res->priority = PNP_RES_PRIORITY_INVALID;
+		res->dependent = 1;
+	} else {
+		res->priority = PNP_RES_PRIORITY_PREFERRED;
+		res->dependent = 1;
+	}
+	return res;
+}
+
+struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum)
+{
+	int i;
+	struct pnp_resources *res;
+	if (!dev)
+		return NULL;
+	res = dev->res;
+	if (!res)
+		return NULL;
+	for (i = 0; i < depnum; i++)
+	{
+		if (res->dep)
+			res = res->dep;
+		else
+			return NULL;
+	}
+	return res;
+}
+
+int pnp_get_max_depnum(struct pnp_dev *dev)
+{
+	struct pnp_resources *res;
+	if (!dev)
+		return -EINVAL;
+	res = dev->res;
+	if (!res)
+		return -EINVAL;
+	int num = 0;
+	while (res->dep){
+		res = res->dep;
+		num++;
+	}
+	return num;
+}
+
+/*
+ *  Add IRQ resource to resources list.
+ */
+
+int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
+{
+	int i;
+	struct pnp_resources *res;
+	struct pnp_irq *ptr;
+	res = pnp_find_resources(dev,depnum);
+	if (!res)
+		return -EINVAL;
+	if (!data)
+		return -EINVAL;
+	ptr = res->irq;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = data;
+	else
+		res->irq = data;
+#ifdef CONFIG_PCI
+	for (i=0; i<16; i++)
+		if (data->map & (1<<i))
+			pcibios_penalize_isa_irq(i);
+#endif
+	return 0;
+}
+
+/*
+ *  Add DMA resource to resources list.
+ */
+
+int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data)
+{
+	struct pnp_resources *res;
+	struct pnp_dma *ptr;
+	res = pnp_find_resources(dev,depnum);
+	if (!res)
+		return -EINVAL;
+	if (!data)
+		return -EINVAL;
+	ptr = res->dma;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = data;
+	else
+		res->dma = data;
+	return 0;
+}
+
+/*
+ *  Add port resource to resources list.
+ */
+
+int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data)
+{
+	struct pnp_resources *res;
+	struct pnp_port *ptr;
+	res = pnp_find_resources(dev,depnum);
+	if (res==NULL)
+		return -EINVAL;
+	if (!data)
+		return -EINVAL;
+	data->res = res;
+	ptr = res->port;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = data;
+	else
+		res->port = data;
+	return 0;
+}
+
+/*
+ *  Add memory resource to resources list.
+ */
+
+int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data)
+{
+	struct pnp_resources *res;
+	struct pnp_mem *ptr;
+	res = pnp_find_resources(dev,depnum);
+	if (!res)
+		return -EINVAL;
+	if (!data)
+		return -EINVAL;
+	ptr = res->mem;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = data;
+	else
+		res->mem = data;
+	return 0;
+}
+
+/*
+ *  Add 32-bit memory resource to resources list.
+ */
+
+int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_mem32 *data)
+{
+	struct pnp_resources *res;
+	struct pnp_mem32 *ptr;
+	res = pnp_find_resources(dev,depnum);
+	if (!res)
+		return -EINVAL;
+	if (!data)
+		return -EINVAL;
+	ptr = res->mem32;
+	while (ptr && ptr->next)
+		ptr = ptr->next;
+	if (ptr)
+		ptr->next = data;
+	else
+		res->mem32 = data;
+	return 0;
+}
+
+
+/* resource validity checking functions */
+
+static int pnp_check_port(int port, int size)
+{
+	int i, tmp, rport, rsize;
+	struct pnp_dev *dev;
+
+	if (check_region(port, size))
+		return 1;
+	for (i = 0; i < 8; i++) {
+		rport = pnp_reserve_io[i << 1];
+		rsize = pnp_reserve_io[(i << 1) + 1];
+		if (port >= rport && port < rport + rsize)
+			return 1;
+		if (port + size > rport && port + size < (rport + rsize) - 1)
+			return 1;
+	}
+
+	pnp_for_each_dev(dev) {
+		if (dev->active) {
+			for (tmp = 0; tmp < 8; tmp++) {
+				if (dev->resource[tmp].flags) {
+					rport = dev->resource[tmp].start;
+					rsize = (dev->resource[tmp].end - rport) + 1;
+					if (port >= rport && port < rport + rsize)
+						return 1;
+					if (port + size > rport && port + size < (rport + rsize) - 1)
+						return 1;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static int pnp_check_mem(unsigned int addr, unsigned int size)
+{
+	int i, tmp;
+	unsigned int raddr, rsize;
+	struct pnp_dev *dev;
+
+	for (i = 0; i < 8; i++) {
+		raddr = (unsigned int)pnp_reserve_mem[i << 1];
+		rsize = (unsigned int)pnp_reserve_mem[(i << 1) + 1];
+		if (addr >= raddr && addr < raddr + rsize)
+			return 1;
+		if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
+			return 1;
+		if (__check_region(&iomem_resource, addr, size))
+			return 1;
+	}
+	pnp_for_each_dev(dev) {
+		if (dev->active) {
+			for (tmp = 0; tmp < 4; tmp++) {
+				if (dev->resource[tmp].flags) {
+					raddr = dev->resource[tmp + 8].start;
+					rsize = (dev->resource[tmp + 8].end - raddr) + 1;
+					if (addr >= raddr && addr < raddr + rsize)
+						return 1;
+					if (addr + size > raddr && addr + size < (raddr + rsize) - 1)
+						return 1;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static void pnp_test_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+}
+
+static int pnp_check_interrupt(int irq, struct pnp_cfg *config)
+{
+	int i;
+	struct pnp_dev *dev;
+	if (!config)
+		return 1;
+
+	if (irq < 0 || irq > 15)
+		return 1;
+	for (i = 0; i < 16; i++) {
+		if (pnp_reserve_irq[i] == irq)
+			return 1;
+	}
+	pnp_for_each_dev(dev) {
+		if (dev->active) {
+			if ((dev->irq_resource[0].flags && dev->irq_resource[0].start == irq) ||
+			    (dev->irq_resource[1].flags && dev->irq_resource[1].start == irq))
+				return 1;
+		}
+	}
+	if (config->request.irq_resource[0].flags && config->request.irq_resource[1].flags &&
+	   (config->request.irq_resource[0].start == irq))
+		return 1;
+#ifdef CONFIG_PCI
+	struct pci_dev *pci;
+	if (!pnp_skip_pci_scan) {
+		pci_for_each_dev(pci) {
+			if (pci->irq == irq)
+				return 1;
+		}
+	}
+#endif
+	if (request_irq(irq, pnp_test_handler, SA_INTERRUPT, "pnp", NULL))
+		return 1;
+	free_irq(irq, NULL);
+	return 0;
+}
+
+static int pnp_check_dma(int dma, struct pnp_cfg *config)
+{
+	int i, mindma = 1;
+	struct pnp_dev *dev;
+	if (!config)
+		return 1;
+
+	if (pnp_allow_dma0 == 1)
+		mindma = 0;
+	if (dma < mindma || dma == 4 || dma > 7)
+		return 1;
+	for (i = 0; i < 8; i++) {
+		if (pnp_reserve_dma[i] == dma)
+			return 1;
+	}
+	pnp_for_each_dev(dev) {
+		if (dev->active) {
+			if ((dev->dma_resource[0].flags && dev->dma_resource[0].start == dma) ||
+			    (dev->dma_resource[1].flags && dev->dma_resource[1].start == dma))
+				return 1;
+		}
+	}
+	if (config->request.dma_resource[0].flags && config->request.dma_resource[1].flags &&
+	   (config->request.dma_resource[0].start == dma))
+		return 1;
+	if (request_dma(dma, "pnp"))
+		return 1;
+	free_dma(dma);
+	return 0;
+}
+
+
+/* config generation functions */
+static int pnp_generate_port(struct pnp_cfg *config, int num)
+{
+	if (!config || num < 0 || num > 7)
+		return -EINVAL;
+	struct pnp_port *port = config->port[num];
+	if (!port)
+		return 0;
+	unsigned long *value1, *value2, *value3;
+	value1 = &config->request.resource[num].start;
+	value2 = &config->request.resource[num].end;
+	value3 = &config->request.resource[num].flags;
+	*value1 = port->min;
+	*value2 = *value1 + port->size -1;
+	*value3 = port->flags | IORESOURCE_IO;
+	while (pnp_check_port(*value1, port->size)) {
+		*value1 += port->align;
+		*value2 = *value1 + port->size - 1;
+		if (*value1 > port->max || !port->align)
+			return -ENOENT;
+	}
+	return 0;
+}
+
+static int pnp_generate_mem(struct pnp_cfg *config, int num)
+{
+	if (!config || num < 0 || num > 3)
+		return -EINVAL;
+	struct pnp_mem *mem = config->mem[num];
+	if (!mem)
+		return 0;
+	unsigned long *value1, *value2, *value3;
+	value1 = &config->request.resource[num + 8].start;
+	value2 = &config->request.resource[num + 8].end;
+	value3 = &config->request.resource[num].flags;
+	*value1 = mem->min;
+	*value2 = *value1 + mem->size -1;
+	*value3 = mem->flags | IORESOURCE_MEM;
+	if (!(mem->flags & IORESOURCE_MEM_WRITEABLE))
+		*value3 |= IORESOURCE_READONLY;
+	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
+		*value3 |= IORESOURCE_CACHEABLE;
+	if (mem->flags & IORESOURCE_MEM_RANGELENGTH)
+		*value3 |= IORESOURCE_RANGELENGTH;
+	if (mem->flags & IORESOURCE_MEM_SHADOWABLE)
+		*value3 |= IORESOURCE_SHADOWABLE;
+	while (pnp_check_mem(*value1, mem->size)) {
+		*value1 += mem->align;
+		*value2 = *value1 + mem->size - 1;
+		if (*value1 > mem->max || !mem->align)
+			return -ENOENT;
+	}
+	return 0;
+}
+
+static int pnp_generate_irq(struct pnp_cfg *config, int num)
+{
+	if (!config || num < 0 || num > 1)
+		return -EINVAL;
+	struct pnp_irq *irq = config->irq[num];
+	if (!irq)
+		return 0;
+	unsigned long *value1, *value2, *value3;
+	value1 = &config->request.irq_resource[num].start;
+	value2 = &config->request.irq_resource[num].end;
+	value3 = &config->request.irq_resource[num].flags;
+	*value3 = irq->flags | IORESOURCE_IRQ;
+
+	/* IRQ priority: this table is good for i386 */
+	static unsigned short xtab[16] = {
+		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
+	};
+	int i;
+	for (i=0; i < 16; i++)
+	{
+		if(irq->map & (1<<xtab[i])) {
+		*value1 = *value2 = xtab[i];
+		if(pnp_check_interrupt(*value1,config)==0)
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+static int pnp_generate_dma(struct pnp_cfg *config, int num)
+{
+	if (!config || num < 0 || num > 1)
+		return -EINVAL;
+	struct pnp_dma *dma = config->dma[num];
+	if (!dma)
+		return 0;
+	unsigned long *value1, *value2, *value3;
+	value1 = &config->request.dma_resource[num].start;
+	value2 = &config->request.dma_resource[num].end;
+	value3 = &config->request.dma_resource[num].flags;
+	*value3 = dma->flags | IORESOURCE_DMA;
+	/* DMA priority: this table is good for i386 */
+	static unsigned short xtab[16] = {
+		1, 3, 5, 6, 7, 0, 2, 4
+	};
+	int i;
+	for (i=0; i < 8; i++)
+	{
+		if(dma->map & (1<<xtab[i])) {
+		*value1 = *value2 = xtab[i];
+		if(pnp_check_dma(*value1,config)==0)
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+static int pnp_prepare_request(struct pnp_cfg *config)
+{
+	if (!config)
+		return -EINVAL;
+	struct pnp_dev *dev = &config->request;
+	int idx;
+	if (dev == NULL)
+		return -EINVAL;
+	if (dev->active || dev->ro)
+		return -EBUSY;
+	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
+		dev->irq_resource[idx].name = NULL;
+		dev->irq_resource[idx].start = -1;
+		dev->irq_resource[idx].end = -1;
+		dev->irq_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++) {
+		dev->dma_resource[idx].name = NULL;
+		dev->dma_resource[idx].start = -1;
+		dev->dma_resource[idx].end = -1;
+		dev->dma_resource[idx].flags = 0;
+	}
+	for (idx = 0; idx < DEVICE_COUNT_RESOURCE; idx++) {
+		dev->resource[idx].name = NULL;
+		dev->resource[idx].start = 0;
+		dev->resource[idx].end = 0;
+		dev->resource[idx].flags = 0;
+	}
+	return 0;
+}
+
+static int pnp_generate_request(struct pnp_cfg *config)
+{
+	if (!config)
+		return -EINVAL;
+	if (pnp_prepare_request<0)
+		return -ENOENT;
+	int i;
+	for (i=0; i<=7; i++)
+	{
+		if(pnp_generate_port(config,i)<0)
+			return -ENOENT;
+	}
+	for (i=0; i<=3; i++)
+	{
+		if(pnp_generate_mem(config,i)<0)
+			return -ENOENT;
+	}
+	for (i=0; i<=1; i++)
+	{
+		if(pnp_generate_irq(config,i)<0)
+			return -ENOENT;
+	}
+	for (i=0; i<=1; i++)
+	{
+		if(pnp_generate_dma(config,i)<0)
+			return -ENOENT;
+	}
+	return 0;
+}
+
+
+
+static struct pnp_cfg * pnp_generate_config(struct pnp_dev *dev, int depnum)
+{
+	if (!dev)
+		return NULL;
+	if (depnum < 0)
+		return NULL;
+	struct pnp_cfg * config = pnp_alloc(sizeof(struct pnp_cfg));
+	if (!config)
+		return NULL;
+	int nport = 0, nirq = 0, ndma = 0, nmem = 0;
+
+	/* independent */
+	struct pnp_resources * res = dev->res;
+	struct pnp_port * port = res->port;
+	struct pnp_mem * mem = res->mem;
+	struct pnp_irq * irq = res->irq;
+	struct pnp_dma * dma = res->dma;
+	while (port){
+		config->port[nport] = port;
+		nport++;
+		port = port->next;
+	}
+	while (mem){
+		config->mem[nmem] = mem;
+		nmem++;
+		mem = mem->next;
+	}
+	while (irq){
+		config->irq[nirq] = irq;
+		nirq++;
+		irq = irq->next;
+	}
+	while (dma){
+		config->dma[ndma] = dma;
+		ndma++;
+		dma = dma->next;
+	}
+
+	/* dependent */
+	if (depnum == 0)
+		return config;
+	res = pnp_find_resources(dev, depnum);
+	port = res->port;
+	mem = res->mem;
+	irq = res->irq;
+	dma = res->dma;
+	while (port){
+		config->port[nport] = port;
+		nport++;
+		port = port->next;
+	}
+	while (mem){
+		config->mem[nmem] = mem;
+		nmem++;
+		mem = mem->next;
+	}
+
+	while (irq){
+		config->irq[nirq] = irq;
+		nirq++;
+		irq = irq->next;
+	}
+	while (dma){
+		config->dma[ndma] = dma;
+		ndma++;
+		dma = dma->next;
+	}
+	return config;
+}
+
+/* PnP Device Resource Management */
+
+/**
+ * pnp_activate_dev - activates a PnP device for use
+ * @dev: pointer to the desired device
+ *
+ * finds the best resource configuration and then informs the correct pnp protocol
+ */
+
+int pnp_activate_dev(struct pnp_dev *dev)
+{
+	if (dev->active)
+		return -EBUSY;
+	if (dev->driver){
+		printk(KERN_INFO "pnp: Automatic configuration failed because the PnP device '%s' is busy\n", dev->dev.bus_id);
+		return -EINVAL;
+	}
+	if (!dev->protocol->get || !dev->protocol->set)
+		return -EINVAL;
+	if (!dev)
+		return -EINVAL;
+	struct pnp_cfg *config;
+	int depnum, max = pnp_get_max_depnum(dev);
+	if (max == 0)
+		return 0;
+	for (depnum=1; depnum <= max; depnum++)
+	{
+		config = pnp_generate_config(dev,depnum);
+		if (!config)
+			return -EINVAL;
+		if (pnp_generate_request(config)==0)
+			goto done;
+		kfree(config);
+	}
+	printk(KERN_ERR "pnp: Automatic configuration failed for device '%s' due to resource conflicts\n", dev->dev.bus_id);
+	return -ENOENT;
+
+	done:
+	pnp_dbg("the device '%s' has been activated", dev->dev.bus_id);
+	dev->protocol->set(dev,config,0);
+	if (dev->protocol->get)
+		dev->protocol->get(dev);
+	kfree(config);
+	return 0;
+}
+
+/**
+ * pnp_disable_dev - disables device
+ * @dev: pointer to the desired device
+ *
+ * inform the correct pnp protocol so that resources can be used by other devices
+ */
+
+int pnp_disable_dev(struct pnp_dev *dev)
+{
+	if (dev->driver){
+		printk(KERN_INFO "pnp: Disable failed becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
+		return -EINVAL;
+	}
+	if (!dev->protocol->disable || !dev->active)
+		return -EINVAL;
+	pnp_dbg("the device '%s' has been disabled", dev->dev.bus_id);
+	return dev->protocol->disable(dev);
+}
+
+/**
+ * pnp_raw_set_dev - same as pnp_activate_dev except the resource config can be specified
+ * @dev: pointer to the desired device
+ * @depnum: resource dependent function
+ * @mode: static or dynamic
+ *
+ */
+
+int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode)
+{
+	if (dev->driver){
+		printk(KERN_INFO "pnp: Unable to set resources becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
+		return -EINVAL;
+	}
+	if (!dev->protocol->get || !dev->protocol->set)
+		return -EINVAL;
+	if (!dev)
+		return -EINVAL;
+	struct pnp_cfg *config = pnp_generate_config(dev,depnum);
+	if (!config)
+		return -EINVAL;
+	if (pnp_generate_request(config)==0)
+		goto done;
+	kfree(config);
+	printk(KERN_ERR "pnp: Manual configuration failed for device '%s' due to resource conflicts\n", dev->dev.bus_id);
+	return -ENOENT;
+
+	done:
+	dev->protocol->set(dev,config,mode);
+	if (dev->protocol->get)
+		dev->protocol->get(dev);
+	kfree(config);
+	return 0;
+}
+
+EXPORT_SYMBOL(pnp_build_resource);
+EXPORT_SYMBOL(pnp_find_resources);
+EXPORT_SYMBOL(pnp_get_max_depnum);
+EXPORT_SYMBOL(pnp_add_irq_resource);
+EXPORT_SYMBOL(pnp_add_dma_resource);
+EXPORT_SYMBOL(pnp_add_port_resource);
+EXPORT_SYMBOL(pnp_add_mem_resource);
+EXPORT_SYMBOL(pnp_add_mem32_resource);
+EXPORT_SYMBOL(pnp_activate_dev);
+EXPORT_SYMBOL(pnp_disable_dev);
+EXPORT_SYMBOL(pnp_raw_set_dev);
+
+/* format is: allowdma0 */
+
+static int __init pnp_allowdma0(char *str)
+{
+        pnp_allow_dma0 = 1;
+	return 1;
+}
+
+__setup("allowdma0", pnp_allowdma0);
+
+/* format is: pnp_reserve_irq=irq1[,irq2] .... */
+
+static int __init pnp_setup_reserve_irq(char *str)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		if (get_option(&str,&pnp_reserve_irq[i]) != 2)
+			break;
+	return 1;
+}
+
+__setup("pnp_reserve_irq=", pnp_setup_reserve_irq);
+
+/* format is: isapnp_reserve_dma=dma1[,dma2] .... */
+
+static int __init pnp_setup_reserve_dma(char *str)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		if (get_option(&str,&pnp_reserve_dma[i]) != 2)
+			break;
+	return 1;
+}
+
+__setup("pnp_reserve_dma=", pnp_setup_reserve_dma);
+
+/* format is: isapnp_reserve_io=io1,size1[,io2,size2] .... */
+
+static int __init pnp_setup_reserve_io(char *str)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		if (get_option(&str,&pnp_reserve_io[i]) != 2)
+			break;
+	return 1;
+}
+
+__setup("pnp_reserve_io=", pnp_setup_reserve_io);
+
+/* format is: isapnp_reserve_mem=mem1,size1[,mem2,size2] .... */
+
+static int __init pnp_setup_reserve_mem(char *str)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		if (get_option(&str,&pnp_reserve_mem[i]) != 2)
+			break;
+	return 1;
+}
+
+__setup("pnp_reserve_mem=", pnp_setup_reserve_mem);
diff -ur --new-file --exclude *.flags a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/system.c	Sat Oct 12 12:04:42 2002
@@ -0,0 +1,123 @@
+/*
+ * system.c - a driver for reserving pnp system resources
+ *
+ * Some code is based on pnpbios_core.c
+ * Copyright 2002 Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+#include <linux/pnp.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+
+static const struct pnp_id pnp_card_table[] = {
+	{	"ANYDEVS",		0	},
+	{	"",			0	}
+};
+
+static const struct pnp_id pnp_dev_table[] = {
+	/* General ID for reserving resources */
+	{	"PNP0c02",		0	},
+	/* memory controller */
+	{	"PNP0c01",		0	},
+	{	"",			0	}
+};
+
+static void __init reserve_ioport_range(char *pnpid, int start, int end)
+{
+	struct resource *res;
+	char *regionid;
+
+	regionid = kmalloc(16, GFP_KERNEL);
+	if ( regionid == NULL )
+		return;
+	snprintf(regionid, 16, "pnp %s", pnpid);
+	res = request_region(start,end-start+1,regionid);
+	if ( res == NULL )
+		kfree( regionid );
+	else
+		res->flags &= ~IORESOURCE_BUSY;
+	/*
+	 * Failures at this point are usually harmless. pci quirks for
+	 * example do reserve stuff they know about too, so we may well
+	 * have double reservations.
+	 */
+	printk(KERN_INFO
+		"pnp: %s: ioport range 0x%x-0x%x %s reserved\n",
+		pnpid, start, end,
+		NULL != res ? "has been" : "could not be"
+	);
+
+	return;
+}
+
+static void __init reserve_resources_of_dev( struct pnp_dev *dev )
+{
+	int i;
+
+	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
+		if ( dev->resource[i].flags & IORESOURCE_UNSET )
+			/* end of resources */
+			break;
+		if (dev->resource[i].flags & IORESOURCE_IO) {
+			/* ioport */
+			if ( dev->resource[i].start == 0 )
+				/* disabled */
+				/* Do nothing */
+				continue;
+			if ( dev->resource[i].start < 0x100 )
+				/*
+				 * Below 0x100 is only standard PC hardware
+				 * (pics, kbd, timer, dma, ...)
+				 * We should not get resource conflicts there,
+				 * and the kernel reserves these anyway
+				 * (see arch/i386/kernel/setup.c).
+				 * So, do nothing
+				 */
+				continue;
+			if ( dev->resource[i].end < dev->resource[i].start )
+				/* invalid endpoint */
+				/* Do nothing */
+				continue;
+			reserve_ioport_range(
+				dev->dev.bus_id,
+				dev->resource[i].start,
+				dev->resource[i].end
+			);
+		} else if (dev->resource[i].flags & IORESOURCE_MEM) {
+			/* iomem */
+			/* For now do nothing */
+			continue;
+		} else {
+			/* Neither ioport nor iomem */
+			/* Do nothing */
+			continue;
+		}
+	}
+
+	return;
+}
+
+static int system_pnp_probe(struct pnp_dev * dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
+{
+	reserve_resources_of_dev(dev);
+	return 0;
+}
+
+static struct pnp_driver system_pnp_driver = {
+	.name		= "system",
+	.card_id_table	= pnp_card_table,
+	.id_table	= pnp_dev_table,
+	.probe		= system_pnp_probe,
+	.remove		= NULL,
+};
+
+static int __init pnp_system_init(void)
+{
+	return pnp_register_driver(&system_pnp_driver);
+}
+
+core_initcall(pnp_system_init);
diff -ur --new-file --exclude *.flags a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
--- a/drivers/serial/8250_pnp.c	Tue Oct 15 17:31:32 2002
+++ b/drivers/serial/8250_pnp.c	Tue Oct  8 17:18:30 2002
@@ -7,6 +7,8 @@
  *
  *  Copyright (C) 2001 Russell King, All Rights Reserved.
  *
+ *  Ported to the Linux PnP Layer - (C) Adam Belay.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License.
@@ -16,7 +18,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/serial.h>
@@ -28,13 +30,15 @@
 
 #include "8250.h"
 
-struct pnpbios_device_id
-{
-	char id[8];
-	unsigned long driver_data;
+#define UNKNOWN_DEV 0x3000
+
+
+static const struct pnp_id pnp_card_table[] = {
+	{	"ANYDEVS",		0	},
+	{	"",			0	}
 };
 
-static const struct pnpbios_device_id pnp_dev_table[] = {
+static const struct pnp_id pnp_dev_table[] = {
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
 	{	"AAC000F",		0	},
@@ -43,6 +47,8 @@
 	{	"ADC0001",		0	},
 	/* SXPro 288 External Data Fax Modem Plug & Play */
 	{	"ADC0002",		0	},
+	/* Actiontec ISA PNP 56K X2 Fax Modem */
+	{	"AEI1240",		0	},
 	/* Rockwell 56K ACF II Fax+Data+Voice Modem */
 	{	"AKY1021",		SPCI_FL_NO_SHIRQ	},
 	/* AZT3005 PnP SOUND DEVICE */
@@ -303,18 +309,22 @@
 	{	"USR9180",		0	},
 	/* U.S. Robotics 56K Voice INT PnP*/
 	{	"USR9190",		0	},
+	/* Unkown PnP modems */
+	{	"PNPCXXX",		UNKNOWN_DEV	},
+	/* More unkown PnP modems */
+	{	"PNPDXXX",		UNKNOWN_DEV	},
 	{	"",			0	}
 };
 
-static void inline avoid_irq_share(struct pci_dev *dev)
+static void inline avoid_irq_share(struct pnp_dev *dev)
 {
 	unsigned int map = 0x1FF8;
-	struct isapnp_irq *irq;
-	struct isapnp_resources *res = dev->sysdata;
+	struct pnp_irq *irq;
+	struct pnp_resources *res = dev->res;
 
 	serial8250_get_irq_map(&map);
 
-	for ( ; res; res = res->alt)
+	for ( ; res; res = res->dep)
 		for (irq = res->irq; irq; irq = irq->next)
 			irq->map = map;
 }
@@ -337,43 +347,30 @@
 	return 0;
 }
 
-static int inline check_compatible_id(struct pci_dev *dev)
-{
-	int i;
-	for (i = 0; i < DEVICE_COUNT_COMPATIBLE; i++)
-		if ((dev->vendor_compatible[i] ==
-		     ISAPNP_VENDOR('P', 'N', 'P')) &&
-		    (swab16(dev->device_compatible[i]) >= 0xc000) &&
-		    (swab16(dev->device_compatible[i]) <= 0xdfff))
-			return 0;
-	return 1;
-}
-
 /*
- * Given a complete unknown ISA PnP device, try to use some heuristics to
+ * Given a complete unknown PnP device, try to use some heuristics to
  * detect modems. Currently use such heuristic set:
  *     - dev->name or dev->bus->name must contain "modem" substring;
  *     - device must have only one IO region (8 byte long) with base adress
  *       0x2e8, 0x3e8, 0x2f8 or 0x3f8.
  *
  * Such detection looks very ugly, but can detect at least some of numerous
- * ISA PnP modems, alternatively we must hardcode all modems in pnp_devices[]
+ * PnP modems, alternatively we must hardcode all modems in pnp_devices[]
  * table.
  */
-static int serial_pnp_guess_board(struct pci_dev *dev, int *flags)
+static int serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
 {
-	struct isapnp_resources *res = (struct isapnp_resources *)dev->sysdata;
-	struct isapnp_resources *resa;
+	struct pnp_resources *res = dev->res;
+	struct pnp_resources *resa;
 
-	if (!(check_name(dev->name) || check_name(dev->bus->name)) &&
-	    !(check_compatible_id(dev)))
+	if (!(check_name(dev->name) || check_name(dev->card->name)))
 		return -ENODEV;
 
-	if (!res || res->next)
+	if (!res)
 		return -ENODEV;
 
-	for (resa = res->alt; resa; resa = resa->alt) {
-		struct isapnp_port *port;
+	for (resa = res->dep; resa; resa = resa->dep) {
+		struct pnp_port *port;
 		for (port = res->port; port; port = port->next)
 			if ((port->size == 8) &&
 			    ((port->min == 0x2f8) ||
@@ -387,42 +384,19 @@
 }
 
 static int
-pnp_init_one(struct pci_dev *dev, const struct pnpbios_device_id *ent,
-	     char *slot_name)
+serial_pnp_probe(struct pnp_dev * dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
 {
 	struct serial_struct serial_req;
-	int ret, line, flags = ent ? ent->driver_data : 0;
-
-	if (!ent) {
+	int ret, line, flags = dev_id->driver_data;
+	if (flags & UNKNOWN_DEV)
 		ret = serial_pnp_guess_board(dev, &flags);
-		if (ret)
-			return ret;
-	}
-
-	if (dev->prepare(dev) < 0) {
-		printk("serial: PNP device '%s' prepare failed\n",
-			slot_name);
-		return -ENODEV;
-	}
-
-	if (dev->active)
-		return -ENODEV;
-
 	if (flags & SPCI_FL_NO_SHIRQ)
 		avoid_irq_share(dev);
-
-	if (dev->activate(dev) < 0) {
-		printk("serial: PNP device '%s' activate failed\n",
-			slot_name);
-		return -ENODEV;
-	}
-
 	memset(&serial_req, 0, sizeof(serial_req));
 	serial_req.irq = dev->irq_resource[0].start;
 	serial_req.port = pci_resource_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = pci_resource_start(dev, 0) >> HIGH_BITS_OFFSET;
-
+		serial_req.port = dev->resource[0].start >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);
@@ -432,110 +406,33 @@
 	serial_req.baud_base = 115200;
 	line = register_serial(&serial_req);
 
-	if (line >= 0) {
-		pci_set_drvdata(dev, (void *)(line + 1));
-
-		/*
-		 * Public health warning: remove this once the 2.5
-		 * pnpbios_module_init() stuff is incorporated.
-		 */
-		dev->driver = (void *)pnp_dev_table;
-	} else
-		dev->deactivate(dev);
-
+	if (line >= 0)
+		dev->driver_data = (void *)(line + 1);
 	return line >= 0 ? 0 : -ENODEV;
-}
-
-static void pnp_remove_one(struct pci_dev *dev)
-{
-	int line = (int)pci_get_drvdata(dev);
-
-	if (line) {
-		pci_set_drvdata(dev, NULL);
 
-		unregister_serial(line - 1);
-
-		dev->deactivate(dev);
-	}
 }
 
-static char hex[] = "0123456789ABCDEF";
-
-/*
- * This function should vanish when 2.5 comes around and
- * we have pnpbios_module_init()
- */
-static int pnp_init(void)
+static void serial_pnp_remove(struct pnp_dev * dev)
 {
-	const struct pnpbios_device_id *id;
-	struct pci_dev *dev = NULL;
-	int nr = 0, rc = -ENODEV;
-
-#ifdef SERIAL_DEBUG_PNP
-	printk("Entered probe_serial_pnp()\n");
-#endif
-
-	isapnp_for_each_dev(dev) {
-		char slot_name[8];
-		u32 pnpid;
-
-		if (dev->active)
-			continue;
-
-		pnpid = dev->vendor << 16 | dev->device;
-		pnpid = cpu_to_le32(pnpid);
-
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
-		slot_name[0] = CHAR(pnpid, 26);
-		slot_name[1] = CHAR(pnpid, 21);
-		slot_name[2] = CHAR(pnpid, 16);
-		slot_name[3] = HEX(pnpid, 12);
-		slot_name[4] = HEX(pnpid, 8);
-		slot_name[5] = HEX(pnpid, 4);
-		slot_name[6] = HEX(pnpid, 0);
-		slot_name[7] = '\0';
-		
-		for (id = pnp_dev_table; id->id[0]; id++)
-			if (memcmp(id->id, slot_name, 7) == 0)
-				break;
-
-		if (id->id[0])
-			rc = pnp_init_one(dev, id, slot_name);
-		else
-			rc = pnp_init_one(dev, NULL, slot_name);
-
-		if (rc == 0)
-			nr++;
-	}
-
-#ifdef SERIAL_DEBUG_PNP
-	printk("Leaving probe_serial_pnp() (probe finished)\n");
-#endif
-
-	return nr == 0 ? rc : 0;
+	return;
 }
 
+static struct pnp_driver serial_pnp_driver = {
+	.name		= "serial",
+	.card_id_table	= pnp_card_table,
+	.id_table	= pnp_dev_table,
+	.probe		= serial_pnp_probe,
+	.remove		= serial_pnp_remove,
+};
+
 static int __init serial8250_pnp_init(void)
 {
-	if (!isapnp_present()) {
-#ifdef SERIAL_DEBUG_PNP
-		printk("Leaving probe_serial_pnp() (no isapnp)\n");
-#endif
-		return -ENODEV;
-	}
-	return pnp_init();
+	return pnp_register_driver(&serial_pnp_driver);
 }
 
 static void __exit serial8250_pnp_exit(void)
 {
-	struct pci_dev *dev = NULL;
-
-	isapnp_for_each_dev(dev) {
-		if (dev->driver != (void *)pnp_dev_table)
-			continue;
-		pnp_remove_one(dev);
-	}
+	/* FIXME */
 }
 
 module_init(serial8250_pnp_init);
@@ -544,5 +441,6 @@
 EXPORT_NO_SYMBOLS;
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic 8250/16x50 PNPBIOS serial probe module");
-MODULE_DEVICE_TABLE(pnpbios, pnp_dev_table);
+MODULE_DESCRIPTION("Generic 8250/16x50 PnP serial driver");
+/* FIXME */
+/*MODULE_DEVICE_TABLE(pnpbios, pnp_dev_table);*/
diff -ur --new-file --exclude *.flags a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	Tue Oct 15 17:31:32 2002
+++ b/drivers/serial/Makefile	Tue Oct  8 17:18:30 2002
@@ -8,7 +8,7 @@
 
 serial-8250-y :=
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
-serial-8250-$(CONFIG_ISAPNP) += 8250_pnp.o
+serial-8250-$(CONFIG_PNP) += 8250_pnp.o
 obj-$(CONFIG_SERIAL_CORE) += core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
diff -ur --new-file --exclude *.flags a/include/linux/isapnp.h b/include/linux/isapnp.h
--- a/include/linux/isapnp.h	Tue Oct 15 17:31:32 2002
+++ b/include/linux/isapnp.h	Tue Oct 15 15:11:41 2002
@@ -190,40 +190,49 @@
 void isapnp_deactivate(unsigned char device);
 void isapnp_fixup_device(struct pci_dev *dev);
 void *isapnp_alloc(long size);
+
+#ifdef CONFIG_PROC_FS
 int isapnp_proc_init(void);
 int isapnp_proc_done(void);
-/* manager */
-struct pci_bus *isapnp_find_card(unsigned short vendor,
-				 unsigned short device,
-				 struct pci_bus *from);
-struct pci_dev *isapnp_find_dev(struct pci_bus *card,
-				unsigned short vendor,
-				unsigned short function,
-				struct pci_dev *from);
-int isapnp_probe_cards(const struct isapnp_card_id *ids,
-		       int (*probe)(struct pci_bus *card,
-				    const struct isapnp_card_id *id));
-int isapnp_probe_devs(const struct isapnp_device_id *ids,
-			int (*probe)(struct pci_dev *dev,
-				     const struct isapnp_device_id *id));
+#else
+static inline isapnp_proc_init(void) { return 0; }
+static inline isapnp_proc_done(void) { return 0; )
+#endif
+
 /* misc */
 void isapnp_resource_change(struct resource *resource,
 			    unsigned long start,
 			    unsigned long size);
-int isapnp_activate_dev(struct pci_dev *dev, const char *name);
 /* init/main.c */
 int isapnp_init(void);
+/* manager */
+static inline struct pci_bus *isapnp_find_card(unsigned short vendor,
+					       unsigned short device,
+					       struct pci_bus *from) { return NULL; }
+static inline struct pci_dev *isapnp_find_dev(struct pci_bus *card,
+					      unsigned short vendor,
+					      unsigned short function,
+					      struct pci_dev *from) { return NULL; }
+static inline int isapnp_probe_cards(const struct isapnp_card_id *ids,
+				     int (*probe)(struct pci_bus *card,
+						  const struct isapnp_card_id *id)) { return -ENODEV; }
+static inline int isapnp_probe_devs(const struct isapnp_device_id *ids,
+				    int (*probe)(struct pci_dev *dev,
+						 const struct isapnp_device_id *id)) { return -ENODEV; }
+static inline int isapnp_activate_dev(struct pci_dev *dev, const char *name) { return -ENODEV; }
+
+static inline int isapnp_register_driver(struct isapnp_driver *drv) { return 0; }
+
+static inline void isapnp_unregister_driver(struct isapnp_driver *drv) { }
 
 extern struct list_head isapnp_cards;
 extern struct list_head isapnp_devices;
+extern struct pnp_protocol isapnp_protocol;
 
 #define isapnp_for_each_card(card) \
-	for(card = pci_bus_b(isapnp_cards.next); card != pci_bus_b(&isapnp_cards); card = pci_bus_b(card->node.next))
+	for(card = to_pnp_card(isapnp_cards.next); card != to_pnp_card(&isapnp_cards); card = to_pnp_card(card->node.next))
 #define isapnp_for_each_dev(dev) \
-	for(dev = pci_dev_g(isapnp_devices.next); dev != pci_dev_g(&isapnp_devices); dev = pci_dev_g(dev->global_list.next))
-
-int isapnp_register_driver(struct isapnp_driver *drv);
-void isapnp_unregister_driver(struct isapnp_driver *drv);
+	for(dev = protocol_to_pnp_dev(isapnp_protocol.devices.next); dev != protocol_to_pnp_dev(&isapnp_protocol.devices); dev = protocol_to_pnp_dev(dev->dev_list.next))
 
 #else /* !CONFIG_ISAPNP */
 
diff -ur --new-file --exclude *.flags a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Thu Jan  1 00:00:00 1970
+++ b/include/linux/pnp.h	Tue Oct 15 16:14:54 2002
@@ -0,0 +1,282 @@
+#ifndef _LINUX_PNP_H
+#define _LINUX_PNP_H
+
+#ifdef __KERNEL__
+
+#include <linux/device.h>
+#include <linux/list.h>
+
+
+/* Device Managemnt */
+
+#define DEVICE_COUNT_IRQ	2
+#define DEVICE_COUNT_DMA	2
+#define DEVICE_COUNT_RESOURCE	12
+
+struct pnp_resource;
+struct pnp_protocol;
+
+struct pnp_card {			/* this is for ISAPNP */ 
+	struct list_head node;		/* node in list of cards */
+	char name[80];
+	unsigned char number;		/* card number */
+	struct list_head ids;		/* stores all supported dev ids */
+	struct list_head devices;	/* devices attached to the card */
+	unsigned char	pnpver;		/* Plug & Play version */
+	unsigned char	productver;	/* product version */
+	unsigned int	serial;		/* serial number */
+	unsigned char	checksum;	/* if zero - checksum passed */
+	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/isapnp */
+};
+
+#define to_pnp_card(n) list_entry(n, struct pnp_card, node)
+
+struct pnp_dev {
+	char name[80];			/* device name */
+	int active;			/* status of the device */
+	int ro;				/* read only */
+	struct list_head dev_list;	/* node in list of device's protocol */
+	struct list_head global_list;
+	struct list_head card_list;
+	struct pnp_protocol * protocol;
+	struct pnp_card *card;
+
+	unsigned char number;		/* must be unique */
+	unsigned short	regs;		/* ISAPnP: supported registers */
+	struct list_head ids;		/* stores all supported dev ids */
+	struct pnp_resources *res;	/* possible resource information */
+	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	struct resource dma_resource[DEVICE_COUNT_DMA];
+	struct resource irq_resource[DEVICE_COUNT_IRQ];
+
+	struct pnp_driver * driver;	/* which driver has allocated this device */
+	struct	device	    dev;	/* Driver Model device interface */
+	void  		  * driver_data;/* data private to the driver */
+	void		  * protocol_data;
+	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
+};
+
+#define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
+#define card_to_pnp_dev(n) list_entry(n, struct pnp_dev, card_list)
+#define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, dev_list)
+#define	to_pnp_dev(n) container_of(n, struct pnp_dev, dev)
+#define pnp_for_each_dev(dev) \
+	for(dev = global_to_pnp_dev(pnp_global.next); \
+	dev != global_to_pnp_dev(&pnp_global); \
+	dev = global_to_pnp_dev(dev->global_list.next))
+
+struct pnp_fixup {
+	char id[7];
+	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
+};
+
+/*
+ * Linux Plug and Play Support
+ * Copyright by Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
+ *
+ */
+
+/* Driver Management */
+
+struct pnp_id {
+	char id[7];
+	unsigned long driver_data;	/* data private to the driver */
+	struct list_head id_list;	/* node in card's or device's list */
+};
+
+#define to_pnp_id(n) list_entry(n, struct pnp_id, id_list)
+
+struct pnp_driver {
+	struct list_head node;
+	char *name;
+	const struct pnp_id *card_id_table;
+	const struct pnp_id *id_table;
+	int  (*probe)  (struct pnp_dev *dev, const struct pnp_id *card_id,
+		 	const struct pnp_id *dev_id);
+	void (*remove) (struct pnp_dev *dev);
+	struct device * (*legacy) (void);
+	struct device_driver	driver;
+};
+
+#define	to_pnp_driver(drv) container_of(drv,struct pnp_driver, driver)
+
+
+/* Resource Management */
+
+#define DEV_IO(dev, index) (dev->resource[index].start)
+#define DEV_MEM(dev, index) (dev->resource[index+8].start)
+#define DEV_IRQ(dev, index) (dev->irq_resource[index].start)
+#define DEV_DMA(dev, index) (dev->dma_resource[index].start)
+
+#define PNP_PORT_FLAG_16BITADDR	(1<<0)
+#define PNP_PORT_FLAG_FIXED		(1<<1)
+
+struct pnp_port {
+	unsigned short min;		/* min base number */
+	unsigned short max;		/* max base number */
+	unsigned char align;		/* align boundary */
+	unsigned char size;		/* size of range */
+	unsigned char flags;		/* port flags */
+	unsigned char pad;		/* pad */
+	struct pnp_resources *res;	/* parent */
+	struct pnp_port *next;		/* next port */
+};
+
+struct pnp_irq {
+	unsigned short map;		/* bitmaks for IRQ lines */
+	unsigned char flags;		/* IRQ flags */
+	unsigned char pad;		/* pad */
+	struct pnp_resources *res;	/* parent */
+	struct pnp_irq *next;		/* next IRQ */
+};
+
+struct pnp_dma {
+	unsigned char map;		/* bitmask for DMA channels */
+	unsigned char flags;		/* DMA flags */
+	struct pnp_resources *res;	/* parent */
+	struct pnp_dma *next;		/* next port */
+};
+
+struct pnp_mem {
+	unsigned int min;		/* min base number */
+	unsigned int max;		/* max base number */
+	unsigned int align;		/* align boundary */
+	unsigned int size;		/* size of range */
+	unsigned char flags;		/* memory flags */
+	unsigned char pad;		/* pad */
+	struct pnp_resources *res;	/* parent */
+	struct pnp_mem *next;		/* next memory resource */
+};
+
+struct pnp_mem32 {
+	unsigned char data[17];
+	struct pnp_resources *res;	/* parent */
+	struct pnp_mem32 *next;		/* next 32-bit memory resource */
+};
+
+#define PNP_RES_PRIORITY_PREFERRED	0
+#define PNP_RES_PRIORITY_ACCEPTABLE	1
+#define PNP_RES_PRIORITY_FUNCTIONAL	2
+#define PNP_RES_PRIORITY_INVALID	65535
+
+struct pnp_resources {
+	unsigned short priority;	/* priority */
+	unsigned short dependent;	/* dependent resources */
+	struct pnp_port *port;		/* first port */
+	struct pnp_irq *irq;		/* first IRQ */
+	struct pnp_dma *dma;		/* first DMA */
+	struct pnp_mem *mem;		/* first memory resource */
+	struct pnp_mem32 *mem32;	/* first 32-bit memory */
+	struct pnp_dev *dev;		/* parent */
+	struct pnp_resources *dep;	/* dependent resources */
+};
+
+#define PNP_DYNAMIC		0	/* get or set current resource */
+#define PNP_STATIC		1	/* get or set resource for next boot */
+
+struct pnp_cfg {
+	struct pnp_port *port[8];
+	struct pnp_irq *irq[2];
+	struct pnp_dma *dma[2];
+	struct pnp_mem *mem[4];
+	struct pnp_dev request;
+};
+
+
+/* Protocol Management */
+
+struct pnp_protocol {
+	struct list_head	protocol_list;
+	char			name[DEVICE_NAME_SIZE];
+
+	/* functions */
+	int (*get)(struct pnp_dev *dev);
+	int (*set)(struct pnp_dev *dev, struct pnp_cfg *config, char flags);
+	int (*disable)(struct pnp_dev *dev);
+
+	/* used by pnp layer only (look but don't touch) */
+	unsigned char		number;		/* protocol number*/
+	struct device		dev;		/* link to driver model */
+
+	struct list_head	devices;
+};
+
+#define to_pnp_protocol(n) list_entry(n, struct pnp_protocol, protocol_list)
+
+
+#if defined(CONFIG_PNP)
+
+/* core */
+int pnp_protocol_register(struct pnp_protocol *protocol);
+int pnp_init_device(struct pnp_dev *dev);
+int pnp_add_device(struct pnp_dev *dev);
+extern struct list_head pnp_global;
+
+/* resource */
+struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent);
+struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum);
+int pnp_get_max_depnum(struct pnp_dev *dev);
+int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data);
+int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_dma *data);
+int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_port *data);
+int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_mem *data);
+int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_mem32 *data);
+int pnp_activate_dev(struct pnp_dev *dev);
+int pnp_disable_dev(struct pnp_dev *dev);
+int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode);
+
+/* driver */
+int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
+int pnp_register_driver(struct pnp_driver *drv);
+void pnp_unregister_driver(struct pnp_driver *drv);
+
+/* compat */
+struct pnp_card *pnp_find_card(unsigned short vendor,
+				 unsigned short device,
+				 struct pnp_card *from);
+struct pnp_dev *pnp_find_dev(struct pnp_card *card,
+				unsigned short vendor,
+				unsigned short function,
+				struct pnp_dev *from);
+
+
+#else
+
+/* just in case anyone decides to call these without PnP Support Enabled */
+static inline int pnp_protocol_register(struct pnp_protocol *protocol) { return -ENODEV; }
+static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
+static inline struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent) { return NULL; }
+static inline struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum) { return NULL; }
+static inline int pnp_get_max_depnum(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
+static inline int pnp_add_dma_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
+static inline int pnp_add_port_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
+static inline int pnp_add_mem_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
+static inline int pnp_add_mem32_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data) { return -ENODEV; }
+static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode) { return -ENODEV; }
+static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
+static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
+static inline struct pnp_card *pnp_find_card(unsigned short vendor,
+				 unsigned short device,
+				 struct pnp_card *from) { return NULL; }
+static inline struct pnp_dev *pnp_find_dev(struct pnp_card *card,
+				unsigned short vendor,
+				unsigned short function,
+				struct pnp_dev *from) { return NULL; }
+
+#endif /* CONFIG_PNP */
+
+
+#ifdef DEBUG
+#define pnp_dbg(format, arg...) printk(KERN_DEBUG "pnp: " format "\n" , ## arg)
+#else
+#define pnp_dbg(format, arg...) do {} while (0)
+#endif
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_PNP_H */
diff -ur --new-file --exclude *.flags a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Tue Oct 15 17:31:32 2002
+++ b/include/linux/pnpbios.h	Fri Oct 11 23:00:25 2002
@@ -108,38 +108,9 @@
 };
 #pragma pack()
 
-struct pnpbios_device_id
-{
-	char id[8];
-	unsigned long driver_data;
-};
-
-struct pnpbios_driver {
-	struct list_head node;
-	char *name;
-	const struct pnpbios_device_id *id_table;	/* NULL if wants all devices */
-	int  (*probe)  (struct pci_dev *dev, const struct pnpbios_device_id *id);	/* New device inserted */
-	void (*remove) (struct pci_dev *dev);		/* Device removed, either due to hotplug remove or module remove */
-};
-
 #ifdef CONFIG_PNPBIOS
 
-/* exported */
-extern int  pnpbios_register_driver(struct pnpbios_driver *drv);
-extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
-
 /* non-exported */
-#define pnpbios_for_each_dev(dev) \
-	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
-
-
-#define pnpbios_dev_g(n) list_entry(n, struct pci_dev, global_list)
-
-static __inline struct pnpbios_driver *pnpbios_dev_driver(const struct pci_dev *dev)
-{
-	return (struct pnpbios_driver *)dev->driver;
-}
-
 extern int  pnpbios_dont_use_current_config;
 extern void *pnpbios_kmalloc(size_t size, int f);
 extern int pnpbios_init (void);
@@ -161,52 +132,8 @@
 extern int pnp_bios_write_escd (char *data, u32 nvram_base);
 #endif
 
-/*
- * a helper function which helps ensure correct pnpbios_driver
- * setup and cleanup for commonly-encountered hotplug/modular cases
- *
- * This MUST stay in a header, as it checks for -DMODULE
- */
- 
-static inline int pnpbios_module_init(struct pnpbios_driver *drv)
-{
-	int rc = pnpbios_register_driver (drv);
-
-	if (rc > 0)
-		return 0;
-
-	/* iff CONFIG_HOTPLUG and built into kernel, we should
-	 * leave the driver around for future hotplug events.
-	 * For the module case, a hotplug daemon of some sort
-	 * should load a module in response to an insert event. */
-#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
-	if (rc == 0)
-		return 0;
-#else
-	if (rc == 0)
-		rc = -ENODEV;		
-#endif
-
-	/* if we get here, we need to clean up pci driver instance
-	 * and return some sort of error */
-	pnpbios_unregister_driver (drv);
-	
-	return rc;
-}
-
-#else /* CONFIG_PNPBIOS */
-
-static __inline__ int pnpbios_register_driver(struct pnpbios_driver *drv)
-{
-	return 0;
-}
-
-static __inline__ void pnpbios_unregister_driver(struct pnpbios_driver *drv)
-{
-	return;
-}
-
 #endif /* CONFIG_PNPBIOS */
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PNPBIOS_H */
diff -ur --new-file --exclude *.flags a/sound/oss/ad1848.c b/sound/oss/ad1848.c
--- a/sound/oss/ad1848.c	Tue Oct 15 17:31:32 2002
+++ b/sound/oss/ad1848.c	Tue Oct 15 17:18:56 2002
@@ -47,6 +47,7 @@
 #include <linux/stddef.h>
 #include <linux/pm.h>
 #include <linux/isapnp.h>
+#include <linux/pnp.h>
 #include <linux/spinlock.h>
 
 #define DEB(x)
@@ -58,7 +59,7 @@
 
 typedef struct
 {
-	spinlock_t		lock;
+	spinlock_t	lock;
 	int             base;
 	int             irq;
 	int             dma1, dma2;
@@ -176,7 +177,7 @@
     ,{CAP_F_TIMER} /* MD_1845_SSCAPE */
 };
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static int isapnp	= 1;
 static int isapnpjump	= 0;
 static int reverse	= 0;
@@ -2920,7 +2921,7 @@
 MODULE_PARM(deskpro_m, "i");            /* Special magic for Deskpro M box */
 MODULE_PARM(soundpro, "i");             /* More special magic for SoundPro chips */
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 MODULE_PARM(isapnp,	"i");
 MODULE_PARM(isapnpjump,	"i");
 MODULE_PARM(reverse,	"i");
@@ -2928,7 +2929,7 @@
 MODULE_PARM_DESC(isapnpjump,	"Jumps to a specific slot in the driver's PnP table. Use the source, Luke.");
 MODULE_PARM_DESC(reverse,	"When set to 1, will reverse ISAPnP search order");
 
-struct pci_dev	*ad1848_dev  = NULL;
+struct pnp_dev	*ad1848_dev  = NULL;
 
 /* Please add new entries at the end of the table */
 static struct {
@@ -2977,7 +2978,7 @@
 
 MODULE_DEVICE_TABLE(isapnp, id_table);
 
-static struct pci_dev *activate_dev(char *devname, char *resname, struct pci_dev *dev)
+static struct pnp_dev *activate_dev(char *devname, char *resname, struct pnp_dev *dev)
 {
 	int err;
 
@@ -2985,33 +2986,23 @@
 	if(dev->active)
 		return(dev);
 
-	if((err = dev->activate(dev)) < 0) {
+	if((err = pnp_activate_dev(dev)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
 
-		dev->deactivate(dev);
+		pnp_disable_dev(dev);
 
 		return(NULL);
 	}
+	audio_activated = 1;
 	return(dev);
 }
 
-static struct pci_dev *ad1848_init_generic(struct pci_bus *bus, struct address_info *hw_config, int slot)
+static struct pnp_dev *ad1848_init_generic(struct pnp_card *bus, struct address_info *hw_config, int slot)
 {
 
 	/* Configure Audio device */
-	if((ad1848_dev = isapnp_find_dev(bus, ad1848_isapnp_list[slot].vendor, ad1848_isapnp_list[slot].function, NULL)))
+	if((ad1848_dev = pnp_find_dev(bus, ad1848_isapnp_list[slot].vendor, ad1848_isapnp_list[slot].function, NULL)))
 	{
-		int ret;
-		ret = ad1848_dev->prepare(ad1848_dev);
-		/* If device is active, assume configured with /proc/isapnp
-		 * and use anyway. Some other way to check this? */
-		if(ret && ret != -EBUSY) {
-			printk(KERN_ERR "ad1848: ISAPnP found device that could not be autoconfigured.\n");
-			return(NULL);
-		}
-		if(ret == -EBUSY)
-			audio_activated = 1;
-
 		if((ad1848_dev = activate_dev(ad1848_isapnp_list[slot].name, "ad1848", ad1848_dev)))
 		{
 			hw_config->io_base 	= ad1848_dev->resource[ad1848_isapnp_list[slot].mss_io].start;
@@ -3030,7 +3021,7 @@
 	return(ad1848_dev);
 }
 
-static int __init ad1848_isapnp_init(struct address_info *hw_config, struct pci_bus *bus, int slot)
+static int __init ad1848_isapnp_init(struct address_info *hw_config, struct pnp_card *bus, int slot)
 {
 	char *busname = bus->name[0] ? bus->name : ad1848_isapnp_list[slot].name;
 
@@ -3072,9 +3063,9 @@
 		i = isapnpjump;
 	first = 0;
 	while(ad1848_isapnp_list[i].card_vendor != 0) {
-		static struct pci_bus *bus = NULL;
+		static struct pnp_card *bus = NULL;
 
-		while ((bus = isapnp_find_card(
+		while ((bus = pnp_find_card(
 				ad1848_isapnp_list[i].card_vendor,
 				ad1848_isapnp_list[i].card_device,
 				bus))) {
@@ -3096,7 +3087,7 @@
 {
 	printk(KERN_INFO "ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996\n");
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if(isapnp && (ad1848_isapnp_probe(&cfg) < 0) ) {
 		printk(KERN_NOTICE "ad1848: No ISAPnP cards found, trying standard ones...\n");
 		isapnp = 0;
@@ -3131,10 +3122,10 @@
 	if(loaded)
 		unload_ms_sound(&cfg);
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if(audio_activated)
 		if(ad1848_dev)
-			ad1848_dev->deactivate(ad1848_dev);
+			pnp_disable_dev(ad1848_dev);
 #endif
 }
 
@@ -3148,7 +3139,7 @@
 	int ints[6];
 	
 	str = get_options(str, ARRAY_SIZE(ints), ints);
-	
+
 	io	= ints[1];
 	irq	= ints[2];
 	dma	= ints[3];
diff -ur --new-file --exclude *.flags a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
--- a/sound/oss/opl3sa2.c	Tue Oct 15 17:31:32 2002
+++ b/sound/oss/opl3sa2.c	Tue Oct 15 17:08:53 2002
@@ -57,12 +57,13 @@
  *                         (Jan 7, 2001)
  * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
  *
+ * Adam Belay              Converted driver to new PnP Layer (Oct 12, 2002)
  */
 
 #include <linux/config.h>
+#include <linux/pnp.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/isapnp.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include "sound_config.h"
@@ -107,7 +108,7 @@
 #define CHIPSET_OPL3SA2 0
 #define CHIPSET_OPL3SA3 1
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 #define OPL3SA2_CARDS_MAX 4
 #else
 #define OPL3SA2_CARDS_MAX 1
@@ -161,13 +162,13 @@
 static int __initdata ymode	= -1;
 static int __initdata loopback	= -1;
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 /* PnP specific parameters */
 static int __initdata isapnp = 1;
 static int __initdata multiple = 1;
 
 /* PnP devices */
-struct pci_dev* opl3sa2_dev[OPL3SA2_CARDS_MAX];
+struct pnp_dev* opl3sa2_dev[OPL3SA2_CARDS_MAX];
 
 /* Whether said devices have been activated */
 static int opl3sa2_activated[OPL3SA2_CARDS_MAX];
@@ -205,7 +206,7 @@
 MODULE_PARM(loopback, "i");
 MODULE_PARM_DESC(loopback, "Set A/D input source. Useful for echo cancellation (0 = Mic Rch (default), 1 = Mono output loopback)");
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 MODULE_PARM(isapnp, "i");
 MODULE_PARM_DESC(isapnp, "When set to 0, ISA PnP support will be disabled");
 
@@ -834,89 +835,60 @@
 		sound_unload_mixerdev(opl3sa2_mixer[card]);
 }
 
-
-#ifdef __ISAPNP__
-
-struct isapnp_device_id isapnp_opl3sa2_list[] __initdata = {
-	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021),
-		0 },
-	{0}
+#ifdef CONFIG_PNP
+struct pnp_id pnp_opl3sa2_list[] = {
+	{.id = "YMH0021", .driver_data = 0},
+	{.id = ""}
 };
 
-MODULE_DEVICE_TABLE(isapnp, isapnp_opl3sa2_list);
-
-static int __init opl3sa2_isapnp_probe(struct address_info* hw_cfg,
-				       struct address_info* mss_cfg,
-				       struct address_info* mpu_cfg,
-				       int card)
-{
-	static struct pci_dev* dev;
-	int ret;
-
-	/* Find and configure device */
-	dev = isapnp_find_dev(NULL,
-			      ISAPNP_VENDOR('Y','M','H'),
-			      ISAPNP_FUNCTION(0x0021),
-			      dev);
-	if(dev == NULL) {
-		return -ENODEV;
-	}
-
-	/*
-	 * If device is active, assume configured with /proc/isapnp
-	 * and use anyway. Any other way to check this?
-	 */
-	ret = dev->prepare(dev);
-	if(ret && ret != -EBUSY) {
-		printk(KERN_ERR "opl3sa2: ISA PnP found device that could not be autoconfigured.\n");
-		return -ENODEV;
-	}
-	if(ret == -EBUSY) {
-		opl3sa2_activated[card] = 1;
-	}
-	else {
-		if(dev->activate(dev) < 0) {
-			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed\n");
-			opl3sa2_activated[card] = 0;
-			return -ENODEV;
-		}
-
-		printk(KERN_DEBUG
-		       "opl3sa2: Activated ISA PnP card %d (active=%d)\n",
-		       card, dev->active);
+/*MODULE_DEVICE_TABLE(isapnp, isapnp_opl3sa2_list);*/
 
-	}
+static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id,
+			     const struct pnp_id *dev_id)
+{
+	if (opl3sa2_cards_num == OPL3SA2_CARDS_MAX)
+		return 0;
+	int card = opl3sa2_cards_num;
+	opl3sa2_activated[card] = 1;
 
 	/* Our own config: */
-	hw_cfg->io_base = dev->resource[4].start;
-	hw_cfg->irq     = dev->irq_resource[0].start;
-	hw_cfg->dma     = dev->dma_resource[0].start;
-	hw_cfg->dma2    = dev->dma_resource[1].start;
-	
+	cfg[card].io_base = dev->resource[4].start;
+	cfg[card].irq     = dev->irq_resource[0].start;
+	cfg[card].dma     = dev->dma_resource[0].start;
+	cfg[card].dma2    = dev->dma_resource[1].start;
+
 	/* The MSS config: */
-	mss_cfg->io_base      = dev->resource[1].start;
-	mss_cfg->irq          = dev->irq_resource[0].start;
-	mss_cfg->dma          = dev->dma_resource[0].start;
-	mss_cfg->dma2         = dev->dma_resource[1].start;
-	mss_cfg->card_subtype = 1; /* No IRQ or DMA setup */
-
-	mpu_cfg->io_base       = dev->resource[3].start;
-	mpu_cfg->irq           = dev->irq_resource[0].start;
-	mpu_cfg->dma           = -1;
-	mpu_cfg->dma2          = -1;
-	mpu_cfg->always_detect = 1; /* It's there, so use shared IRQs */
+	cfg_mss[card].io_base      = dev->resource[1].start;
+	cfg_mss[card].irq          = dev->irq_resource[0].start;
+	cfg_mss[card].dma          = dev->dma_resource[0].start;
+	cfg_mss[card].dma2         = dev->dma_resource[1].start;
+	cfg_mss[card].card_subtype = 1; /* No IRQ or DMA setup */
+
+	cfg_mpu[card].io_base       = dev->resource[3].start;
+	cfg_mpu[card].irq           = dev->irq_resource[0].start;
+	cfg_mpu[card].dma           = -1;
+	cfg_mpu[card].dma2          = -1;
+	cfg_mpu[card].always_detect = 1; /* It's there, so use shared IRQs */
 
 	/* Call me paranoid: */
-	opl3sa2_clear_slots(hw_cfg);
-	opl3sa2_clear_slots(mss_cfg);
-	opl3sa2_clear_slots(mpu_cfg);
+	opl3sa2_clear_slots(&cfg[card]);
+	opl3sa2_clear_slots(&cfg_mss[card]);
+	opl3sa2_clear_slots(&cfg_mpu[card]);
 
 	opl3sa2_dev[card] = dev;
+	opl3sa2_cards_num++;
 
 	return 0;
 }
-#endif /* __ISAPNP__ */
+
+static struct pnp_driver opl3sa2_driver = {
+	.name		= "opl3sa2",
+	.card_id_table	= NULL,
+	.id_table	= pnp_opl3sa2_list,
+	.probe		= opl3sa2_pnp_probe,
+};
+
+#endif /* CONFIG_PNP */
 
 /* End of component functions */
 
@@ -1003,28 +975,21 @@
 	/* Sanitize isapnp and multiple settings */
 	isapnp = isapnp != 0 ? 1 : 0;
 	multiple = multiple != 0 ? 1 : 0;
-	
+
 	max = (multiple && isapnp) ? OPL3SA2_CARDS_MAX : 1;
-	for(card = 0; card < max; card++, opl3sa2_cards_num++) {
-#ifdef __ISAPNP__
-		/*
-		 * Please remember that even with __ISAPNP__ defined one
-		 * should still be able to disable PNP support for this 
-		 * single driver!
-		 */
-		if(isapnp && opl3sa2_isapnp_probe(&cfg[card],
-						  &cfg_mss[card],
-						  &cfg_mpu[card],
-						  card) < 0) {
-			if(!opl3sa2_cards_num)
-				printk(KERN_INFO "opl3sa2: No PnP cards found\n");
-			if(io == -1)
-				break;
-			isapnp=0;
-			printk(KERN_INFO "opl3sa2: Search for a card at 0x%d.\n", io);
-			/* Fall through */
+
+#ifdef CONFIG_PNP
+	if (isapnp){
+		pnp_register_driver(&opl3sa2_driver);
+		if(!opl3sa2_cards_num){
+			printk(KERN_INFO "opl3sa2: No PnP cards found\n");
+			isapnp = 0;
 		}
+		max = opl3sa2_cards_num;
+	}
 #endif
+
+	for(card = 0; card < max; card++) {
 		/* If a user wants an I/O then assume they meant it */
 		
 		if(!isapnp) {
@@ -1033,6 +998,7 @@
 				printk(KERN_ERR
 				       "opl3sa2: io, mss_io, irq, dma, and dma2 must be set\n");
 				return -EINVAL;
+				opl3sa2_cards_num++;
 			}
 
 			/*
@@ -1145,14 +1111,8 @@
 		unload_opl3sa2_mss(&cfg_mss[card]);
 		unload_opl3sa2(&cfg[card], card);
 
-#ifdef __ISAPNP__
-		if(opl3sa2_activated[card] && opl3sa2_dev[card]) {
-			opl3sa2_dev[card]->deactivate(opl3sa2_dev[card]);
-
-			printk(KERN_DEBUG
-			       "opl3sa2: Deactivated ISA PnP card %d (active=%d)\n",
-			       card, opl3sa2_dev[card]->active);
-		}
+#ifdef CONFIG_PNP
+		pnp_unregister_driver(&opl3sa2_driver);
 #endif
 	}
 }
@@ -1164,7 +1124,7 @@
 static int __init setup_opl3sa2(char *str)
 {
 	/* io, irq, dma, dma2,... */
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	int ints[11];
 #else
 	int ints[9];
@@ -1179,7 +1139,7 @@
 	mpu_io   = ints[6];
 	ymode    = ints[7];
 	loopback = ints[8];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	isapnp   = ints[9];
 	multiple = ints[10];
 #endif

--XOIedfhf+7KOe/yw--


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
