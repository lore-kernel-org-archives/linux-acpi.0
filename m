From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: PNP: simplify pnp_activate_dev() and pnp_disable_dev() return values
Date: Tue, 23 Oct 2007 14:46:18 -0600
Message-ID: <200710231446.18771.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:32774 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbXJWUqv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Oct 2007 16:46:51 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Make pnp_activate_dev() and pnp_disable_dev() return only 0 (success) or a
negative error value, as pci_enable_device() and pci_disable_device() do.

Previously they returned:

    0:	device was already active (or disabled)
    1:	we just activated (or disabled) device
    <0:	-EBUSY or error from pnp_start_dev() (or pnp_stop_dev())

Now we return only 0 (device is active or disabled) or <0 (error).

All in-tree callers either ignore the return values or check only for
errors (negative values).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/manager.c
===================================================================
--- w.orig/drivers/pnp/manager.c	2007-10-23 09:59:34.000000000 -0600
+++ w/drivers/pnp/manager.c	2007-10-23 10:45:32.000000000 -0600
@@ -513,7 +513,7 @@
 	int error;
 
 	if (dev->active)
-		return 0;	/* the device is already active */
+		return 0;
 
 	/* ensure resources are allocated */
 	if (pnp_auto_config_dev(dev))
@@ -524,7 +524,7 @@
 		return error;
 
 	dev->active = 1;
-	return 1;
+	return 0;
 }
 
 /**
@@ -538,7 +538,7 @@
 	int error;
 
 	if (!dev->active)
-		return 0;	/* the device is already disabled */
+		return 0;
 
 	error = pnp_stop_dev(dev);
 	if (error)
@@ -551,7 +551,7 @@
 	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 
-	return 1;
+	return 0;
 }
 
 /**
