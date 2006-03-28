From: akpm@osdl.org
Subject: [patch 10/26] ACPI: fix sonypi ACPI driver registration
Date: Tue, 28 Mar 2006 14:03:37 -0800
Message-ID: <200603282203.k2SM3hTM027677@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:52655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbWC1WDq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:03:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove the assumption that acpi_bus_register_driver() returns the number of
devices claimed.  Returning the count is unreliable because devices may be
hot-plugged in the future (admittedly not applicable for this driver).

This also fixes a bug: if sonypi_acpi_driver was registered but found no
devices, sonypi_exit() did not unregister it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/sonypi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/char/sonypi.c~acpi-fix-sonypi-acpi-driver-registration drivers/char/sonypi.c
--- devel/drivers/char/sonypi.c~acpi-fix-sonypi-acpi-driver-registration	2006-03-28 14:03:04.000000000 -0800
+++ devel-akpm/drivers/char/sonypi.c	2006-03-28 14:03:04.000000000 -0800
@@ -512,7 +512,7 @@ static struct sonypi_device {
 
 #ifdef CONFIG_ACPI
 static struct acpi_device *sonypi_acpi_device;
-static int acpi_enabled;
+static int acpi_driver_registered;
 #endif
 
 static int sonypi_ec_write(u8 addr, u8 value)
@@ -869,7 +869,7 @@ found:
 		sonypi_report_input_event(event);
 
 #ifdef CONFIG_ACPI
-	if (acpi_enabled)
+	if (sonypi_acpi_device)
 		acpi_bus_generate_event(sonypi_acpi_device, 1, event);
 #endif
 
@@ -1548,8 +1548,8 @@ static int __init sonypi_init(void)
 		goto err_free_device;
 
 #ifdef CONFIG_ACPI
-	if (acpi_bus_register_driver(&sonypi_acpi_driver) > 0)
-		acpi_enabled = 1;
+	if (acpi_bus_register_driver(&sonypi_acpi_driver) >= 0)
+		acpi_driver_registered = 1;
 #endif
 
 	return 0;
@@ -1564,7 +1564,7 @@ static int __init sonypi_init(void)
 static void __exit sonypi_exit(void)
 {
 #ifdef CONFIG_ACPI
-	if (acpi_enabled)
+	if (acpi_driver_registered)
 		acpi_bus_unregister_driver(&sonypi_acpi_driver);
 #endif
 	platform_device_unregister(sonypi_platform_device);
_
