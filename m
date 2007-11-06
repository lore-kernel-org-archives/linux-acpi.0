From: Alex Williamson <alex.williamson@hp.com>
Subject: [PATCH] Hide _OSI warning if osi_linux is enabled
Date: Tue, 06 Nov 2007 12:11:56 -0700
Message-ID: <1194376316.31834.215.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel10.hp.com ([156.153.255.245]:59653 "EHLO palrel10.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbXKFTL6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Nov 2007 14:11:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>


   Seems like we don't need to print a big ugly warning when osi_linux
is already properly enabled.  Thanks,

	Alex

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
--

diff -r c7f1be4e5832 drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Thu Nov 01 12:09:33 2007 -0700
+++ b/drivers/acpi/osl.c	Tue Nov 06 12:08:38 2007 -0700
@@ -1167,14 +1167,15 @@ acpi_os_validate_interface (char *interf
 	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
 		return AE_OK;
 	if (!strcmp("Linux", interface)) {
+		if (osi_linux)
+			return AE_OK;
+
 		printk(KERN_WARNING PREFIX
 			"System BIOS is requesting _OSI(Linux)\n");
 		printk(KERN_WARNING PREFIX
 			"If \"acpi_osi=Linux\" works better,\n"
 			"Please send dmidecode "
 			"to linux-acpi@vger.kernel.org\n");
-		if(osi_linux)
-			return AE_OK;
 	}
 	return AE_SUPPORT;
 }


