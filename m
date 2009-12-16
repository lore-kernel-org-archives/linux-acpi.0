From: Len Brown <lenb@kernel.org>
Subject: [PATCH 022/103] asus-acpi: Remove uneccesary acpi_disabled checks
Date: Wed, 16 Dec 2009 03:35:33 -0500
Message-ID: <5a4a9f6fd3dedefe06aed0e35c76bb6e0177adb6.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761858AbZLPJGT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:19 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:59 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

acpi_bus_register_driver() already checks acpi_disabled, so acpi bus
drivers don't need to.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

