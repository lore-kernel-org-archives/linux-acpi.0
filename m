From: akpm@osdl.org
Subject: [patch 03/13] acpi-update-asus_acpi-driver-registration-fix
Date: Mon, 10 Apr 2006 23:16:52 -0700
Message-ID: <200604110717.k3B7HXOK014902@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:35460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbWDKHRk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Apr 2006 03:17:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com, romieu@fr.zoreil.com


From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/asus_acpi.c~acpi-update-asus_acpi-driver-registration-fix drivers/acpi/asus_acpi.c
--- devel/drivers/acpi/asus_acpi.c~acpi-update-asus_acpi-driver-registration-fix	2006-04-10 23:16:19.000000000 -0700
+++ devel-akpm/drivers/acpi/asus_acpi.c	2006-04-10 23:16:19.000000000 -0700
@@ -1232,7 +1232,7 @@ static int __init asus_acpi_init(void)
 	result = acpi_bus_register_driver(&asus_hotk_driver);
 	if (result < 0) {
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
-		return -ENODEV;
+		return result;
 	}
 
 	/*
_
