From: Tobias Karnat <tobias.karnat@googlemail.com>
Subject: acpi_button: random oops on boot
Date: Sat, 04 Dec 2010 16:49:12 +0100
Message-ID: <1291477752.5096.27.camel@Tobias-Karnat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57146 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab0LDPtR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Dec 2010 10:49:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

I have a problem with random oopses on boot,
every 1 out of 5 times I boot linux freezes.

I was not able to obtain a call trace, however it happens around 10-15
seconds after boot. I can hear that the tg3 driver is initialised.

In this thread, they have the same problem:
https://bugzilla.novell.com/show_bug.cgi?id=647029

Applying the patch from the thread, makes the problem occurring less
often and dmesg shows acpi-button loads for me on hid PNP0C0C and
LNXPWRBN.

Maybe commit e2fb9754d27513918a4936e8cbaad50ff56cfd3d
ACPI: button: remove unnecessary null pointer checks
has unmasked an underlying problem?

-Tobias

--- a/drivers/acpi/button.c	2010-11-22 20:03:49.000000000 +0100
+++ b/drivers/acpi/button.c	2010-12-04 14:11:51.000000000 +0100
@@ -353,9 +353,13 @@
 		goto err_free_button;
 	}
 
+	printk(KERN_INFO PREFIX "button loading\n");
 	hid = acpi_device_hid(device);
+	printk(KERN_INFO PREFIX "hid: <%s>\n", hid);
 	name = acpi_device_name(device);
+	printk(KERN_INFO PREFIX "name: <%s>\n", name);
 	class = acpi_device_class(device);
+	printk(KERN_INFO PREFIX "class: <%s>\n", class);
 
 	if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {

