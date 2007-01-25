From: Corentin CHARY <corentincj@iksaif.net>
Subject: [patch 2/7] asus-laptop: add led support
Date: Thu, 25 Jan 2007 12:54:43 +0100
Message-ID: <200701251254.43674.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35182 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932792AbXAYLyw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 06:54:52 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Add led support, using generic led class.
Thomas Tuttle's patch <http://lkml.org/lkml/2006/7/6/247> was very usefull.
We use hotk->status to store led status because it's very hard to find acpi method
to get the right status...
To reduce the code, I use a lot of macro (ASUS_LED, ASUS_LED_REGISTER, etc ...), because
the code is the same for all leds ...

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
 Kconfig       |    1
 asus-laptop.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
---

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-21 15:27:49.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-21 15:24:46.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
@@ -54,6 +55,14 @@
 #define ASUS_HOTK_FILE          "asus-laptop"
 #define ASUS_HOTK_PREFIX        "\\_SB.ATKD."
 
+/*
+ * Flags for hotk status
+ */
+#define MLED_ON     0x04	//mail LED
+#define TLED_ON     0x08	//touchpad LED
+#define RLED_ON     0x10        //Record LED
+#define PLED_ON     0x20        //Phone LED
+
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
 #define ASUS_WARNING    KERN_WARNING    ASUS_LOG
@@ -69,6 +78,12 @@
 	static acpi_handle  object##_handle = NULL;			\
 	static char *object##_paths[] = { paths }
 
+/* LED */
+ASUS_HANDLE(mled_set, ASUS_HOTK_PREFIX "MLED");
+ASUS_HANDLE(tled_set, ASUS_HOTK_PREFIX "TLED");
+ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); /* W1JC */
+ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); /* A7J */
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -106,6 +121,28 @@
 		},
 };
 
