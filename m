From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: asus_acpi: return -ENODEV when no device found
Date: Wed, 25 Oct 2006 13:58:24 -0600
Message-ID: <200610251358.25379.bjorn.helgaas@hp.com>
References: <20061020092547.519734000@neutrino.suse.de> <200610230934.12775.bjorn.helgaas@hp.com> <200610241105.52562.fseidel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:10432 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964798AbWJYT6c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 15:58:32 -0400
In-Reply-To: <200610241105.52562.fseidel@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank Seidel <fseidel@suse.de>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

This driver is for non-hot-pluggable hardware.  Therefore, if the hardware
isn't present, we want to return -ENODEV so a module load will fail.

We previously returned "result" from the acpi_bus_register_driver() call.
Registering the driver usually succeeds even if no devices are present,
because the ACPI core allows you to load a driver before a device is
hot-added.

Someday the kernel will expose enough information so user-space can tell
what ACPI drivers should be loaded.  But the kernel doesn't do that yet, so
distros have to load this driver always and rely on the -ENODEV causing the
load to fail if the hardware isn't found.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-1/drivers/acpi/asus_acpi.c
===================================================================
--- work-1.orig/drivers/acpi/asus_acpi.c	2006-10-24 15:35:24.000000000 -0600
+++ work-1/drivers/acpi/asus_acpi.c	2006-10-24 15:37:54.000000000 -0600
@@ -1367,7 +1367,7 @@
 	if (!asus_hotk_found) {
 		acpi_bus_unregister_driver(&asus_hotk_driver);
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
-		return result;
+		return -ENODEV;
 	}
 
 	return 0;
