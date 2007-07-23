From: helgaas@ldl.fc.hp.com
Subject: [patch 09/17] ISAPNP: Lindent core.c
Date: Mon, 23 Jul 2007 15:28:06 -0600
Message-ID: <20070723213242.143040602@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:45588 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903AbXGWVd0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:26 -0400
Content-Disposition: inline; filename=isapnp-format-core
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/isapnp/core.c
===================================================================
--- work2.orig/drivers/pnp/isapnp/core.c	2007-07-23 14:57:12.000000000 -0600
+++ work2/drivers/pnp/isapnp/core.c	2007-07-23 15:02:21.000000000 -0600
@@ -51,10 +51,10 @@
 #define ISAPNP_DEBUG
 #endif
 
-int isapnp_disable;			/* Disable ISA PnP */
-static int isapnp_rdp;			/* Read Data Port */
-static int isapnp_reset = 1;		/* reset all PnP cards (deactivate) */
-static int isapnp_verbose = 1;		/* verbose mode */
+int isapnp_disable;		/* Disable ISA PnP */
+static int isapnp_rdp;		/* Read Data Port */
+static int isapnp_reset = 1;	/* reset all PnP cards (deactivate) */
+static int isapnp_verbose = 1;	/* verbose mode */
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Generic ISA Plug & Play support");
@@ -126,7 +126,7 @@
 	unsigned short val;
 
 	val = isapnp_read_byte(idx);
-	val = (val << 8) + isapnp_read_byte(idx+1);
+	val = (val << 8) + isapnp_read_byte(idx + 1);
 	return val;
 }
 
@@ -139,7 +139,7 @@
 static void isapnp_write_word(unsigned char idx, unsigned short val)
 {
 	isapnp_write_byte(idx, val >> 8);
-	isapnp_write_byte(idx+1, val);
+	isapnp_write_byte(idx + 1, val);
 }
 
 static void isapnp_key(void)
