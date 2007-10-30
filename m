From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: kzalloc and autoload
Date: Tue, 30 Oct 2007 16:25:37 +1030 (CST)
Message-ID: <200710300555.l9U5tbxh021802@sprite.physics.adelaide.edu.au>
References: <20071025223406.664c17c9@shemminger-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:59169 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752818AbXJ3GVu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 02:21:50 -0400
In-Reply-To: <20071025223406.664c17c9@shemminger-laptop> from "Stephen Hemminger" at Oct 25, 2007 10:34:06 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

> A couple of minor changes to the fujitsu laptop acpi driver.
> 1. use kzalloc.
> 2. add dmi aliases to get the driver to autoload.
>     note: use both spellings since different fujtisu laptop's seem to capitialize
>     differently.
> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

Looks sensible to me.

Ack.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Regards
  jonathan


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
-
