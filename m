From: helgaas@ldl.fc.hp.com
Subject: [patch 07/17] PNP: Lindent resource.c
Date: Mon, 23 Jul 2007 15:28:04 -0600
Message-ID: <20070723213241.751546611@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52729 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881AbXGWVdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:09 -0400
Content-Disposition: inline; filename=pnp-format-resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/resource.c
===================================================================
--- work2.orig/drivers/pnp/resource.c	2007-07-23 12:11:09.000000000 -0600
+++ work2/drivers/pnp/resource.c	2007-07-23 12:11:54.000000000 -0600
@@ -3,7 +3,6 @@
  *
  * based on isapnp.c resource management (c) Jaroslav Kysela <perex@suse.cz>
  * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/module.h>
@@ -20,21 +19,19 @@
 #include <linux/pnp.h>
 #include "base.h"
 
-static int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
-static int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
-static int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
-static int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
-
+static int pnp_reserve_irq[16] = {[0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
+static int pnp_reserve_dma[8] = {[0 ... 7] = -1 };	/* reserve (don't use) some DMA */
+static int pnp_reserve_io[16] = {[0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
+static int pnp_reserve_mem[16] = {[0 ... 15] = -1 };	/* reserve (don't use) some memory region */
 
 /*
  * option registration
  */
 
-static struct pnp_option * pnp_build_option(int priority)
+static struct pnp_option *pnp_build_option(int priority)
 {
 	struct pnp_option *option = pnp_alloc(sizeof(struct pnp_option));
 
-	/* check if pnp_alloc ran out of memory */
 	if (!option)
 		return NULL;
 
@@ -46,9 +43,10 @@
 	return option;
 }
 
-struct pnp_option * pnp_register_independent_option(struct pnp_dev *dev)
+struct pnp_option *pnp_register_independent_option(struct pnp_dev *dev)
 {
 	struct pnp_option *option;
+
 	if (!dev)
 		return NULL;
 
@@ -61,9 +59,11 @@
 	return option;
 }
 
-struct pnp_option * pnp_register_dependent_option(struct pnp_dev *dev, int priority)
+struct pnp_option *pnp_register_dependent_option(struct pnp_dev *dev,
+						 int priority)
 {
 	struct pnp_option *option;
+
 	if (!dev)
 		return NULL;
 
@@ -82,6 +82,7 @@
 int pnp_register_irq_resource(struct pnp_option *option, struct pnp_irq *data)
 {
 	struct pnp_irq *ptr;
+
 	if (!option)
 		return -EINVAL;
 	if (!data)
@@ -110,6 +111,7 @@
 int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data)
 {
 	struct pnp_dma *ptr;
+
 	if (!option)
 		return -EINVAL;
 	if (!data)
@@ -129,6 +131,7 @@
 int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data)
 {
 	struct pnp_port *ptr;
+
 	if (!option)
 		return -EINVAL;
 	if (!data)
@@ -148,6 +151,7 @@
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data)
 {
 	struct pnp_mem *ptr;
+
 	if (!option)
 		return -EINVAL;
 	if (!data)
@@ -222,7 +226,6 @@
 	}
 }
 
-
 /*
  * resource validity checking
  */
@@ -236,11 +239,12 @@
 #define cannot_compare(flags) \
 ((flags) & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
 
-int pnp_check_port(struct pnp_dev * dev, int idx)
+int pnp_check_port(struct pnp_dev *dev, int idx)
 {
 	int tmp;
 	struct pnp_dev *tdev;
 	resource_size_t *port, *end, *tport, *tend;
+
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -250,8 +254,8 @@
 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
-	if(!dev->active) {
-		if (__check_region(&ioport_resource, *port, length(port,end)))
+	if (!dev->active) {
+		if (__check_region(&ioport_resource, *port, length(port, end)))
 			return 0;
 	}
 
@@ -259,7 +263,7 @@
 	for (tmp = 0; tmp < 8; tmp++) {
 		int rport = pnp_reserve_io[tmp << 1];
 		int rend = pnp_reserve_io[(tmp << 1) + 1] + rport - 1;
-		if (ranged_conflict(port,end,&rport,&rend))
+		if (ranged_conflict(port, end, &rport, &rend))
 			return 0;
 	}
 
@@ -268,7 +272,7 @@
 		if (dev->res.port_resource[tmp].flags & IORESOURCE_IO) {
 			tport = &dev->res.port_resource[tmp].start;
 			tend = &dev->res.port_resource[tmp].end;
-			if (ranged_conflict(port,end,tport,tend))
+			if (ranged_conflict(port, end, tport, tend))
 				return 0;
 		}
 	}
@@ -279,11 +283,12 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
 			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
-				if (cannot_compare(tdev->res.port_resource[tmp].flags))
+				if (cannot_compare
+				    (tdev->res.port_resource[tmp].flags))
 					continue;
 				tport = &tdev->res.port_resource[tmp].start;
 				tend = &tdev->res.port_resource[tmp].end;
-				if (ranged_conflict(port,end,tport,tend))
+				if (ranged_conflict(port, end, tport, tend))
 					return 0;
 			}
 		}
@@ -292,11 +297,12 @@
 	return 1;
 }
 
-int pnp_check_mem(struct pnp_dev * dev, int idx)
+int pnp_check_mem(struct pnp_dev *dev, int idx)
 {
 	int tmp;
 	struct pnp_dev *tdev;
 	resource_size_t *addr, *end, *taddr, *tend;
+
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -306,8 +312,8 @@
 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
-	if(!dev->active) {
-		if (check_mem_region(*addr, length(addr,end)))
+	if (!dev->active) {
+		if (check_mem_region(*addr, length(addr, end)))
 			return 0;
 	}
 
@@ -315,7 +321,7 @@
 	for (tmp = 0; tmp < 8; tmp++) {
 		int raddr = pnp_reserve_mem[tmp << 1];
 		int rend = pnp_reserve_mem[(tmp << 1) + 1] + raddr - 1;
-		if (ranged_conflict(addr,end,&raddr,&rend))
+		if (ranged_conflict(addr, end, &raddr, &rend))
 			return 0;
 	}
 
@@ -324,7 +330,7 @@
 		if (dev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
 			taddr = &dev->res.mem_resource[tmp].start;
 			tend = &dev->res.mem_resource[tmp].end;
-			if (ranged_conflict(addr,end,taddr,tend))
+			if (ranged_conflict(addr, end, taddr, tend))
 				return 0;
 		}
 	}
@@ -335,11 +341,12 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
 			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
-				if (cannot_compare(tdev->res.mem_resource[tmp].flags))
+				if (cannot_compare
+				    (tdev->res.mem_resource[tmp].flags))
 					continue;
 				taddr = &tdev->res.mem_resource[tmp].start;
 				tend = &tdev->res.mem_resource[tmp].end;
-				if (ranged_conflict(addr,end,taddr,tend))
+				if (ranged_conflict(addr, end, taddr, tend))
 					return 0;
 			}
 		}
@@ -353,11 +360,11 @@
 	return IRQ_HANDLED;
 }
 
-int pnp_check_irq(struct pnp_dev * dev, int idx)
+int pnp_check_irq(struct pnp_dev *dev, int idx)
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	resource_size_t * irq = &dev->res.irq_resource[idx].start;
+	resource_size_t *irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.irq_resource[idx].flags))
@@ -394,9 +401,9 @@
 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