@@ -193,7 +193,7 @@
 static void __init isapnp_peek(unsigned char *data, int bytes)
 {
 	int i, j;
-	unsigned char d=0;
+	unsigned char d = 0;
 
 	for (i = 1; i <= bytes; i++) {
 		for (j = 0; j < 20; j++) {
@@ -220,19 +220,18 @@
 {
 	int rdp = isapnp_rdp;
 	static int old_rdp = 0;
-	
-	if(old_rdp)
-	{
+
+	if (old_rdp) {
 		release_region(old_rdp, 1);
 		old_rdp = 0;
 	}
 	while (rdp <= 0x3ff) {
 		/*
-		 *	We cannot use NE2000 probe spaces for ISAPnP or we
-		 *	will lock up machines.
+		 *      We cannot use NE2000 probe spaces for ISAPnP or we
+		 *      will lock up machines.
 		 */
-		if ((rdp < 0x280 || rdp >  0x380) && request_region(rdp, 1, "ISAPnP"))
-		{
+		if ((rdp < 0x280 || rdp > 0x380)
+		    && request_region(rdp, 1, "ISAPnP")) {
 			isapnp_rdp = rdp;
 			old_rdp = rdp;
 			return 0;
@@ -253,7 +252,6 @@
  *	Perform an isolation. The port selection code now tries to avoid
  *	"dangerous to read" ports.
  */
-
 static int __init isapnp_isolate_rdp_select(void)
 {
 	isapnp_wait();
@@ -282,7 +280,6 @@
 /*
  *  Isolate (assign uniqued CSN) to all ISA PnP devices.
  */
-
 static int __init isapnp_isolate(void)
 {
 	unsigned char checksum = 0x6a;
@@ -305,7 +302,9 @@
 			udelay(250);
 			if (data == 0x55aa)
 				bit = 0x01;
-			checksum = ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7) | (checksum >> 1);
+			checksum =
+			    ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7)
+			    | (checksum >> 1);
 			bit = 0x00;
 		}
 		for (i = 65; i <= 72; i++) {
@@ -351,13 +350,12 @@
 /*
  *  Read one tag from stream.
  */
-
 static int __init isapnp_read_tag(unsigned char *type, unsigned short *size)
 {
 	unsigned char tag, tmp[2];
 
 	isapnp_peek(&tag, 1);
-	if (tag == 0)				/* invalid tag */
+	if (tag == 0)		/* invalid tag */
 		return -1;
 	if (tag & 0x80) {	/* large item */
 		*type = tag;
@@ -368,7 +366,8 @@
 		*size = tag & 0x07;
 	}
 #if 0
-	printk(KERN_DEBUG "tag = 0x%x, type = 0x%x, size = %i\n", tag, *type, *size);
+	printk(KERN_DEBUG "tag = 0x%x, type = 0x%x, size = %i\n", tag, *type,
+	       *size);
 #endif
 	if (*type == 0xff && *size == 0xffff)	/* probably invalid data */
 		return -1;
@@ -378,7 +377,6 @@
 /*
  *  Skip specified number of bytes from stream.
  */
-
 static void __init isapnp_skip_bytes(int count)
 {
 	isapnp_peek(NULL, count);
@@ -387,31 +385,30 @@
 /*
  *  Parse EISA id.
  */
-
-static void isapnp_parse_id(struct pnp_dev * dev, unsigned short vendor, unsigned short device)
+static void isapnp_parse_id(struct pnp_dev *dev, unsigned short vendor,
+			    unsigned short device)
 {
-	struct pnp_id * id;
+	struct pnp_id *id;
+
 	if (!dev)
 		return;
 	id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
-			'A' + ((vendor >> 2) & 0x3f) - 1,
-			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
-			'A' + ((vendor >> 8) & 0x1f) - 1,
-			(device >> 4) & 0x0f,
-			device & 0x0f,
-			(device >> 12) & 0x0f,
-			(device >> 8) & 0x0f);
+		'A' + ((vendor >> 2) & 0x3f) - 1,
+		'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+		'A' + ((vendor >> 8) & 0x1f) - 1,
+		(device >> 4) & 0x0f,
+		device & 0x0f, (device >> 12) & 0x0f, (device >> 8) & 0x0f);
 	pnp_add_id(id, dev);
 }
 
 /*
  *  Parse logical device tag.
  */
-
-static struct pnp_dev * __init isapnp_parse_device(struct pnp_card *card, int size, int number)
+static struct pnp_dev *__init isapnp_parse_device(struct pnp_card *card,
+						  int size, int number)
 {
 	unsigned char tmp[6];
 	struct pnp_dev *dev;
@@ -435,13 +432,11 @@
 	return dev;
 }
 
-
 /*
  *  Add IRQ resource to resources list.
  */
-
 static void __init isapnp_parse_irq_resource(struct pnp_option *option,
-					       int size)
+					     int size)
 {
 	unsigned char tmp[3];
 	struct pnp_irq *irq;
@@ -458,15 +453,13 @@
 	else
 		irq->flags = IORESOURCE_IRQ_HIGHEDGE;
 	pnp_register_irq_resource(option, irq);
-	return;
 }
 
 /*
  *  Add DMA resource to resources list.
  */
-
 static void __init isapnp_parse_dma_resource(struct pnp_option *option,
-                                    	       int size)
+					     int size)
 {
 	unsigned char tmp[2];
 	struct pnp_dma *dma;
@@ -478,15 +471,13 @@
 	dma->map = tmp[0];
 	dma->flags = tmp[1];
 	pnp_register_dma_resource(option, dma);
-	return;
 }
 
 /*
  *  Add port resource to resources list.
  */
-
 static void __init isapnp_parse_port_resource(struct pnp_option *option,
-						int size)
+					      int size)
 {
 	unsigned char tmp[7];
 	struct pnp_port *port;
@@ -500,16 +491,14 @@
 	port->align = tmp[5];
 	port->size = tmp[6];
 	port->flags = tmp[0] ? PNP_PORT_FLAG_16BITADDR : 0;
-	pnp_register_port_resource(option,port);
-	return;
+	pnp_register_port_resource(option, port);
 }
 
 /*
  *  Add fixed port resource to resources list.
  */
-
 static void __init isapnp_parse_fixed_port_resource(struct pnp_option *option,
-						      int size)
+						    int size)
 {
 	unsigned char tmp[3];
 	struct pnp_port *port;
@@ -522,16 +511,14 @@
 	port->size = tmp[2];
 	port->align = 0;
 	port->flags = PNP_PORT_FLAG_FIXED;
-	pnp_register_port_resource(option,port);
-	return;
+	pnp_register_port_resource(option, port);
 }
 
 /*
  *  Add memory resource to resources list.
  */
-
 static void __init isapnp_parse_mem_resource(struct pnp_option *option,
-					       int size)
+					     int size)
 {
 	unsigned char tmp[9];
 	struct pnp_mem *mem;
@@ -545,16 +532,14 @@
 	mem->align = (tmp[6] << 8) | tmp[5];
 	mem->size = ((tmp[8] << 8) | tmp[7]) << 8;
 	mem->flags = tmp[0];
-	pnp_register_mem_resource(option,mem);
-	return;
+	pnp_register_mem_resource(option, mem);
 }
 
 /*
  *  Add 32-bit memory resource to resources list.
  */
-
 static void __init isapnp_parse_mem32_resource(struct pnp_option *option,
-						 int size)
+					       int size)
 {
 	unsigned char tmp[17];
 	struct pnp_mem *mem;
@@ -565,18 +550,19 @@
 		return;
 	mem->min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
 	mem->max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
-	mem->align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
-	mem->size = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
+	mem->align =
+	    (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
+	mem->size =
+	    (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
 	mem->flags = tmp[0];
-	pnp_register_mem_resource(option,mem);
+	pnp_register_mem_resource(option, mem);
 }
 
 /*
  *  Add 32-bit fixed memory resource to resources list.
  */
-
 static void __init isapnp_parse_fixed_mem32_resource(struct pnp_option *option,
-						       int size)
+						     int size)
 {
 	unsigned char tmp[9];
 	struct pnp_mem *mem;
@@ -585,28 +571,29 @@
 	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
-	mem->min = mem->max = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
+	mem->min = mem->max =
+	    (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
 	mem->size = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
 	mem->align = 0;
 	mem->flags = tmp[0];
-	pnp_register_mem_resource(option,mem);
+	pnp_register_mem_resource(option, mem);
 }
 
 /*
  *  Parse card name for ISA PnP device.
- */ 
-
+ */
 static void __init
 isapnp_parse_name(char *name, unsigned int name_max, unsigned short *size)
 {
 	if (name[0] == '\0') {
-		unsigned short size1 = *size >= name_max ? (name_max - 1) : *size;
+		unsigned short size1 =
+		    *size >= name_max ? (name_max - 1) : *size;
 		isapnp_peek(name, size1);
 		name[size1] = '\0';
 		*size -= size1;
 
 		/* clean whitespace from end of string */
-		while (size1 > 0  &&  name[--size1] == ' ')
+		while (size1 > 0 && name[--size1] == ' ')
 			name[size1] = '\0';
 	}
 }
@@ -614,7 +601,6 @@
 /*
  *  Parse resource map for logical device.
  */
-
 static int __init isapnp_create_device(struct pnp_card *card,
 				       unsigned short size)
 {
@@ -622,6 +608,7 @@
 	unsigned char type, tmp[17];
 	struct pnp_option *option;
 	struct pnp_dev *dev;
+
 	if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 		return 1;
 	option = pnp_register_independent_option(dev);
@@ -629,17 +616,19 @@
 		kfree(dev);
 		return 1;
 	}
-	pnp_add_card_device(card,dev);
+	pnp_add_card_device(card, dev);
 
 	while (1) {
-		if (isapnp_read_tag(&type, &size)<0)
+		if (isapnp_read_tag(&type, &size) < 0)
 			return 1;
 		if (skip && type != _STAG_LOGDEVID && type != _STAG_END)
 			goto __skip;
 		switch (type) {
 		case _STAG_LOGDEVID:
 			if (size >= 5 && size <= 6) {
-				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
+				if ((dev =
+				     isapnp_parse_device(card, size,
+							 number++)) == NULL)
 					return 1;
 				size = 0;
 				skip = 0;
@@ -648,7 +637,7 @@
 					kfree(dev);
 					return 1;
 				}
-				pnp_add_card_device(card,dev);
+				pnp_add_card_device(card, dev);
 			} else {
 				skip = 1;
 			}
@@ -658,7 +647,8 @@
 		case _STAG_COMPATDEVID:
 			if (size == 4 && compat < DEVICE_COUNT_COMPATIBLE) {
 				isapnp_peek(tmp, 4);
-				isapnp_parse_id(dev,(tmp[1] << 8) | tmp[0], (tmp[3] << 8) | tmp[2]);
+				isapnp_parse_id(dev, (tmp[1] << 8) | tmp[0],
+						(tmp[3] << 8) | tmp[2]);
 				compat++;
 				size = 0;
 			}
@@ -684,7 +674,7 @@
 				priority = 0x100 | tmp[0];
 				size = 0;
 			}
-			option = pnp_register_dependent_option(dev,priority);
+			option = pnp_register_dependent_option(dev, priority);
 			if (!option)
 				return 1;
 			break;
@@ -739,11 +729,13 @@
 				isapnp_skip_bytes(size);
 			return 1;
 		default:
-			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n", type, dev->number, card->number);
+			printk(KERN_ERR
+			       "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n",
+			       type, dev->number, card->number);
 		}
 	      __skip:
-	      	if (size > 0)
-		      	isapnp_skip_bytes(size);
+		if (size > 0)
+			isapnp_skip_bytes(size);
 	}
 	return 0;
 }
@@ -751,14 +743,13 @@
 /*
  *  Parse resource map for ISA PnP card.
  */
-
 static void __init isapnp_parse_resource_map(struct pnp_card *card)
 {
 	unsigned char type, tmp[17];
 	unsigned short size;
 
 	while (1) {
-		if (isapnp_read_tag(&type, &size)<0)
+		if (isapnp_read_tag(&type, &size) < 0)
 			return;
 		switch (type) {
 		case _STAG_PNPVERNO:
@@ -771,7 +762,7 @@
 			break;
 		case _STAG_LOGDEVID:
 			if (size >= 5 && size <= 6) {
-				if (isapnp_create_device(card, size)==1)
+				if (isapnp_create_device(card, size) == 1)
 					return;
 				size = 0;
 			}
@@ -779,7 +770,8 @@
 		case _STAG_VENDOR:
 			break;
 		case _LTAG_ANSISTR:
-			isapnp_parse_name(card->name, sizeof(card->name), &size);
+			isapnp_parse_name(card->name, sizeof(card->name),
+					  &size);
 			break;
 		case _LTAG_UNICODESTR:
 			/* silently ignore */
@@ -792,18 +784,19 @@
 				isapnp_skip_bytes(size);
 			return;
 		default:
-			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for device %i, ignored\n", type, card->number);
+			printk(KERN_ERR
+			       "isapnp: unexpected or unknown tag type 0x%x for device %i, ignored\n",
+			       type, card->number);
 		}
 	      __skip:
-	      	if (size > 0)
-		      	isapnp_skip_bytes(size);
+		if (size > 0)
+			isapnp_skip_bytes(size);
 	}
 }
 
 /*
  *  Compute ISA PnP checksum for first eight bytes.
  */
-
 static unsigned char __init isapnp_checksum(unsigned char *data)
 {
 	int i, j;
@@ -815,7 +808,9 @@
 			bit = 0;
 			if (b & (1 << j))
 				bit = 1;
-			checksum = ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7) | (checksum >> 1);
+			checksum =
+			    ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7)
+			    | (checksum >> 1);
 		}
 	}
 	return checksum;
