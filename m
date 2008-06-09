From: akpm@linux-foundation.org
Subject: [patch 10/11] dock.c remove trailing printk whitespace
Date: Mon, 09 Jun 2008 16:22:25 -0700
Message-ID: <200806092322.m59NMPRM013982@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54048 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753507AbYFIXXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:23:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, lnxninja@linux.vnet.ibm.com

From: Tim Pepper <lnxninja@linux.vnet.ibm.com>

Signed-off-by: Tim Pepper <lnxninja@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/dock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/dock.c~dockc-remove-trailing-printk-whitespace drivers/acpi/dock.c
--- a/drivers/acpi/dock.c~dockc-remove-trailing-printk-whitespace
+++ a/drivers/acpi/dock.c
@@ -834,7 +834,7 @@ static int dock_add(acpi_handle handle)
 		goto dock_add_err;
 	}
 
-	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_DESCRIPTION);
+	printk(KERN_INFO PREFIX "%s\n", ACPI_DOCK_DRIVER_DESCRIPTION);
 
 	return 0;
 
_