-	if(!dev->active) {
+	if (!dev->active) {
 		if (request_irq(*irq, pnp_test_handler,
-				IRQF_DISABLED|IRQF_PROBE_SHARED, "pnp", NULL))
+				IRQF_DISABLED | IRQF_PROBE_SHARED, "pnp", NULL))
 			return 0;
 		free_irq(*irq, NULL);
 	}
@@ -407,7 +414,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
 			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
-				if (cannot_compare(tdev->res.irq_resource[tmp].flags))
+				if (cannot_compare
+				    (tdev->res.irq_resource[tmp].flags))
 					continue;
 				if ((tdev->res.irq_resource[tmp].start == *irq))
 					return 0;
@@ -418,12 +426,12 @@
 	return 1;
 }
 
-int pnp_check_dma(struct pnp_dev * dev, int idx)
+int pnp_check_dma(struct pnp_dev *dev, int idx)
 {
 #ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
-	resource_size_t * dma = &dev->res.dma_resource[idx].start;
+	resource_size_t *dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.dma_resource[idx].flags))
@@ -449,7 +457,7 @@
 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
-	if(!dev->active) {
+	if (!dev->active) {
 		if (request_dma(*dma, "pnp"))
 			return 0;
 		free_dma(*dma);
@@ -461,7 +469,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
-				if (cannot_compare(tdev->res.dma_resource[tmp].flags))
+				if (cannot_compare
+				    (tdev->res.dma_resource[tmp].flags))
 					continue;
 				if ((tdev->res.dma_resource[tmp].start == *dma))
 					return 0;
@@ -471,30 +480,18 @@
 
 	return 1;
 #else
-	/* IA64 hasn't legacy DMA */
+	/* IA64 does not have legacy DMA */
 	return 0;
 #endif
 }
 
-
-#if 0
-EXPORT_SYMBOL(pnp_register_dependent_option);
-EXPORT_SYMBOL(pnp_register_independent_option);
-EXPORT_SYMBOL(pnp_register_irq_resource);
-EXPORT_SYMBOL(pnp_register_dma_resource);
-EXPORT_SYMBOL(pnp_register_port_resource);
-EXPORT_SYMBOL(pnp_register_mem_resource);
-#endif  /*  0  */
-
-
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
-
 static int __init pnp_setup_reserve_irq(char *str)
 {
 	int i;
 
 	for (i = 0; i < 16; i++)
-		if (get_option(&str,&pnp_reserve_irq[i]) != 2)
+		if (get_option(&str, &pnp_reserve_irq[i]) != 2)
 			break;
 	return 1;
 }
@@ -502,13 +499,12 @@
 __setup("pnp_reserve_irq=", pnp_setup_reserve_irq);
 
 /* format is: pnp_reserve_dma=dma1[,dma2] .... */
-
 static int __init pnp_setup_reserve_dma(char *str)
 {
 	int i;
 
 	for (i = 0; i < 8; i++)
-		if (get_option(&str,&pnp_reserve_dma[i]) != 2)
+		if (get_option(&str, &pnp_reserve_dma[i]) != 2)
 			break;
 	return 1;
 }
@@ -516,13 +512,12 @@
 __setup("pnp_reserve_dma=", pnp_setup_reserve_dma);
 
 /* format is: pnp_reserve_io=io1,size1[,io2,size2] .... */
-
 static int __init pnp_setup_reserve_io(char *str)
 {
 	int i;
 
 	for (i = 0; i < 16; i++)
-		if (get_option(&str,&pnp_reserve_io[i]) != 2)
+		if (get_option(&str, &pnp_reserve_io[i]) != 2)
 			break;
 	return 1;
 }
@@ -530,13 +525,12 @@
 __setup("pnp_reserve_io=", pnp_setup_reserve_io);
 
 /* format is: pnp_reserve_mem=mem1,size1[,mem2,size2] .... */
-
 static int __init pnp_setup_reserve_mem(char *str)
 {
 	int i;
 
 	for (i = 0; i < 16; i++)
-		if (get_option(&str,&pnp_reserve_mem[i]) != 2)
+		if (get_option(&str, &pnp_reserve_mem[i]) != 2)
 			break;
 	return 1;
 }

--
