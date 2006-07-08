From: Luca Tettamanti <kronos.it@gmail.com>
Subject: [PATCH] Add missing '\n' to printk in ACPI code
Date: Sat, 8 Jul 2006 21:24:31 +0200
Message-ID: <20060708192431.GA23511@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:42181 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030236AbWGHTYR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Jul 2006 15:24:17 -0400
Received: by nf-out-0910.google.com with SMTP id p77so138653nfc
        for <linux-acpi@vger.kernel.org>; Sat, 08 Jul 2006 12:24:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, akpm@osdl.org

Hi,
I found out that a printk() in ACPI code is missing the newline; the
next kernel message is then appended on the same line (and priority is
not stripped), eg:

Device `[FAN0]' is not power manageable<6>ACPI: Fan [FAN0] (on)

This trivial patch (against 2.6.18-rc1) fixes it.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

--- a/drivers/acpi/bus.c	2006-07-08 15:12:32.855837715 +0200
+++ b/drivers/acpi/bus.c	2006-07-08 15:12:46.848712215 +0200
@@ -192,7 +192,7 @@
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		printk(KERN_DEBUG "Device `[%s]' is not power manageable",
+		printk(KERN_DEBUG "Device `[%s]' is not power manageable\n",
 				device->kobj.name);
 		return -ENODEV;
 	}



Luca
-- 
Home: http://kronoz.cjb.net
Il piu` bel momento dell'amore e` quando ci si illude che duri per 
sempre; il piu` brutto, quando ci si accorge che dura da troppo.
