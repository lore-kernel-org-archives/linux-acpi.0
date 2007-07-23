From: helgaas@ldl.fc.hp.com
Subject: [patch 13/17] PNPBIOS: Lindent core.c
Date: Mon, 23 Jul 2007 15:28:10 -0600
Message-ID: <20070723213242.946956748@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:45634 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759178AbXGWVdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:41 -0400
Content-Disposition: inline; filename=pnpbios-format-core
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/pnpbios/core.c
===================================================================
--- work2.orig/drivers/pnp/pnpbios/core.c	2007-07-23 14:57:12.000000000 -0600
+++ work2/drivers/pnp/pnpbios/core.c	2007-07-23 15:00:43.000000000 -0600
@@ -32,7 +32,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
- 
+
 /* Change Log
  *
  * Adam Belay - <ambx1@neo.rr.com> - March 16, 2003
@@ -71,14 +71,13 @@
 
 #include "pnpbios.h"
 
-
 /*
  *
  * PnP BIOS INTERFACE
  *
  */
 
-static union pnp_bios_install_struct * pnp_bios_install = NULL;
+static union pnp_bios_install_struct *pnp_bios_install = NULL;
 
 int pnp_bios_present(void)
 {
@@ -101,36 +100,35 @@
 /*
  * (Much of this belongs in a shared routine somewhere)
  */
- 
 static int pnp_dock_event(int dock, struct pnp_docking_station_info *info)
 {
-	char *argv [3], **envp, *buf, *scratch;
+	char *argv[3], **envp, *buf, *scratch;
 	int i = 0, value;
 
-	if (!current->fs->root) {
+	if (!current->fs->root)
 		return -EAGAIN;
-	}
-	if (!(envp = kcalloc(20, sizeof (char *), GFP_KERNEL))) {
+	if (!(envp = kcalloc(20, sizeof(char *), GFP_KERNEL)))
 		return -ENOMEM;
-	}
 	if (!(buf = kzalloc(256, GFP_KERNEL))) {
-		kfree (envp);
+		kfree(envp);
 		return -ENOMEM;
 	}
 
-	/* FIXME: if there are actual users of this, it should be integrated into
-	 * the driver core and use the usual infrastructure like sysfs and uevents */
-	argv [0] = "/sbin/pnpbios";
-	argv [1] = "dock";
-	argv [2] = NULL;
+	/* FIXME: if there are actual users of this, it should be
+	 * integrated into the driver core and use the usual infrastructure
+	 * like sysfs and uevents
+	 */
+	argv[0] = "/sbin/pnpbios";
+	argv[1] = "dock";
+	argv[2] = NULL;
 
 	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 
 #ifdef	DEBUG
 	/* hint that policy agent should enter no-stdout debug mode */
-	envp [i++] = "DEBUG=kernel";
+	envp[i++] = "DEBUG=kernel";
 #endif
 	/* extensible set of named bus-specific parameters,
 	 * supporting multiple driver selection algorithms.
@@ -138,33 +136,33 @@
 	scratch = buf;
 
 	/* action:  add, remove */
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "ACTION=%s", dock?"add":"remove") + 1;
+	envp[i++] = scratch;
+	scratch += sprintf(scratch, "ACTION=%s", dock ? "add" : "remove") + 1;
 
 	/* Report the ident for the dock */
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DOCK=%x/%x/%x",
-		info->location_id, info->serial, info->capabilities);
+	envp[i++] = scratch;
+	scratch += sprintf(scratch, "DOCK=%x/%x/%x",
+			   info->location_id, info->serial, info->capabilities);
 	envp[i] = NULL;
-	
-	value = call_usermodehelper (argv [0], argv, envp, UMH_WAIT_EXEC);
-	kfree (buf);
-	kfree (envp);
+
+	value = call_usermodehelper(argv [0], argv, envp, UMH_WAIT_EXEC);
+	kfree(buf);
+	kfree(envp);
 	return 0;
 }
 
 /*
  * Poll the PnP docking at regular intervals
  */
