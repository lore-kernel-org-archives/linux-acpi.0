From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: use _STA bit names rather than 0x0F
Date: Fri, 20 Apr 2007 10:56:51 -0600
Message-ID: <200704201056.51472.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:44413 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993287AbXDTQ5K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Apr 2007 12:57:10 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Be explicit about what "device->status = 0x0F" really means.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/acpi/scan.c
===================================================================
--- w.orig/drivers/acpi/scan.c	2007-04-19 21:35:42.000000000 -0600
+++ w/drivers/acpi/scan.c	2007-04-19 21:36:50.000000000 -0600
@@ -1068,7 +1068,9 @@
 		}
 		break;
 	default:
-		STRUCT_TO_INT(device->status) = 0x0F;
+		STRUCT_TO_INT(device->status) =
+		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
+		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
 		break;
 	}
 
Index: w/drivers/acpi/bus.c
===================================================================
--- w.orig/drivers/acpi/bus.c	2007-04-19 21:35:42.000000000 -0600
+++ w/drivers/acpi/bus.c	2007-04-19 21:37:52.000000000 -0600
@@ -103,7 +103,9 @@
 	else if (device->parent)
 		device->status = device->parent->status;
 	else
-		STRUCT_TO_INT(device->status) = 0x0F;
+		STRUCT_TO_INT(device->status) =
+		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
+		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
 
 	if (device->status.functional && !device->status.present) {
 		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
