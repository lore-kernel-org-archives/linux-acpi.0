From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 05/33] asus-acpi: Remove uneccesary acpi_disabled checks
Date: Thu,  3 Dec 2009 08:44:49 +0100
Message-ID: <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44216 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbZLCHoc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:32 -0500
In-Reply-To: <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

acpi_bus_register_driver() already checks acpi_disabled, so acpi bus
drivers don't need to.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/asus_acpi.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index 25a7d57..783243f 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -1416,21 +1416,17 @@ static int __init asus_acpi_init(void)
 {
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
+	result = acpi_bus_register_driver(&asus_hotk_driver);
+	if (result < 0)
+		return result;
 
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
 	if (!asus_proc_dir) {
 		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry\n");
+		acpi_bus_unregister_driver(&asus_hotk_driver);
 		return -ENODEV;
 	}
 
-	result = acpi_bus_register_driver(&asus_hotk_driver);
-	if (result < 0) {
-		remove_proc_entry(PROC_ASUS, acpi_root_dir);
-		return result;
-	}
-
 	/*
 	 * This is a bit of a kludge.  We only want this module loaded
 	 * for ASUS systems, but there's currently no way to probe the
-- 
1.6.5.3

