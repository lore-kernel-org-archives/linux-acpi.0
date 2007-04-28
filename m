From: malattia@linux.it
Subject: [patch 4/9 v2] sonypi: suggest sonypi users to try sony-laptop instead
Date: Sat, 28 Apr 2007 23:22:11 +0900
Message-ID: <20070428142211.GD5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:45648 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbXD1OXe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:23:34 -0400
Content-Disposition: inline; filename="0011-sonypi-suggest-using-sony-laptop-instead.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Try to migrate sonypi users to sony-laptop gracefully.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/char/sonypi.c
===================================================================
--- linux-2.6.orig/drivers/char/sonypi.c	2007-04-25 13:08:11.676054561 +0900
+++ linux-2.6/drivers/char/sonypi.c	2007-04-25 16:19:38.830670196 +0900
@@ -1,6 +1,8 @@
 /*
  * Sony Programmable I/O Control Device driver for VAIO
  *
+ * Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
+ *
  * Copyright (C) 2001-2005 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2005 Narayanan R S <nars@kadamba.org>
@@ -1321,6 +1323,10 @@ static int __devinit sonypi_probe(struct
 	struct pci_dev *pcidev;
 	int error;
 
+	printk(KERN_WARNING "sonypi: please try the sony-laptop module instead "
+			"and report failures, see also "
+			"http://www.linux.it/~malattia/wiki/index.php/Sony_drivers\n");
+
 	spin_lock_init(&sonypi_device.fifo_lock);
 	sonypi_device.fifo = kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
 					 &sonypi_device.fifo_lock);

--
mattia
:wq!