-static int pnp_dock_thread(void * unused)
+static int pnp_dock_thread(void *unused)
 {
 	static struct pnp_docking_station_info now;
 	int docked = -1, d = 0;
+
 	set_freezable();
-	while (!unloading)
-	{
+	while (!unloading) {
 		int status;
-		
+
 		/*
 		 * Poll every 2 seconds
 		 */
@@ -175,30 +173,29 @@
 
 		status = pnp_bios_dock_station_info(&now);
 
-		switch(status)
-		{
+		switch (status) {
 			/*
 			 * No dock to manage
 			 */
-			case PNP_FUNCTION_NOT_SUPPORTED:
-				complete_and_exit(&unload_sem, 0);
-			case PNP_SYSTEM_NOT_DOCKED:
-				d = 0;
-				break;
-			case PNP_SUCCESS:
-				d = 1;
-				break;
-			default:
-				pnpbios_print_status( "pnp_dock_thread", status );
-				continue;
+		case PNP_FUNCTION_NOT_SUPPORTED:
+			complete_and_exit(&unload_sem, 0);
+		case PNP_SYSTEM_NOT_DOCKED:
+			d = 0;
+			break;
+		case PNP_SUCCESS:
+			d = 1;
+			break;
+		default:
+			pnpbios_print_status("pnp_dock_thread", status);
+			continue;
 		}
-		if(d != docked)
-		{
-			if(pnp_dock_event(d, &now)==0)
-			{
+		if (d != docked) {
+			if (pnp_dock_event(d, &now) == 0) {
 				docked = d;
 #if 0
-				printk(KERN_INFO "PnPBIOS: Docking station %stached\n", docked?"at":"de");
+				printk(KERN_INFO
+				       "PnPBIOS: Docking station %stached\n",
+				       docked ? "at" : "de");
 #endif
 			}
 		}
@@ -206,21 +203,21 @@
 	complete_and_exit(&unload_sem, 0);
 }
 
-#endif   /* CONFIG_HOTPLUG */
+#endif				/* CONFIG_HOTPLUG */
 
-static int pnpbios_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+static int pnpbios_get_resources(struct pnp_dev *dev,
+				 struct pnp_resource_table *res)
 {
 	u8 nodenum = dev->number;
-	struct pnp_bios_node * node;
+	struct pnp_bios_node *node;
 
-	/* just in case */
-	if(!pnpbios_is_dynamic(dev))
+	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;
 
 	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
+	if (pnp_bios_get_dev_node(&nodenum, (char)PNPMODE_DYNAMIC, node)) {
 		kfree(node);
 		return -ENODEV;
 	}
@@ -230,24 +227,24 @@
 	return 0;
 }
 
-static int pnpbios_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+static int pnpbios_set_resources(struct pnp_dev *dev,
+				 struct pnp_resource_table *res)
 {
 	u8 nodenum = dev->number;
-	struct pnp_bios_node * node;
+	struct pnp_bios_node *node;
 	int ret;
 
-	/* just in case */
 	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;
 
 	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
+	if (pnp_bios_get_dev_node(&nodenum, (char)PNPMODE_DYNAMIC, node)) {
 		kfree(node);
 		return -ENODEV;
 	}
-	if(pnpbios_write_resources_to_node(res, node)<0) {
+	if (pnpbios_write_resources_to_node(res, node) < 0) {
 		kfree(node);
 		return -1;
 	}
@@ -258,18 +255,19 @@
 	return ret;
 }
 
-static void pnpbios_zero_data_stream(struct pnp_bios_node * node)
+static void pnpbios_zero_data_stream(struct pnp_bios_node *node)
 {
-	unsigned char * p = (char *)node->data;
-	unsigned char * end = (char *)(node->data + node->size);
+	unsigned char *p = (char *)node->data;
+	unsigned char *end = (char *)(node->data + node->size);
 	unsigned int len;
 	int i;
+
 	while ((char *)p < (char *)end) {
-		if(p[0] & 0x80) { /* large tag */
+		if (p[0] & 0x80) {	/* large tag */
 			len = (p[2] << 8) | p[1];
 			p += 3;
 		} else {
-			if (((p[0]>>3) & 0x0f) == 0x0f)
+			if (((p[0] >> 3) & 0x0f) == 0x0f)
 				return;
 			len = p[0] & 0x07;
 			p += 1;
@@ -278,24 +276,24 @@
 			p[i] = 0;
 		p += len;
 	}
-	printk(KERN_ERR "PnPBIOS: Resource structure did not contain an end tag.\n");
+	printk(KERN_ERR
+	       "PnPBIOS: Resource structure did not contain an end tag.\n");
 }
 
 static int pnpbios_disable_resources(struct pnp_dev *dev)
 {
-	struct pnp_bios_node * node;
+	struct pnp_bios_node *node;
 	u8 nodenum = dev->number;
 	int ret;
 
-	/* just in case */
-	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
+	if (dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
 
 	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
-	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
+	if (pnp_bios_get_dev_node(&nodenum, (char)PNPMODE_DYNAMIC, node)) {
 		kfree(node);
 		return -ENODEV;
 	}
@@ -311,22 +309,22 @@
 /* PnP Layer support */
 
 struct pnp_protocol pnpbios_protocol = {
-	.name	= "Plug and Play BIOS",
-	.get	= pnpbios_get_resources,
-	.set	= pnpbios_set_resources,
+	.name = "Plug and Play BIOS",
+	.get = pnpbios_get_resources,
+	.set = pnpbios_set_resources,
 	.disable = pnpbios_disable_resources,
 };
 
-static int insert_device(struct pnp_dev *dev, struct pnp_bios_node * node)
+static int insert_device(struct pnp_dev *dev, struct pnp_bios_node *node)
 {
-	struct list_head * pos;
-	struct pnp_dev * pnp_dev;
+	struct list_head *pos;
+	struct pnp_dev *pnp_dev;
 	struct pnp_id *dev_id;
 	char id[8];
 
 	/* check if the device is already added */
 	dev->number = node->handle;
-	list_for_each (pos, &pnpbios_protocol.devices){
+	list_for_each(pos, &pnpbios_protocol.devices) {
 		pnp_dev = list_entry(pos, struct pnp_dev, protocol_list);
 		if (dev->number == pnp_dev->number)
 			return -1;
@@ -336,8 +334,8 @@
 	dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		return -1;
-	pnpid32_to_pnpid(node->eisa_id,id);
-	memcpy(dev_id->id,id,7);
+	pnpid32_to_pnpid(node->eisa_id, id);
+	memcpy(dev_id->id, id, 7);
 	pnp_add_id(dev_id, dev);
 	pnpbios_parse_data_stream(dev, node);
 	dev->active = pnp_is_active(dev);
@@ -375,35 +373,41 @@
 	if (!node)
 		return;
 
-	for(nodenum=0; nodenum<0xff; ) {
+	for (nodenum = 0; nodenum < 0xff;) {
 		u8 thisnodenum = nodenum;
 		/* eventually we will want to use PNPMODE_STATIC here but for now
 		 * dynamic will help us catch buggy bioses to add to the blacklist.
 		 */
 		if (!pnpbios_dont_use_current_config) {
-			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node))
+			if (pnp_bios_get_dev_node
+			    (&nodenum, (char)PNPMODE_DYNAMIC, node))
 				break;
 		} else {
-			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
+			if (pnp_bios_get_dev_node
+			    (&nodenum, (char)PNPMODE_STATIC, node))
 				break;
 		}
 		nodes_got++;
-		dev =  kzalloc(sizeof (struct pnp_dev), GFP_KERNEL);
+		dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 		if (!dev)
 			break;
-		if(insert_device(dev,node)<0)
+		if (insert_device(dev, node) < 0)
 			kfree(dev);
 		else
 			devs++;
 		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (unsigned int)nodenum, (unsigned int)thisnodenum);
+			printk(KERN_ERR
+			       "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n",
+			       (unsigned int)nodenum,
+			       (unsigned int)thisnodenum);
 			break;
 		}
 	}
 	kfree(node);
 
-	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver\n",
-		nodes_got, nodes_got != 1 ? "s" : "", devs);
+	printk(KERN_INFO
+	       "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver\n",
+	       nodes_got, nodes_got != 1 ? "s" : "", devs);
 }
 
 /*
@@ -412,8 +416,8 @@
  *
  */
 
-static int pnpbios_disabled; /* = 0 */
-int pnpbios_dont_use_current_config; /* = 0 */
+static int pnpbios_disabled;
+int pnpbios_dont_use_current_config;
 
 #ifndef MODULE
 static int __init pnpbios_setup(char *str)
@@ -422,9 +426,9 @@
 
 	while ((str != NULL) && (*str != '\0')) {
 		if (strncmp(str, "off", 3) == 0)
-			pnpbios_disabled=1;
+			pnpbios_disabled = 1;
 		if (strncmp(str, "on", 2) == 0)
-			pnpbios_disabled=0;
+			pnpbios_disabled = 0;
 		invert = (strncmp(str, "no-", 3) == 0);
 		if (invert)
 			str += 3;
@@ -453,35 +457,41 @@
 	printk(KERN_INFO "PnPBIOS: Scanning system for PnP BIOS support...\n");
 
 	/*
- 	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
+	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
 	 * structure and, if one is found, sets up the selectors and
 	 * entry points
 	 */
-	for (check = (union pnp_bios_install_struct *) __va(0xf0000);
-	     check < (union pnp_bios_install_struct *) __va(0xffff0);
+	for (check = (union pnp_bios_install_struct *)__va(0xf0000);
+	     check < (union pnp_bios_install_struct *)__va(0xffff0);
 	     check = (void *)check + 16) {
 		if (check->fields.signature != PNP_SIGNATURE)
 			continue;
-		printk(KERN_INFO "PnPBIOS: Found PnP BIOS installation structure at 0x%p\n", check);
+		printk(KERN_INFO
+		       "PnPBIOS: Found PnP BIOS installation structure at 0x%p\n",
+		       check);
 		length = check->fields.length;
 		if (!length) {
-			printk(KERN_ERR "PnPBIOS: installation structure is invalid, skipping\n");
+			printk(KERN_ERR
+			       "PnPBIOS: installation structure is invalid, skipping\n");
 			continue;
 		}
 		for (sum = 0, i = 0; i < length; i++)
 			sum += check->chars[i];
 		if (sum) {
-			printk(KERN_ERR "PnPBIOS: installation structure is corrupted, skipping\n");
+			printk(KERN_ERR
+			       "PnPBIOS: installation structure is corrupted, skipping\n");
 			continue;
 		}
 		if (check->fields.version < 0x10) {
-			printk(KERN_WARNING "PnPBIOS: PnP BIOS version %d.%d is not supported\n",
+			printk(KERN_WARNING
+			       "PnPBIOS: PnP BIOS version %d.%d is not supported\n",
 			       check->fields.version >> 4,
 			       check->fields.version & 15);
 			continue;
 		}
-		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x\n",
-                       check->fields.version >> 4, check->fields.version & 15,
+		printk(KERN_INFO
+		       "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x\n",
+		       check->fields.version >> 4, check->fields.version & 15,
 		       check->fields.pm16cseg, check->fields.pm16offset,
 		       check->fields.pm16dseg);
 		pnp_bios_install = check;
@@ -499,25 +509,25 @@
 }
 
 static struct dmi_system_id pnpbios_dmi_table[] __initdata = {
-	{	/* PnPBIOS GPF on boot */
-		.callback = exploding_pnp_bios,
-		.ident = "Higraded P14H",
-		.matches = {
-			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			DMI_MATCH(DMI_BIOS_VERSION, "07.00T"),
-			DMI_MATCH(DMI_SYS_VENDOR, "Higraded"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P14H"),
-		},
-	},
-	{	/* PnPBIOS GPF on boot */
-		.callback = exploding_pnp_bios,
-		.ident = "ASUS P4P800",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "P4P800"),
-		},
-	},
-	{ }
+	{			/* PnPBIOS GPF on boot */
+	 .callback = exploding_pnp_bios,
+	 .ident = "Higraded P14H",
+	 .matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+		     DMI_MATCH(DMI_BIOS_VERSION, "07.00T"),
+		     DMI_MATCH(DMI_SYS_VENDOR, "Higraded"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "P14H"),
+		     },
+	 },
+	{			/* PnPBIOS GPF on boot */
+	 .callback = exploding_pnp_bios,
+	 .ident = "ASUS P4P800",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+		     DMI_MATCH(DMI_BOARD_NAME, "P4P800"),
+		     },
+	 },
+	{}
 };
 
 static int __init pnpbios_init(void)
@@ -533,14 +543,13 @@
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}
-
 #ifdef CONFIG_PNPACPI
 	if (!acpi_disabled && !pnpacpi_disabled) {
 		pnpbios_disabled = 1;
 		printk(KERN_INFO "PnPBIOS: Disabled by ACPI PNP\n");
 		return -ENODEV;
 	}
-#endif /* CONFIG_ACPI */
+#endif				/* CONFIG_ACPI */
 
 	/* scan the system for pnpbios support */
 	if (!pnpbios_probe_system())
@@ -552,14 +561,16 @@
 	/* read the node info */
 	ret = pnp_bios_dev_node_info(&node_info);
 	if (ret) {
-		printk(KERN_ERR "PnPBIOS: Unable to get node info.  Aborting.\n");
+		printk(KERN_ERR
+		       "PnPBIOS: Unable to get node info.  Aborting.\n");
 		return ret;
 	}
 
 	/* register with the pnp layer */
 	ret = pnp_register_protocol(&pnpbios_protocol);
 	if (ret) {
-		printk(KERN_ERR "PnPBIOS: Unable to register driver.  Aborting.\n");
+		printk(KERN_ERR
+		       "PnPBIOS: Unable to register driver.  Aborting.\n");
 		return ret;
 	}
 

--
