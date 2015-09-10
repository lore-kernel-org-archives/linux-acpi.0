From: Rami Rosen <ramirose@gmail.com>
Subject: [PATCH] ACPI: change init_acpi_device_notify() to return void.
Date: Thu, 10 Sep 2015 23:48:09 +0300
Message-ID: <1441918089-27368-1-git-send-email-ramirose@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36639 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbbIJUs0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2015 16:48:26 -0400
Received: by wicgb1 with SMTP id gb1so39642833wic.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2015 13:48:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Rami Rosen <ramirose@gmail.com>

This patch changes the type of the return value of the init_acpi_device_notify() 
method to be void, as this method never fails and its return value is never
used.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 drivers/acpi/glue.c     | 5 ++---
 drivers/acpi/internal.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index b9657af..1470ae4 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -351,13 +351,12 @@ static int acpi_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-int __init init_acpi_device_notify(void)
+void __init init_acpi_device_notify(void)
 {
 	if (platform_notify || platform_notify_remove) {
 		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
-		return 0;
+		return;
 	}
 	platform_notify = acpi_platform_notify;
 	platform_notify_remove = acpi_platform_notify_remove;
-	return 0;
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9e42621..e72c6a6 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -21,7 +21,7 @@
 #define PREFIX "ACPI: "
 
 acpi_status acpi_os_initialize1(void);
-int init_acpi_device_notify(void);
+void init_acpi_device_notify(void);
 int acpi_scan_init(void);
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
-- 
2.4.3

