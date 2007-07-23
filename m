From: helgaas@ldl.fc.hp.com
Subject: [patch 14/17] PNPBIOS: Lindent proc.c
Date: Mon, 23 Jul 2007 15:28:11 -0600
Message-ID: <20070723213243.146529716@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52752 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757295AbXGWVdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:15 -0400
Content-Disposition: inline; filename=pnpbios-format-proc
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/pnpbios/proc.c
===================================================================
--- work2.orig/drivers/pnp/pnpbios/proc.c	2007-07-20 14:45:27.000000000 -0600
+++ work2/drivers/pnp/pnpbios/proc.c	2007-07-20 14:46:52.000000000 -0600
@@ -18,9 +18,6 @@
  * The other files are human-readable.
  */
 
-//#include <pcmcia/config.h>
-//#include <pcmcia/k_compat.h>
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -37,42 +34,37 @@
 static struct proc_dir_entry *proc_pnp_boot = NULL;
 
 static int proc_read_pnpconfig(char *buf, char **start, off_t pos,
-                               int count, int *eof, void *data)
+			       int count, int *eof, void *data)
 {
 	struct pnp_isa_config_struc pnps;
 
 	if (pnp_bios_isapnp_config(&pnps))
 		return -EIO;
 	return snprintf(buf, count,
-		"structure_revision %d\n"
-		"number_of_CSNs %d\n"
-		"ISA_read_data_port 0x%x\n",
-		pnps.revision,
-		pnps.no_csns,
-		pnps.isa_rd_data_port
-	);
+			"structure_revision %d\n"
+			"number_of_CSNs %d\n"
+			"ISA_read_data_port 0x%x\n",
+			pnps.revision, pnps.no_csns, pnps.isa_rd_data_port);
 }
 
 static int proc_read_escdinfo(char *buf, char **start, off_t pos,
-                              int count, int *eof, void *data)
+			      int count, int *eof, void *data)
 {
 	struct escd_info_struc escd;
 
 	if (pnp_bios_escd_info(&escd))
 		return -EIO;
 	return snprintf(buf, count,
-		"min_ESCD_write_size %d\n"
-		"ESCD_size %d\n"
-		"NVRAM_base 0x%x\n",
-		escd.min_escd_write_size,
-		escd.escd_size,
-		escd.nv_storage_base
-	);
+			"min_ESCD_write_size %d\n"
+			"ESCD_size %d\n"
+			"NVRAM_base 0x%x\n",
+			escd.min_escd_write_size,
+			escd.escd_size, escd.nv_storage_base);
 }
 
 #define MAX_SANE_ESCD_SIZE (32*1024)
 static int proc_read_escd(char *buf, char **start, off_t pos,
-                          int count, int *eof, void *data)
+			  int count, int *eof, void *data)
 {
 	struct escd_info_struc escd;
 	char *tmpbuf;
@@ -83,30 +75,36 @@
 
 	/* sanity check */
 	if (escd.escd_size > MAX_SANE_ESCD_SIZE) {
-		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
+		printk(KERN_ERR
+		       "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
 		return -EFBIG;
 	}
 
 	tmpbuf = kzalloc(escd.escd_size, GFP_KERNEL);
-	if (!tmpbuf) return -ENOMEM;
+	if (!tmpbuf)
+		return -ENOMEM;
 
 	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base)) {
 		kfree(tmpbuf);
 		return -EIO;
 	}
 
-	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;
+	escd_size =
+	    (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1]) * 256;
 
 	/* sanity check */
 	if (escd_size > MAX_SANE_ESCD_SIZE) {
-		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS read_escd call is too great\n");
+		printk(KERN_ERR
+		       "PnPBIOS: proc_read_escd: ESCD size reported by BIOS read_escd call is too great\n");
 		return -EFBIG;
 	}
 
 	escd_left_to_read = escd_size - pos;
-	if (escd_left_to_read < 0) escd_left_to_read = 0;
-	if (escd_left_to_read == 0) *eof = 1;
-	n = min(count,escd_left_to_read);
+	if (escd_left_to_read < 0)
+		escd_left_to_read = 0;
+	if (escd_left_to_read == 0)
+		*eof = 1;
+	n = min(count, escd_left_to_read);
 	memcpy(buf, tmpbuf + pos, n);
 	kfree(tmpbuf);
 	*start = buf;
