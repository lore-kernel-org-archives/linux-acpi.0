From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 10/22]  Generic Backlight support
Date: Tue, 19 Dec 2006 22:19:43 +0100
Message-ID: <200612192219.43162.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50214 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933026AbWLSV0L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:11 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Add /sys/class/backlight support.
I needed to add this ugly hack
 "asus_backlight_device->props->update_status = NULL;" 
berfore backlight_unregister, because if i don't the brightness
will be set to 0 on module unload ...

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 Kconfig     |    9 ++--
 asus_acpi.c |  110 
+++++++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 85 insertions(+), 34 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 13:18:23.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 13:33:05.000000000 +0100
@@ -33,11 +33,14 @@
  *
  */

+#include <linux/autoconf.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -442,6 +445,21 @@
                },
 };

+/* The backlight device /sys/class/backlight */
+static struct backlight_device *asus_backlight_device;
+
+/*
+ * The backlight class declaration
+ */
+static int read_brightness(struct backlight_device *bd);
+static int update_bl_status(struct backlight_device *bd);
+static struct backlight_properties asusbl_data = {
+              .owner          = THIS_MODULE,
+              .get_brightness = read_brightness,
+              .update_status  = update_bl_status,
+              .max_brightness = 15,
+};
+
 /*
  * Take a string describing a method,
  * parse it, and store the result into mt
@@ -798,7 +816,7 @@
        return rv;
 }

-static int read_brightness(void)
+static int read_brightness(struct backlight_device *bd)
 {
        int value;

@@ -820,39 +838,56 @@
 /*
  * Change the brightness level
  */
-static void set_brightness(int value)
+static int set_brightness(struct backlight_device *bd, int value)
 {
        acpi_status status = 0;
+       int ret = 0;
+
+       value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+       /* 0 <= value <= 15 */

        /* SPLV laptop */
        if (hotk->methods->brightness_set) {
                if (!write_acpi_int(hotk->handle, 
hotk->methods->brightness_set,
-                                   value, NULL))
+                                   value, NULL)) {
                        printk(KERN_WARNING
                               "Asus ACPI: Error changing brightness\n");
-               return;
+                       ret = -EIO;
+                       goto out;
+               }
+       } else {
+               /* No SPLV method if we are here, act as appropriate */
+               value -= read_brightness(NULL);
+               while (value != 0) {
+                       status = acpi_evaluate_object(NULL, (value > 0) ?
+                                                     
hotk->methods->brightness_up :
+                                                     
hotk->methods->brightness_down,
+                                                     NULL, NULL);
+                       (value > 0) ? value-- : value++;
+                       if (ACPI_FAILURE(status)) {
+                               printk(KERN_WARNING
+                                      "Asus ACPI: Error changing 
brightness\n");
+                               ret = -EIO;
+                       }
+               }
        }

-       /* No SPLV method if we are here, act as appropriate */
-       value -= read_brightness();
-       while (value != 0) {
-               status = acpi_evaluate_object(NULL, (value > 0) ?
-                                             hotk->methods->brightness_up :
-                                             hotk->methods->brightness_down,
-                                             NULL, NULL);
-               (value > 0) ? value-- : value++;
-               if (ACPI_FAILURE(status))
-                       printk(KERN_WARNING
-                              "Asus ACPI: Error changing brightness\n");
-       }
-       return;
+out:
+       return ret;
+}
+
+static int update_bl_status(struct backlight_device *bd)
+{
+       int value = bd->props->brightness;
+
+       return set_brightness(bd, value);
 }

 static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
              void *data)
 {
-       return sprintf(page, "%d\n", read_brightness());
+       return sprintf(page, "%d\n", read_brightness(NULL));
 }

 static int
@@ -863,9 +898,7 @@

        rv = parse_arg(buffer, count, &value);
        if (rv > 0) {
-               value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
-               /* 0 <= value <= 15 */
-               set_brightness(value);
+               set_brightness(NULL, value);
        }
        return rv;
 }
@@ -1426,6 +1459,22 @@
        return 0;
 }

+static void __exit asus_acpi_exit(void)
+{
+       if(asus_backlight_device) {
+               /* Ugly Hack ...*/
+               asus_backlight_device->props->update_status = NULL;
+               backlight_device_unregister(asus_backlight_device);
+       }
+
+       acpi_bus_unregister_driver(&asus_hotk_driver);
+       remove_proc_entry(PROC_ASUS, acpi_root_dir);
+
+       kfree(asus_info);
+
+       return;
+}
+
 static int __init asus_acpi_init(void)
 {
        int result;
@@ -1460,20 +1509,21 @@
        if (!asus_hotk_found) {
                acpi_bus_unregister_driver(&asus_hotk_driver);
                remove_proc_entry(PROC_ASUS, acpi_root_dir);
-               return result;
+               return -ENODEV;
        }

-       return 0;
-}
+       asus_backlight_device = backlight_device_register ("asus", NULL,
+                                                          &asusbl_data);

-static void __exit asus_acpi_exit(void)
-{
-       acpi_bus_unregister_driver(&asus_hotk_driver);
-       remove_proc_entry(PROC_ASUS, acpi_root_dir);
+       if (IS_ERR (asus_backlight_device)) {
+               printk(KERN_ERR "Could not register asus backlight device\n");
+               asus_backlight_device = NULL;
+               asus_acpi_exit();
+       }

-       kfree(asus_info);
+       asus_backlight_device->props->brightness = read_brightness(NULL);

-       return;
+       return 0;
 }

 module_init(asus_acpi_init);
--- a/drivers/acpi/Kconfig      2006-12-13 20:59:36.000000000 +0100
+++ b/drivers/acpi/Kconfig      2006-12-15 13:26:29.000000000 +0100
@@ -172,6 +172,7 @@
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
        depends on X86
+       select BACKLIGHT_CLASS_DEVICE
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may 
also
@@ -190,13 +191,13 @@
           parameters.

           More information and a userspace daemon for handling the extra 
buttons
-          at <http://sourceforge.net/projects/acpi4asus/>.
+          at <<http://acpi4asus.sourceforge.net/>.

           If you have an ACPI-compatible ASUS laptop, say Y or M here. This
           driver is still under development, so if your laptop is unsupported 
or
-          something works not quite as expected, please use the mailing list
-          available on the above page (acpi4asus-user@lists.sourceforge.net)
-
+          something works not quite as expected, please post a bug at
+         <http://acpi4asus.sourceforge.net/>.
+
 config ACPI_IBM
        tristate "IBM ThinkPad Laptop Extras"
        depends on X86


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

