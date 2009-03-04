From: akpm@linux-foundation.org
Subject: [patch 5/8] acpi: bus.c, remove doubled status checking
Date: Wed, 04 Mar 2009 11:55:27 -0800
Message-ID: <200903041955.n24JtSHW028000@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59344 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756178AbZCDT4K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 14:56:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, jirislaby@gmail.com

From: Jiri Slaby <jirislaby@gmail.com>

There was a misplaced status test (two consequent tests without a
statement in between) in acpi_bus_init for ages.  Remove it, since the
function which should be checked (acpi_os_initialize1) has BUG_ONs on
failure paths.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/bus.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff -puN drivers/acpi/bus.c~acpi-busc-remove-doubled-status-checking drivers/acpi/bus.c
--- a/drivers/acpi/bus.c~acpi-busc-remove-doubled-status-checking
+++ a/drivers/acpi/bus.c
@@ -758,8 +758,7 @@ static int __init acpi_bus_init(void)
 	acpi_status status = AE_OK;
 	extern acpi_status acpi_os_initialize1(void);
 
-
-	status = acpi_os_initialize1();
+	acpi_os_initialize1();
 
 	status =
 	    acpi_enable_subsystem(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE);
@@ -769,12 +768,6 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to initialize ACPI OS objects\n");
-		goto error1;
-	}
-
 	/*
 	 * ACPI 2.0 requires the EC driver to be loaded and work before
 	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
_
