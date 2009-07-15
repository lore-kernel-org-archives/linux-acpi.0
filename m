From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 8/8] i8042: support device async suspend & shutdown
Date: Wed, 15 Jul 2009 15:38:42 +0800
Message-ID: <1247643522.26272.83.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753225AbZGOHiM@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org


i8042 controller support device async actions.

If boot option "dev_async_action" is added,
i8042 controller and its child devices can be
suspended/resumed/shutdown asynchronously.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/input/serio/i8042.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/i8042.c
+++ linux-2.6/drivers/input/serio/i8042.c
@@ -1284,14 +1284,21 @@ static int __init i8042_init(void)
 		goto err_unregister_driver;
 	}
 
-	err = platform_device_add(i8042_platform_device);
+	err = dev_async_register(&i8042_platform_device->dev,
+			DEV_ASYNC_SUSPEND | DEV_ASYNC_SHUTDOWN);
 	if (err)
 		goto err_free_device;
 
+	err = platform_device_add(i8042_platform_device);
+	if (err)
+		goto err_dev_async_unregister;
+
 	panic_blink = i8042_panic_blink;
 
 	return 0;
 
+ err_dev_async_unregister:
+	dev_async_unregister(&i8042_platform_device->dev);
  err_free_device:
 	platform_device_put(i8042_platform_device);
  err_unregister_driver:
@@ -1304,6 +1311,7 @@ static int __init i8042_init(void)
 
 static void __exit i8042_exit(void)
 {
+	dev_async_unregister(&i8042_platform_device->dev);
 	platform_device_unregister(i8042_platform_device);
 	platform_driver_unregister(&i8042_driver);
 	i8042_platform_exit();
