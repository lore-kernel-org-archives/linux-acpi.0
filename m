From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ibm-acpi: rename backlight device
Date: Sat, 28 Oct 2006 13:34:26 -0300
Message-ID: <20061028163426.GA7785@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47595 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751017AbWJ1Qee (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Oct 2006 12:34:34 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Holger Macht <hmacht@suse.de>
Cc: Borislav Deianov <borislav@users.sourceforge.net>, Andy Whitcroft <apw@shadowen.org>

The ThinkPad can connect to more than one flat pannel display using the
external VGA or DVI output, which we may be able to control over DCC
someday.  

Also, Lenovo may introduce a ThinkPad with more than one internal LCD
screen in the future.  Or we could have LCD gadgets from ibm with
backlights connected to the ThinkPad...

This patch renames the main backlight device from "ibm" to
"thinkpad_builtin_screen", which is far more descriptive and future-proof.

Maybe the backlight devices refering to the built-in screen of laptops
should even be renamed to just "builtin_screen" on all of the drivers?

Please comment.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Borislav Deianov <borislav@users.sourceforge.net>
Cc: Holger Macht <hmacht@suse.de>
Cc: Andy Whitcroft <apw@shadowen.org>

Index: 2.6.18/drivers/acpi/ibm_acpi.c
===================================================================
--- 2.6.18.orig/drivers/acpi/ibm_acpi.c
+++ 2.6.18/drivers/acpi/ibm_acpi.c
@@ -2072,10 +2072,10 @@ static int __init acpi_ibm_init(void)
 		}
 	}
 
-	ibm_backlight_device = backlight_device_register("ibm", NULL,
+	ibm_backlight_device = backlight_device_register("thinkpad_builtin_screen", NULL,
 							 &ibm_backlight_data);
         if (IS_ERR(ibm_backlight_device)) {
-		printk(IBM_ERR "Could not register ibm backlight device\n");
+		printk(IBM_ERR "Could not register thinkpad_builtin_screen backlight device\n");
 		ibm_backlight_device = NULL;
 		acpi_ibm_exit();
 	}
