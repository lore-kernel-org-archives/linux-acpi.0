From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/140] asus-laptop: add led support
Date: Wed,  7 Feb 2007 13:50:45 -0500
Message-ID: <1170874417392-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:4200 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422748AbXBGSxk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:40 -0500
In-Reply-To: <1170874415464-git-send-email-lenb@kernel.org>
Message-Id: <be18cdabb8ed40ff4b8a240e0d6f4e6c30ff866d.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Add led support, using generic led class.  Thomas Tuttle's patch
<http://lkml.org/lkml/2006/7/6/247> was very usefull.  We use
hotk->status to store led status because it's very hard to find
acpi method to get the right status...  To reduce the code,
I use a lot of macro (ASUS_LED, ASUS_LED_REGISTER, etc ...),
because the code is the same for all leds ...

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig       |    1 +
 drivers/misc/asus-laptop.c |  145 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4b1e367..87e1db8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -74,6 +74,7 @@ config ASUS_LAPTOP
         depends on X86
         depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
+	depends on LEDS_CLASS
         ---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 959b20f..d0d5ee9 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
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
@@ -69,6 +78,12 @@ MODULE_LICENSE("GPL");
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
@@ -106,6 +121,28 @@ static struct acpi_driver asus_hotk_driver = {
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
@@ -144,6 +181,43 @@ static int read_acpi_int(acpi_handle handle, const char *method, int *val,
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
 
+/* Generic LED functions */
+static int read_status(int mask)
+{
+	return (hotk->status & mask) ? 1 : 0;
+}
+
+static void write_status(acpi_handle handle, int out, int mask,
+		      int invert)
+{
+	hotk->status = (out) ? (hotk->status | mask) : (hotk->status & ~mask);
+
+	if (invert)		/* invert target value */
+		out = !out & 0x1;
+
+	if (handle && !write_acpi_int(handle, NULL, out, NULL))
+		printk(ASUS_WARNING " write failed\n");
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
+		write_status(object##_set_handle, value, (mask), (invert)); \
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
@@ -361,6 +435,11 @@ static int asus_hotk_get_info(void)
 	if(*string)
 		printk(ASUS_NOTICE "  %s model detected\n", string);
 
+	ASUS_HANDLE_INIT(mled_set);
+	ASUS_HANDLE_INIT(tled_set);
+	ASUS_HANDLE_INIT(rled_set);
+	ASUS_HANDLE_INIT(pled_set);
+
 	kfree(model);
 
 	return AE_OK;
@@ -452,8 +531,25 @@ static int asus_hotk_remove(struct acpi_device *device, int type)
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
@@ -462,8 +558,48 @@ static void __exit asus_laptop_exit(void)
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
@@ -490,6 +626,12 @@ static int __init asus_laptop_init(void)
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
@@ -522,6 +664,9 @@ fail_platform_device1:
         platform_driver_unregister(&asuspf_driver);
 
 fail_platform_driver:
+	asus_led_exit();
+
+fail_led:
 
 	return result;
 }
-- 
1.5.0.rc3.39.gec804
