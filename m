From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] acpi: add newline in power.c message
Date: Mon, 29 Oct 2012 10:25:19 -0700
Message-ID: <508EBBFF.2020803@xenotime.net>
References: <508D7CF7.1070707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:50491 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751596Ab2J2RZQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Oct 2012 13:25:16 -0400
In-Reply-To: <508D7CF7.1070707@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

=46rom: Randy Dunlap <rdunlap@xenotime.net>

Add newline to printk so that the message is on a line
by itself and not merged with something unrelated to it.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Reported-by: Toralf F=F6rster <toralf.foerster@gmx.de>
Cc:	Len Brown <lenb@kernel.org>
Cc:	Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-37-rc3.orig/drivers/acpi/power.c
+++ lnx-37-rc3/drivers/acpi/power.c
@@ -473,7 +473,7 @@ int acpi_power_resource_register_device(
 	return ret;
=20
 no_power_resource:
-	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!");
+	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!\n");
 	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(acpi_power_resource_register_device);
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
