From: Darren Jenkins <darrenrjenkins@gmail.com>
Subject: [PATCH] drivers/acpi/ec.c fix a small memory leak
Date: Tue, 02 Feb 2010 23:12:10 +1100
Message-ID: <1265112730.4804.8.camel@ICE-BOX>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:56447 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0BBMMP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 07:12:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kernel Janitors <kernel-janitors@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, astarikovskiy@suse.de

Plug a very small leak in acpi_ec_ecdt_probe()

Coverity CID: 13319

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com> 

diff --git drivers/acpi/ec.c drivers/acpi/ec.c
index d6471bb..13061dc 100644
--- drivers/acpi/ec.c
+++ drivers/acpi/ec.c
@@ -1009,8 +1009,10 @@ int __init acpi_ec_ecdt_probe(void)
 	/* fall through */
 	}
 
-	if (EC_FLAGS_SKIP_DSDT_SCAN)
+	if (EC_FLAGS_SKIP_DSDT_SCAN) {
+		kfree(saved_ec);
 		return -ENODEV;
+	}
 
 	/* This workaround is needed only on some broken machines,
 	 * which require early EC, but fail to provide ECDT */


