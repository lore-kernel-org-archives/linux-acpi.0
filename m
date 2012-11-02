From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH] acpi: add missing newline to printk
Date: Fri,  2 Nov 2012 14:51:18 -0200
Message-ID: <1351875078-5843-1-git-send-email-cesarb@cesarb.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-02.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-acpi@vger.kernel.org>; 2 Nov 2012 16:51:38 -0000
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, trivial@kernel.org, Cesar Eduardo Barros <cesarb@cesarb.net>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

The missing newline causes messages like this on dmesg:

[    2.578212] ACPI: Invalid Power Resource to register!<5>[2.578456] ...

Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 40e38a0..7db61b8 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -473,7 +473,7 @@ int acpi_power_resource_register_device(struct device *dev, acpi_handle handle)
 	return ret;
 
 no_power_resource:
-	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!");
+	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!\n");
 	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(acpi_power_resource_register_device);
-- 
1.7.11.7
