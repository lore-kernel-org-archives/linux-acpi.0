From: malattia@linux.it
Subject: [patch 5/9 v2] sonypi: try to detect if sony-laptop has already taken one of the known ioports
Date: Sat, 28 Apr 2007 23:34:10 +0900
Message-ID: <20070428143410.GE5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:60004 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbXD1Ofe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:35:34 -0400
Content-Disposition: inline; filename="0012-sonypi-try-to-avoid-clashing-with-sony-laptop.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Get the IO resources list in sony-laptop in the same order as listed
in sonypi and make sonypi check if one of those is already busy.
The sonypi check can be disabled by a module parameter in case the user
thinks we are plainly wrong (check_ioport=0).

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/char/sonypi.c
===================================================================
--- linux-2.6.orig/drivers/char/sonypi.c	2007-04-25 18:52:32.853467961 +0900
+++ linux-2.6/drivers/char/sonypi.c	2007-04-25 19:26:22.969157661 +0900
@@ -97,6 +97,11 @@ module_param(useinput, int, 0444);
 MODULE_PARM_DESC(useinput,
 		 "set this if you would like sonypi to feed events to the input subsystem");
 
+static int check_ioport = 1;
+module_param(check_ioport, int, 0444);
+MODULE_PARM_DESC(check_ioport,
+		 "set this to 0 if you think the automatic ioport check for sony-laptop is wrong");
+
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
 #define SONYPI_DEVICE_MODEL_TYPE3	3
@@ -1262,6 +1267,28 @@ static int __devinit sonypi_create_input
 static int __devinit sonypi_setup_ioports(struct sonypi_device *dev,
 				const struct sonypi_ioport_list *ioport_list)
 {
+	/* try to detect if sony-laptop is being used and thus
+	 * has already requested one of the known ioports.
+	 * As in the deprecated check_region this is racy has we have
+	 * multiple ioports available and one of them can be requested
+	 * between this check and the subsequent request. Anyway, as an
+	 * attempt to be some more user-friendly as we currently are,
+	 * this is enough.
+	 */
+	const struct sonypi_ioport_list *check = ioport_list;
+	while (check_ioport && check->port1) {
+		if (!request_region(check->port1,
+				   sonypi_device.region_size,
+				   "Sony Programable I/O Device Check")) {
+			printk(KERN_ERR "sonypi: ioport 0x%.4x busy, using sony-laptop? "
+					"if not use check_ioport=0\n",
+					check->port1);
+			return -EBUSY;
+		}
+		release_region(check->port1, sonypi_device.region_size);
+		check++;
+	}
+
 	while (ioport_list->port1) {
 
 		if (request_region(ioport_list->port1,
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-25 18:52:28.853240001 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-25 19:26:07.468274316 +0900
@@ -1801,7 +1801,7 @@ sony_pic_read_possible_resource(struct a
 				if (!interrupt)
 					return AE_ERROR;
 
-				list_add(&interrupt->list, &dev->interrupts);
+				list_add_tail(&interrupt->list, &dev->interrupts);
 				interrupt->irq.triggering = p->triggering;
 				interrupt->irq.polarity = p->polarity;
 				interrupt->irq.sharable = p->sharable;
@@ -1823,7 +1823,7 @@ sony_pic_read_possible_resource(struct a
 			if (!ioport)
 				return AE_ERROR;
 
-			list_add(&ioport->list, &dev->ioports);
+			list_add_tail(&ioport->list, &dev->ioports);
 			memcpy(&ioport->io, io, sizeof(*io));
 			return AE_OK;
 		}

--
mattia
:wq!