@@ -824,27 +819,25 @@
 /*
  *  Parse EISA id for ISA PnP card.
  */
-
-static void isapnp_parse_card_id(struct pnp_card * card, unsigned short vendor, unsigned short device)
+static void isapnp_parse_card_id(struct pnp_card *card, unsigned short vendor,
+				 unsigned short device)
 {
-	struct pnp_id * id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	struct pnp_id *id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
+
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
-			'A' + ((vendor >> 2) & 0x3f) - 1,
-			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
-			'A' + ((vendor >> 8) & 0x1f) - 1,
-			(device >> 4) & 0x0f,
-			device & 0x0f,
-			(device >> 12) & 0x0f,
-			(device >> 8) & 0x0f);
-	pnp_add_card_id(id,card);
+		'A' + ((vendor >> 2) & 0x3f) - 1,
+		'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+		'A' + ((vendor >> 8) & 0x1f) - 1,
+		(device >> 4) & 0x0f,
+		device & 0x0f, (device >> 12) & 0x0f, (device >> 8) & 0x0f);
+	pnp_add_card_id(id, card);
 }
 
 /*
  *  Build device list for all present ISA PnP devices.
  */
-
 static int __init isapnp_build_device_list(void)
 {
 	int csn;
@@ -858,22 +851,29 @@
 		isapnp_peek(header, 9);
 		checksum = isapnp_checksum(header);
 #if 0
-		printk(KERN_DEBUG "vendor: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
-			header[0], header[1], header[2], header[3],
-			header[4], header[5], header[6], header[7], header[8]);
+		printk(KERN_DEBUG
+		       "vendor: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+		       header[0], header[1], header[2], header[3], header[4],
+		       header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		if ((card = kzalloc(sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
+		if ((card =
+		     kzalloc(sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
 			continue;
 
 		card->number = csn;
 		INIT_LIST_HEAD(&card->devices);
-		isapnp_parse_card_id(card, (header[1] << 8) | header[0], (header[3] << 8) | header[2]);
-		card->serial = (header[7] << 24) | (header[6] << 16) | (header[5] << 8) | header[4];
+		isapnp_parse_card_id(card, (header[1] << 8) | header[0],
+				     (header[3] << 8) | header[2]);
+		card->serial =
+		    (header[7] << 24) | (header[6] << 16) | (header[5] << 8) |
+		    header[4];
 		isapnp_checksum_value = 0x00;
 		isapnp_parse_resource_map(card);
 		if (isapnp_checksum_value != 0x00)
-			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
+			printk(KERN_ERR
+			       "isapnp: checksum for device %i is not valid (0x%x)\n",
+			       csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
 		card->protocol = &isapnp_protocol;
 
@@ -890,6 +890,7 @@
 int isapnp_present(void)
 {
 	struct pnp_card *card;
+
 	pnp_for_each_card(card) {
 		if (card->protocol == &isapnp_protocol)
 			return 1;
@@ -911,13 +912,13 @@
 	/* it is possible to set RDP only in the isolation phase */
 	/*   Jens Thoms Toerring <Jens.Toerring@physik.fu-berlin.de> */
 	isapnp_write_byte(0x02, 0x04);	/* clear CSN of card */
-	mdelay(2);			/* is this necessary? */
-	isapnp_wake(csn);		/* bring card into sleep state */
-	isapnp_wake(0);			/* bring card into isolation state */
-	isapnp_set_rdp();		/* reset the RDP port */
-	udelay(1000);			/* delay 1000us */
+	mdelay(2);		/* is this necessary? */
+	isapnp_wake(csn);	/* bring card into sleep state */
+	isapnp_wake(0);		/* bring card into isolation state */
+	isapnp_set_rdp();	/* reset the RDP port */
+	udelay(1000);		/* delay 1000us */
 	isapnp_write_byte(0x06, csn);	/* reset CSN to previous value */
-	udelay(250);			/* is this necessary? */
+	udelay(250);		/* is this necessary? */
 #endif
 	if (logdev >= 0)
 		isapnp_device(logdev);
@@ -931,12 +932,10 @@
 	return 0;
 }
 
-
 /*
- *  Inititialization.
+ *  Initialization.
  */
 
-
 EXPORT_SYMBOL(isapnp_protocol);
 EXPORT_SYMBOL(isapnp_present);
 EXPORT_SYMBOL(isapnp_cfg_begin);
@@ -946,7 +945,8 @@
 #endif
 EXPORT_SYMBOL(isapnp_write_byte);
 
-static int isapnp_read_resources(struct pnp_dev *dev, struct pnp_resource_table *res)
+static int isapnp_read_resources(struct pnp_dev *dev,
+				 struct pnp_resource_table *res)
 {
 	int tmp, ret;
 
@@ -960,31 +960,37 @@
 			res->port_resource[tmp].flags = IORESOURCE_IO;
 		}
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
-			ret = isapnp_read_word(ISAPNP_CFG_MEM + (tmp << 3)) << 8;
+			ret =
+			    isapnp_read_word(ISAPNP_CFG_MEM + (tmp << 3)) << 8;
 			if (!ret)
 				continue;
 			res->mem_resource[tmp].start = ret;
 			res->mem_resource[tmp].flags = IORESOURCE_MEM;
 		}
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
-			ret = (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >> 8);
+			ret =
+			    (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >>
+			     8);
 			if (!ret)
 				continue;
-			res->irq_resource[tmp].start = res->irq_resource[tmp].end = ret;
+			res->irq_resource[tmp].start =
+			    res->irq_resource[tmp].end = ret;
 			res->irq_resource[tmp].flags = IORESOURCE_IRQ;
 		}
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
 			if (ret == 4)
 				continue;
-			res->dma_resource[tmp].start = res->dma_resource[tmp].end = ret;
+			res->dma_resource[tmp].start =
+			    res->dma_resource[tmp].end = ret;
 			res->dma_resource[tmp].flags = IORESOURCE_DMA;
 		}
 	}
 	return 0;
 }
 
-static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
+static int isapnp_get_resources(struct pnp_dev *dev,
+				struct pnp_resource_table *res)
 {
 	int ret;
 	pnp_init_resource_table(res);
@@ -994,24 +1000,44 @@
 	return ret;
 }
 
-static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
+static int isapnp_set_resources(struct pnp_dev *dev,
+				struct pnp_resource_table *res)
 {
 	int tmp;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	for (tmp = 0; tmp < PNP_MAX_PORT && (res->port_resource[tmp].flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO; tmp++)
-		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
-	for (tmp = 0; tmp < PNP_MAX_IRQ && (res->irq_resource[tmp].flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ; tmp++) {
+	for (tmp = 0;
+	     tmp < PNP_MAX_PORT
+	     && (res->port_resource[tmp].
+		 flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO;
+	     tmp++)
+		isapnp_write_word(ISAPNP_CFG_PORT + (tmp << 1),
+				  res->port_resource[tmp].start);
+	for (tmp = 0;
+	     tmp < PNP_MAX_IRQ
+	     && (res->irq_resource[tmp].
+		 flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ;
+	     tmp++) {
 		int irq = res->irq_resource[tmp].start;
 		if (irq == 2)
 			irq = 9;
-		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
+		isapnp_write_byte(ISAPNP_CFG_IRQ + (tmp << 1), irq);
 	}
-	for (tmp = 0; tmp < PNP_MAX_DMA && (res->dma_resource[tmp].flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA; tmp++)
-		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
-	for (tmp = 0; tmp < PNP_MAX_MEM && (res->mem_resource[tmp].flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) == IORESOURCE_MEM; tmp++)
-		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<3), (res->mem_resource[tmp].start >> 8) & 0xffff);
+	for (tmp = 0;
+	     tmp < PNP_MAX_DMA
+	     && (res->dma_resource[tmp].
+		 flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA;
+	     tmp++)
+		isapnp_write_byte(ISAPNP_CFG_DMA + tmp,
+				  res->dma_resource[tmp].start);
+	for (tmp = 0;
+	     tmp < PNP_MAX_MEM
+	     && (res->mem_resource[tmp].
+		 flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) == IORESOURCE_MEM;
+	     tmp++)
+		isapnp_write_word(ISAPNP_CFG_MEM + (tmp << 3),
+				  (res->mem_resource[tmp].start >> 8) & 0xffff);
 	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
 	isapnp_cfg_end();
@@ -1030,9 +1056,9 @@
 }
 
 struct pnp_protocol isapnp_protocol = {
-	.name	= "ISA Plug and Play",
-	.get	= isapnp_get_resources,
-	.set	= isapnp_set_resources,
+	.name = "ISA Plug and Play",
+	.get = isapnp_get_resources,
+	.set = isapnp_set_resources,
 	.disable = isapnp_disable_resources,
 };
 
@@ -1053,31 +1079,36 @@
 #endif
 #ifdef ISAPNP_REGION_OK
 	if (!request_region(_PIDXR, 1, "isapnp index")) {
-		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n", _PIDXR);
+		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n",
+		       _PIDXR);
 		return -EBUSY;
 	}
 #endif
 	if (!request_region(_PNPWRP, 1, "isapnp write")) {
-		printk(KERN_ERR "isapnp: Write Data Register 0x%x already used\n", _PNPWRP);
+		printk(KERN_ERR
+		       "isapnp: Write Data Register 0x%x already used\n",
+		       _PNPWRP);
 #ifdef ISAPNP_REGION_OK
 		release_region(_PIDXR, 1);
 #endif
 		return -EBUSY;
 	}
 
-	if(pnp_register_protocol(&isapnp_protocol)<0)
+	if (pnp_register_protocol(&isapnp_protocol) < 0)
 		return -EBUSY;
 
 	/*
-	 *	Print a message. The existing ISAPnP code is hanging machines
-	 *	so let the user know where.
+	 *      Print a message. The existing ISAPnP code is hanging machines
+	 *      so let the user know where.
 	 */
-	 
+
 	printk(KERN_INFO "isapnp: Scanning for PnP cards...\n");
 	if (isapnp_rdp >= 0x203 && isapnp_rdp <= 0x3ff) {
 		isapnp_rdp |= 3;
 		if (!request_region(isapnp_rdp, 1, "isapnp read")) {
-			printk(KERN_ERR "isapnp: Read Data Register 0x%x already used\n", isapnp_rdp);
+			printk(KERN_ERR
+			       "isapnp: Read Data Register 0x%x already used\n",
+			       isapnp_rdp);
 #ifdef ISAPNP_REGION_OK
 			release_region(_PIDXR, 1);
 #endif
@@ -1089,14 +1120,14 @@
 	isapnp_detected = 1;
 	if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
 		cards = isapnp_isolate();
-		if (cards < 0 || 
-		    (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
+		if (cards < 0 || (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
 #ifdef ISAPNP_REGION_OK
 			release_region(_PIDXR, 1);
 #endif
 			release_region(_PNPWRP, 1);
 			isapnp_detected = 0;
-			printk(KERN_INFO "isapnp: No Plug & Play device found\n");
+			printk(KERN_INFO
+			       "isapnp: No Plug & Play device found\n");
 			return 0;
 		}
 		request_region(isapnp_rdp, 1, "isapnp read");
@@ -1104,19 +1135,23 @@
 	isapnp_build_device_list();
 	cards = 0;
 
-	protocol_for_each_card(&isapnp_protocol,card) {
+	protocol_for_each_card(&isapnp_protocol, card) {
 		cards++;
 		if (isapnp_verbose) {
-			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
+			printk(KERN_INFO "isapnp: Card '%s'\n",
+			       card->name[0] ? card->name : "Unknown");
 			if (isapnp_verbose < 2)
 				continue;
-			card_for_each_dev(card,dev) {
-				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->name[0]?dev->name:"Unknown");
+			card_for_each_dev(card, dev) {
+				printk(KERN_INFO "isapnp:   Device '%s'\n",
+				       dev->name[0] ? dev->name : "Unknown");
 			}
 		}
 	}
 	if (cards) {
-		printk(KERN_INFO "isapnp: %i Plug & Play card%s detected total\n", cards, cards>1?"s":"");
+		printk(KERN_INFO
+		       "isapnp: %i Plug & Play card%s detected total\n", cards,
+		       cards > 1 ? "s" : "");
 	} else {
 		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
 	}
@@ -1141,11 +1176,10 @@
 
 static int __init isapnp_setup_isapnp(char *str)
 {
-	(void)((get_option(&str,&isapnp_rdp) == 2) &&
-	       (get_option(&str,&isapnp_reset) == 2) &&
-	       (get_option(&str,&isapnp_verbose) == 2));
+	(void)((get_option(&str, &isapnp_rdp) == 2) &&
+	       (get_option(&str, &isapnp_reset) == 2) &&
+	       (get_option(&str, &isapnp_verbose) == 2));
 	return 1;
 }
 
 __setup("isapnp=", isapnp_setup_isapnp);
-

--
