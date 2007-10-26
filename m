From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH] fujitsu-laptop: kzalloc and autoload
Date: Thu, 25 Oct 2007 22:34:06 -0700
Message-ID: <20071025223406.664c17c9@shemminger-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34450 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747AbXJZFeX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Oct 2007 01:34:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

A couple of minor changes to the fujitsu laptop acpi driver.
1. use kzalloc.
2. add dmi aliases to get the driver to autoload.
    note: use both spellings since different fujtisu laptop's seem to capitialize
    differently.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>


--- a/drivers/misc/fujitsu-laptop.c	2007-10-22 15:06:02.000000000 -0700
+++ b/drivers/misc/fujitsu-laptop.c	2007-10-22 15:07:15.000000000 -0700
@@ -61,6 +61,9 @@
 #define ACPI_FUJITSU_DRIVER_NAME        "Fujitsu laptop FUJ02B1 ACPI extras driver"
 #define ACPI_FUJITSU_DEVICE_NAME        "Fujitsu FUJ02B1"
 
+MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
+MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
+
 struct fujitsu_t {
 	acpi_handle acpi_handle;
 	struct backlight_device *bl_device;
@@ -264,10 +267,9 @@ static int __init fujitsu_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	fujitsu = kmalloc(sizeof(struct fujitsu_t), GFP_KERNEL);
+	fujitsu = kzalloc(sizeof(struct fujitsu_t), GFP_KERNEL);
 	if (!fujitsu)
 		return -ENOMEM;
-	memset(fujitsu, 0, sizeof(struct fujitsu_t));
 
 	result = acpi_bus_register_driver(&acpi_fujitsu_driver);
 	if (result < 0) {