@@ -114,17 +112,17 @@
 }
 
 static int proc_read_legacyres(char *buf, char **start, off_t pos,
-                               int count, int *eof, void *data)
+			       int count, int *eof, void *data)
 {
 	/* Assume that the following won't overflow the buffer */
-	if (pnp_bios_get_stat_res(buf)) 
+	if (pnp_bios_get_stat_res(buf))
 		return -EIO;
 
-	return count;  // FIXME: Return actual length
+	return count;		// FIXME: Return actual length
 }
 
 static int proc_read_devices(char *buf, char **start, off_t pos,
-                             int count, int *eof, void *data)
+			     int count, int *eof, void *data)
 {
 	struct pnp_bios_node *node;
 	u8 nodenum;
@@ -134,9 +132,10 @@
 		return 0;
 
 	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return -ENOMEM;
+	if (!node)
+		return -ENOMEM;
 
-	for (nodenum=pos; nodenum<0xff; ) {
+	for (nodenum = pos; nodenum < 0xff;) {
 		u8 thisnodenum = nodenum;
 		/* 26 = the number of characters per line sprintf'ed */
 		if ((p - buf + 26) > count)
@@ -148,7 +147,11 @@
 			     node->type_code[0], node->type_code[1],
 			     node->type_code[2], node->flags);
 		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_read_devices:", (unsigned int)nodenum, (unsigned int)thisnodenum);
+			printk(KERN_ERR
+			       "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n",
+			       "PnPBIOS: proc_read_devices:",
+			       (unsigned int)nodenum,
+			       (unsigned int)thisnodenum);
 			*eof = 1;
 			break;
 		}
@@ -156,12 +159,12 @@
 	kfree(node);
 	if (nodenum == 0xff)
 		*eof = 1;
-	*start = (char *)((off_t)nodenum - pos);
+	*start = (char *)((off_t) nodenum - pos);
 	return p - buf;
 }
 
 static int proc_read_node(char *buf, char **start, off_t pos,
-                          int count, int *eof, void *data)
+			  int count, int *eof, void *data)
 {
 	struct pnp_bios_node *node;
 	int boot = (long)data >> 8;
@@ -169,7 +172,8 @@
 	int len;
 
 	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return -ENOMEM;
+	if (!node)
+		return -ENOMEM;
 	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
 		kfree(node);
 		return -EIO;
@@ -180,8 +184,8 @@
 	return len;
 }
 
-static int proc_write_node(struct file *file, const char __user *buf,
-                           unsigned long count, void *data)
+static int proc_write_node(struct file *file, const char __user * buf,
+			   unsigned long count, void *data)
 {
 	struct pnp_bios_node *node;
 	int boot = (long)data >> 8;
@@ -208,12 +212,12 @@
 		goto out;
 	}
 	ret = count;
-out:
+      out:
 	kfree(node);
 	return ret;
 }
 
-int pnpbios_interface_attach_device(struct pnp_bios_node * node)
+int pnpbios_interface_attach_device(struct pnp_bios_node *node)
 {
 	char name[3];
 	struct proc_dir_entry *ent;
@@ -222,7 +226,7 @@
 
 	if (!proc_pnp)
 		return -EIO;
-	if ( !pnpbios_dont_use_current_config ) {
+	if (!pnpbios_dont_use_current_config) {
 		ent = create_proc_entry(name, 0, proc_pnp);
 		if (ent) {
 			ent->read_proc = proc_read_node;
@@ -237,7 +241,7 @@
 	if (ent) {
 		ent->read_proc = proc_read_node;
 		ent->write_proc = proc_write_node;
-		ent->data = (void *)(long)(node->handle+0x100);
+		ent->data = (void *)(long)(node->handle + 0x100);
 		return 0;
 	}
 
@@ -249,7 +253,7 @@
  * work and the pnpbios_dont_use_current_config flag
  * should already have been set to the appropriate value
  */
-int __init pnpbios_proc_init( void )
+int __init pnpbios_proc_init(void)
 {
 	proc_pnp = proc_mkdir("pnp", proc_bus);
 	if (!proc_pnp)
@@ -258,10 +262,13 @@
 	if (!proc_pnp_boot)
 		return -EIO;
 	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
-	create_proc_read_entry("configuration_info", 0, proc_pnp, proc_read_pnpconfig, NULL);
-	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo, NULL);
+	create_proc_read_entry("configuration_info", 0, proc_pnp,
+			       proc_read_pnpconfig, NULL);
+	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo,
+			       NULL);
 	create_proc_read_entry("escd", S_IRUSR, proc_pnp, proc_read_escd, NULL);
-	create_proc_read_entry("legacy_device_resources", 0, proc_pnp, proc_read_legacyres, NULL);
+	create_proc_read_entry("legacy_device_resources", 0, proc_pnp,
+			       proc_read_legacyres, NULL);
 
 	return 0;
 }
@@ -274,9 +281,9 @@
 	if (!proc_pnp)
 		return;
 
-	for (i=0; i<0xff; i++) {
+	for (i = 0; i < 0xff; i++) {
 		sprintf(name, "%02x", i);
-		if ( !pnpbios_dont_use_current_config )
+		if (!pnpbios_dont_use_current_config)
 			remove_proc_entry(name, proc_pnp);
 		remove_proc_entry(name, proc_pnp_boot);
 	}
@@ -287,6 +294,4 @@
 	remove_proc_entry("devices", proc_pnp);
 	remove_proc_entry("boot", proc_pnp);
 	remove_proc_entry("pnp", proc_bus);
-
-	return;
 }

--
