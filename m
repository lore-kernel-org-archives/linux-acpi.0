From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] 2.6.0-test4 ACPI fixes series (3/4)
Date: Sat, 6 Sep 2003 01:57:40 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309060157.40420.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F590E28.6090101-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
To: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch is actually a patch by "Jun Nakajima" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
When setting an IRQ link device, it checks if the value returned by _CRS is
0. If so, it assumes everything went OK. This fixes problems on MANY VIA
bioses. It seems to be a standard-ish way of saying "the _CRS IRQ setting
cannot be read".


--- linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	2003-09-05 23:54:59.945755216 +0100
+++ linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c	2003-09-05 23:57:39.782456344 +0100
@@ -277,6 +277,32 @@
 
 
 static int
+acpi_pci_link_try_get_current (
+	struct acpi_pci_link *link,
+	int irq)
+{
+	int result;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+   
+	result = acpi_pci_link_get_current(link);
+	if (result && link->irq.active) 
+	{
+		return_VALUE(result);
+	}
+
+	if (!link->irq.active) 
+	{
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ resource found\n"));
+		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for device (%s [%s]).\n", irq, acpi_device_name(link->device), acpi_device_bid(link->device));
+		link->irq.active = irq;
+	}
+   
+	return 0;
+}
+
+
+static int
 acpi_pci_link_set (
 	struct acpi_pci_link	*link,
 	int			irq)
@@ -382,7 +408,7 @@
 	}
 
 	/* Make sure the active IRQ is the one we requested. */
-	result = acpi_pci_link_get_current(link);
+	result = acpi_pci_link_try_get_current(link, irq);
 	if (result) {
 		return_VALUE(result);
 	}
@@ -600,10 +626,6 @@
 		else
 			printk(" %d", link->irq.possible[i]);
 	}
-	if (!link->irq.active)
-		printk(", disabled");
-	else if (!found)
-		printk(", enabled at IRQ %d", link->irq.active);
 	printk(")\n");
 
 	/* TBD: Acquire/release lock */
