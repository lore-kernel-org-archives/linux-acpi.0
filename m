From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/4] ACPI: fix sonypi ACPI driver registration
Date: Mon, 6 Feb 2006 17:18:46 -0700
Message-ID: <200602061718.46497.bjorn.helgaas@hp.com>
References: <200602061716.41470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:39631 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932389AbWBGATA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 19:19:00 -0500
In-Reply-To: <200602061716.41470.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Karol Kozimor <sziwan@hell.org.pl>, julien.lerouge@free.fr, acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Narayanan R S <nars@kadamba.org>, Andrew Morton <akpm@osdl.org>

Remove the assumption that acpi_bus_register_driver() returns the
number of devices claimed.  Returning the count is unreliable because
devices may be hot-plugged in the future (admittedly not applicable
for this driver).

This also fixes a bug: if sonypi_acpi_driver was registered but found
no devices, sonypi_exit() did not unregister it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/char/sonypi.c
===================================================================
--- work-mm4.orig/drivers/char/sonypi.c	2006-02-01 16:24:24.000000000 -0700
+++ work-mm4/drivers/char/sonypi.c	2006-02-06 16:30:37.000000000 -0700
@@ -512,7 +512,7 @@
 
 #ifdef CONFIG_ACPI
 static struct acpi_device *sonypi_acpi_device;
-static int acpi_enabled;
+static int acpi_driver_registered;
 #endif
 
 static int sonypi_ec_write(u8 addr, u8 value)
@@ -869,7 +869,7 @@
 		sonypi_report_input_event(event);
 
 #ifdef CONFIG_ACPI
-	if (acpi_enabled)
+	if (sonypi_acpi_device)
 		acpi_bus_generate_event(sonypi_acpi_device, 1, event);
 #endif
 
@@ -1548,8 +1548,8 @@
 		goto err_free_device;
 
 #ifdef CONFIG_ACPI
-	if (acpi_bus_register_driver(&sonypi_acpi_driver) > 0)
-		acpi_enabled = 1;
+	if (acpi_bus_register_driver(&sonypi_acpi_driver) >= 0)
+		acpi_driver_registered = 1;
 #endif
 
 	return 0;
@@ -1564,7 +1564,7 @@
 static void __exit sonypi_exit(void)
 {
 #ifdef CONFIG_ACPI
-	if (acpi_enabled)
+	if (acpi_driver_registered)
 		acpi_bus_unregister_driver(&sonypi_acpi_driver);
 #endif
 	platform_device_unregister(sonypi_platform_device);
