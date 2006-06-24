From: akpm@osdl.org
Subject: [patch 17/18] drivers/acpi/scan.c: make acpi_bus_type static
Date: Sat, 24 Jun 2006 16:37:24 -0700
Message-ID: <200606242337.k5ONbOaw008128@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:19101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbWFXXsF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:48:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bunk@stusta.de


From: Adrian Bunk <bunk@stusta.de>

Make the needlessly global acpi_bus_type static.

I'd also suggest to rename this struct, since although it's named
acpi_bus_type, it's of type "struct bus_type", not "struct acpi_bus_type"
as defined in include/acpi/acpi_bus.h .

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/scan.c~drivers-acpi-scanc-make-acpi_bus_type-static drivers/acpi/scan.c
--- a/drivers/acpi/scan.c~drivers-acpi-scanc-make-acpi_bus_type-static
+++ a/drivers/acpi/scan.c
@@ -1450,7 +1450,7 @@ static int acpi_device_resume(struct dev
 }
 
 
-struct bus_type acpi_bus_type = {
+static struct bus_type acpi_bus_type = {
 	.name		= "acpi",
 	.suspend	= acpi_device_suspend,
 	.resume		= acpi_device_resume,
_
