From: Tero Roponen <tero.roponen@gmail.com>
Subject: [PATCH] ACPI: Fix crash on ASUS laptops
Date: Sat, 17 Jan 2009 13:06:02 +0200 (EET)
Message-ID: <alpine.LFD.2.00.0901171303040.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:50409 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbZAQLFy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 06:05:54 -0500
Received: by ey-out-2122.google.com with SMTP id 22so373480eye.37
        for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2009 03:05:52 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: astarikovskiy@suse.de, len.brown@intel.com


This patch fixes the crash I experienced in 2.6.29-rc2.
Tested on ASUS M50vm.

Signed-off-by: Tero Roponen <tero.roponen@gmail.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a2b82c9..5c2f5d3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -982,7 +982,7 @@ int __init acpi_ec_ecdt_probe(void)
 		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 		if (!saved_ec)
 			return -ENOMEM;
-		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
+		memcpy(saved_ec, boot_ec, sizeof(*saved_ec));
 	/* fall through */
 	}
 	/* This workaround is needed only on some broken machines,