+/* These functions actually update the LED's, and are called from a
+ * workqueue. By doing this as separate work rather than when the LED
+ * subsystem asks, we avoid messing with the Asus ACPI stuff during a
+ * potentially bad time, such as a timer interrupt. */
+static struct workqueue_struct *led_workqueue;
+
+#define ASUS_LED(object, ledname)					\
+	static void object##_led_set(struct led_classdev *led_cdev,	\
+				     enum led_brightness value);	\
+	static void object##_led_update(struct work_struct *ignored);	\
+	static int object##_led_wk;					\
+	DECLARE_WORK(object##_led_work, object##_led_update);		\
+	static struct led_classdev object##_led = {			\
+		.name           = "asus:" ledname,			\
+		.brightness_set = object##_led_set,			\
+	}
+
+ASUS_LED(mled, "mail");
+ASUS_LED(tled, "touchpad");
+ASUS_LED(rled, "record");
+ASUS_LED(pled, "phone");
+
 /*
  * This function evaluates an ACPI method, given an int as parameter, the
  * method is searched within the scope of the handle, can be NULL. The output
@@ -144,6 +181,44 @@
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
 
+/* Generic LED functions */
+static int read_led(int ledmask)
+{
+	return (hotk->status & ledmask) ? 1 : 0;
+}
+
+static void write_led(acpi_handle led_handle, int led_out, int ledmask,
+		      int invert)
+{
+	hotk->status =
+	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
+
+	if (invert)		/* invert target value */
+		led_out = !led_out & 0x1;
+
+	if (!write_acpi_int(led_handle, NULL, led_out, NULL))
+		printk(ASUS_WARNING "LED write failed\n");
+}
+
+/* /sys/class/led handlers */
+#define ASUS_LED_HANDLER(object, mask, invert)				\
+	static void object##_led_set(struct led_classdev *led_cdev,	\
+				     enum led_brightness value)		\
+	{								\
+		object##_led_wk = value;				\
+		queue_work(led_workqueue, &object##_led_work);		\
+	}								\
+	static void object##_led_update(struct work_struct *ignored)	\
+	{								\
+		int value = object##_led_wk;				\
+		write_led(object##_set_handle, value, (mask), (invert)); \
+	}
+
+ASUS_LED_HANDLER(mled, MLED_ON, 1);
+ASUS_LED_HANDLER(pled, PLED_ON, 0);
+ASUS_LED_HANDLER(rled, RLED_ON, 0);
+ASUS_LED_HANDLER(tled, TLED_ON, 0);
+
 /*
  * Platform device handlers
  */
@@ -361,6 +436,11 @@
 	if(*string)
 		printk(ASUS_NOTICE "  %s model detected\n", string);
 
+	ASUS_HANDLE_INIT(mled_set);
+	ASUS_HANDLE_INIT(tled_set);
+	ASUS_HANDLE_INIT(rled_set);
+	ASUS_HANDLE_INIT(pled_set);
+
 	kfree(model);
 
 	return AE_OK;
@@ -452,8 +532,25 @@
 	return 0;
 }
 
+#define  ASUS_LED_UNREGISTER(object)				\
+	if(object##_led.class_dev				\
+	   && !IS_ERR(object##_led.class_dev))			\
+		led_classdev_unregister(&object##_led)
+
+static void asus_led_exit(void)
+{
+	ASUS_LED_UNREGISTER(mled);
+	ASUS_LED_UNREGISTER(tled);
+	ASUS_LED_UNREGISTER(pled);
+	ASUS_LED_UNREGISTER(rled);
+
+	destroy_workqueue(led_workqueue);
+}
+
 static void __exit asus_laptop_exit(void)
 {
+	asus_led_exit();
+
 	acpi_bus_unregister_driver(&asus_hotk_driver);
         sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group);
         platform_device_unregister(asuspf_device);
@@ -462,8 +559,48 @@
 	kfree(asus_info);
 }
 
+static int asus_led_register(acpi_handle handle,
+			     struct led_classdev * ldev,
+			     struct device * dev)
+{
+	if(!handle)
+		return 0;
+
+	return led_classdev_register(dev, ldev);
+}
+#define ASUS_LED_REGISTER(object, device)				\
+	asus_led_register(object##_set_handle, &object##_led, device)
+
+static int asus_led_init(struct device * dev)
+{
+	int rv;
+
+	rv = ASUS_LED_REGISTER(mled, dev);
+	if(rv)
+		return rv;
+
+	rv = ASUS_LED_REGISTER(tled, dev);
+	if(rv)
+		return rv;
+
+	rv = ASUS_LED_REGISTER(rled, dev);
+	if(rv)
+		return rv;
+
+	rv = ASUS_LED_REGISTER(pled, dev);
+	if(rv)
+		return rv;
+
+	led_workqueue = create_singlethread_workqueue("led_workqueue");
+	if(!led_workqueue)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int __init asus_laptop_init(void)
 {
+	struct device *dev;
 	int result;
 
 	if (acpi_disabled)
@@ -490,6 +627,12 @@
 		return -ENODEV;
 	}
 
+	dev = acpi_get_physical_device(hotk->device->handle);
+
+	result = asus_led_init(dev);
+	if(result)
+		goto fail_led;
+
         /* Register platform stuff */
 	result = platform_driver_register(&asuspf_driver);
         if (result)
@@ -522,6 +665,9 @@
         platform_driver_unregister(&asuspf_driver);
 
 fail_platform_driver:
+	asus_led_exit();
+
+fail_led:
 
 	return result;
 }
diff -Naur a/drivers/misc/Kconfig b/drivers/misc/Kconfig
--- a/drivers/misc/Kconfig	2007-01-21 15:27:49.000000000 +0100
+++ b/drivers/misc/Kconfig	2007-01-21 15:24:26.000000000 +0100
@@ -74,6 +74,7 @@
         depends on X86
         depends on ACPI
 	depends on EXPERIMENTAL && !ASUS_ACPI
+	select LEDS_CLASS
         ---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
