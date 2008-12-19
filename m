From: "Daniel Nascimento" <dnascimento@gmail.com>
Subject: Fwd: [PATCH 01/02] Initial work to let ACPI buttons work over INPUT layer
Date: Fri, 19 Dec 2008 14:34:47 -0200
Message-ID: <4ff2fa00812190834s8ef5629ofa1f17a74aa6bfef@mail.gmail.com>
References: <200811291834.46109.dnascimento@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:19692 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYLSQes (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 11:34:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so981136rvb.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 08:34:47 -0800 (PST)
In-Reply-To: <200811291834.46109.dnascimento@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, Nicolas Trangez <ikke@nicolast.be>, corentincj@iksaif.net, sziwan@users.sourceforge.net, Timo Hoenig <thoenig@nouse.net>, linux-acpi@vger.kernel.org

Please apply this patch in mainstream. The code was tested by Timo
Hoenig and more info can be found this list and here:
https://bugzilla.novell.com/show_bug.cgi?id=448004


---------- Forwarded message ----------
From: Daniel Oliveira Nascimento <dnascimento@gmail.com>
Date: 2008/11/29
Subject: [PATCH 01/02] Initial work to let ACPI buttons work over INPUT layer
To: linux-acpi@vger.kernel.org, Nicolas Trangez <ikke@nicolast.be>


Updated work of Nicolas Trangez to support INPUT layer in
asus-laptop driver in git branch.

Initial discussion can be found here:
http://article.gmane.org/gmane.linux.acpi.acpi4asus.user/217

---
 drivers/misc/asus-laptop.c |  183 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 182 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 8fb8b35..46db3b0 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -24,6 +24,7 @@
 *  http://sourceforge.net/projects/acpi4asus/
 *
 *  Credits:
+ *  Nicolas Trangez  - Initial work to let ACPI buttons work over INPUT layer
 *  Pontus Fuchs   - Helper functions, cleanup
 *  Johann Wiesner - Small compile fixes
 *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
@@ -46,6 +47,8 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
+#include <linux/input.h>
+#include <linux/pci_ids.h>

 #define ASUS_LAPTOP_VERSION "0.42"

@@ -250,6 +253,12 @@ ASUS_LED(rled, "record");
 ASUS_LED(pled, "phone");
 ASUS_LED(gled, "gaming");

+/* Input layer variables */
+static u16 *hotk_keycode_map;
+static int hotk_keycode_map_size;
+static struct input_dev *asus_hotk_inputdev;
+static int asus_hotk_inputdev_registered;
+
 /*
 * This function evaluates an ACPI method, given an int as parameter, the
 * method is searched within the scope of the handle, can be NULL. The output
@@ -722,6 +731,8 @@ static ssize_t store_gps(struct device *dev,
struct device_attribute *attr,

 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
+       int keycode;
+
       /* TODO Find a better way to handle events count. */
       if (!hotk)
               return;
@@ -738,7 +749,28 @@ static void asus_hotk_notify(acpi_handle handle,
u32 event, void *data)
               lcd_blank(FB_BLANK_POWERDOWN);
       }

-       acpi_bus_generate_proc_event(hotk->device, event,
+       if (event < hotk_keycode_map_size) {
+               keycode = hotk_keycode_map[event];
+               printk("Keycode: %04x (%d)\n", keycode, keycode);
+       } else {
+               keycode = KEY_UNKNOWN;
+               printk("Scancode %d out of keymap\n", event);
+       }
+
+       if (keycode != KEY_RESERVED) {
+               input_report_key(asus_hotk_inputdev, keycode, 1);
+               if (keycode == KEY_UNKNOWN)
+                       input_event(asus_hotk_inputdev, EV_MSC,
MSC_SCAN, event);
+               input_sync(asus_hotk_inputdev);
+
+               input_report_key(asus_hotk_inputdev, keycode, 0);
+               if (keycode == KEY_UNKNOWN)
+                       input_event(asus_hotk_inputdev, EV_MSC,
MSC_SCAN, event);
+               input_sync(asus_hotk_inputdev);
+       }
+
+       if (keycode == KEY_RESERVED || keycode == KEY_UNKNOWN)
+               acpi_bus_generate_proc_event(hotk->device, event,
                               hotk->event_count[event % 128]++);

       return;
@@ -1071,6 +1103,16 @@ static int asus_hotk_remove(struct acpi_device
*device, int type)
       return 0;
 }

+static void asus_hotk_exit(void)
+{
+       if (asus_hotk_inputdev) {
+               if (asus_hotk_inputdev_registered)
+                       input_unregister_device(asus_hotk_inputdev);
+               else
+                       input_free_device(asus_hotk_inputdev);
+       }
+}
+
 static void asus_backlight_exit(void)
 {
       if (asus_backlight_device)
@@ -1095,6 +1137,7 @@ static void __exit asus_laptop_exit(void)
 {
       asus_backlight_exit();
       asus_led_exit();
+       asus_hotk_exit();

       acpi_bus_unregister_driver(&asus_hotk_driver);
       sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group);
@@ -1102,6 +1145,138 @@ static void __exit asus_laptop_exit(void)
       platform_driver_unregister(&asuspf_driver);
 }

+static int asus_hotk_init(void)
+{
+       int ret, i;
+
+       static u16 keycode_map_1[] __initdata = {
+               KEY_UNKNOWN, /* 0 */
+               KEY_UNKNOWN, /* 1 */
+               KEY_UNKNOWN, /* 2 */
+               KEY_UNKNOWN, /* 3 */
+               KEY_UNKNOWN, /* 4 */
+               KEY_UNKNOWN, /* 5 */
+               KEY_UNKNOWN, /* 6 */
+               KEY_UNKNOWN, /* 7 */
+               KEY_UNKNOWN, /* 8 */
+               KEY_UNKNOWN, /* 9 */
+               KEY_UNKNOWN, /* 10 */
+               KEY_UNKNOWN, /* 11 */
+               KEY_UNKNOWN, /* 12 */
+               KEY_UNKNOWN, /* 13 */
+               KEY_UNKNOWN, /* 14 */
+               KEY_UNKNOWN, /* 15 */
+               KEY_UNKNOWN, /* 16 */
+               KEY_UNKNOWN, /* 17 */
+               KEY_UNKNOWN, /* 18 */
+               KEY_UNKNOWN, /* 19 */
+               KEY_UNKNOWN, /* 20 */
+               KEY_UNKNOWN, /* 21 */
+               KEY_UNKNOWN, /* 22 */
+               KEY_UNKNOWN, /* 23 */
+               KEY_UNKNOWN, /* 24 */
+               KEY_UNKNOWN, /* 25 */
+               KEY_UNKNOWN, /* 26 */
+               KEY_UNKNOWN, /* 27 */
+               KEY_UNKNOWN, /* 28 */
+               KEY_UNKNOWN, /* 29 */
+               KEY_UNKNOWN, /* 30 */
+               KEY_UNKNOWN, /* 31 */
+               KEY_UNKNOWN, /* 32 */
+               KEY_UNKNOWN, /* 33 */
+               KEY_UNKNOWN, /* 34 */
+               KEY_UNKNOWN, /* 35 */
+               KEY_UNKNOWN, /* 36 */
+               KEY_UNKNOWN, /* 37 */
+               KEY_UNKNOWN, /* 38 */
+               KEY_UNKNOWN, /* 39 */
+               KEY_UNKNOWN, /* 40 */
+               KEY_UNKNOWN, /* 41 */
+               KEY_UNKNOWN, /* 42 */
+               KEY_UNKNOWN, /* 43 */
+               KEY_UNKNOWN, /* 44 */
+               KEY_UNKNOWN, /* 45 */
+               KEY_UNKNOWN, /* 46 */
+               KEY_UNKNOWN, /* 47 */
+               KEY_UNKNOWN, /* 48 */
+               KEY_UNKNOWN, /* 49 */
+               KEY_UNKNOWN, /* 50 */
+               KEY_UNKNOWN, /* 51 */
+               KEY_UNKNOWN, /* 52 */
+               KEY_UNKNOWN, /* 53 */
+               KEY_UNKNOWN, /* 54 */
+               KEY_UNKNOWN, /* 55 */
+               KEY_UNKNOWN, /* 56 */
+               KEY_UNKNOWN, /* 57 */
+               KEY_UNKNOWN, /* 58 */
+               KEY_UNKNOWN, /* 59 */
+               KEY_UNKNOWN, /* 60 */
+               KEY_UNKNOWN, /* 61 */
+               KEY_UNKNOWN, /* 62 */
+               KEY_UNKNOWN, /* 63 */
+               KEY_PREVIOUSSONG, /* 64 */
+               KEY_NEXTSONG, /* 65 */
+               KEY_UNKNOWN, /* 66 */
+               KEY_STOP, /* 67 */
+               KEY_UNKNOWN, /* 68 */
+               KEY_PLAYPAUSE, /* 69 */
+               KEY_UNKNOWN, /* 70 */
+       };
+
+#define ASUS_HOTK_MAP_LEN       ARRAY_SIZE(keycode_map_1)
+#define ASUS_HOTK_MAP_SIZE      sizeof(keycode_map_1)
+#define ASUS_HOTK_MAP_TYPESIZE  sizeof(keycode_map_1[0])
+
+       /* Always use first keymap. TODO make this model-specific */
+       hotk_keycode_map = kmalloc(ASUS_HOTK_MAP_SIZE, GFP_KERNEL);
+       hotk_keycode_map_size = ASUS_HOTK_MAP_LEN;
+       if (!hotk_keycode_map) {
+               printk(ASUS_ERR "failed to allocate memory for keymap\n");
+               return -ENOMEM;
+       }
+       printk(ASUS_NOTICE "using keycode_map_1\n");
+       memcpy(hotk_keycode_map, &keycode_map_1, ASUS_HOTK_MAP_SIZE);
+       /* TODO make sure no ACPI events are sent on known keycodes */
+
+       asus_hotk_inputdev = input_allocate_device();
+       if (!asus_hotk_inputdev) {
+               printk(ASUS_ERR "unable to allocate input device\n");
+               return -ENOMEM;
+       }
+       asus_hotk_inputdev->name = "Asus Extra Buttons";
+       asus_hotk_inputdev->phys = ASUS_HOTK_FILE "/input0";
+       asus_hotk_inputdev->id.bustype = BUS_HOST;
+       asus_hotk_inputdev->id.vendor = PCI_VENDOR_ID_ASUSTEK;
+       /* TODO
+       asus_hotk_inputdev->id.product =
+       asus_hotk_inputdev->id.version =
+       */
+
+       set_bit(EV_KEY, asus_hotk_inputdev->evbit);
+       set_bit(EV_MSC, asus_hotk_inputdev->evbit);
+       set_bit(MSC_SCAN, asus_hotk_inputdev->mscbit);
+       asus_hotk_inputdev->keycodesize = ASUS_HOTK_MAP_TYPESIZE;
+       asus_hotk_inputdev->keycodemax = ASUS_HOTK_MAP_LEN;
+       asus_hotk_inputdev->keycode = hotk_keycode_map;
+       for (i = 0; i < ASUS_HOTK_MAP_LEN; i++) {
+               if (hotk_keycode_map[i] != KEY_RESERVED) {
+                       set_bit(hotk_keycode_map[i],
asus_hotk_inputdev->keybit);
+               } /*else {
+                       if (i < sizeof(hotk_reserved_mask)*8)
+                               hotk_reserved_mask |= 1 << i;
+               }*/
+       }
+
+       ret = input_register_device(asus_hotk_inputdev);
+       if (ret < 0) {
+               printk(ASUS_ERR "unable to register input device\n");
+               return ret;
+       }
+       asus_hotk_inputdev_registered = 1;
+
+       return 0;
+}
+
 static int asus_backlight_init(struct device *dev)
 {
       struct backlight_device *bd;
@@ -1208,6 +1383,10 @@ static int __init asus_laptop_init(void)

       dev = acpi_get_physical_device(hotk->device->handle);

+       result = asus_hotk_init();
+       if (result)
+               goto fail_hotk;
+
       if (!acpi_video_backlight_support()) {
               result = asus_backlight_init(dev);
               if (result)
@@ -1259,6 +1438,8 @@ static int __init asus_laptop_init(void)

      fail_backlight:

+      fail_hotk:
+
       return result;
 }

--
1.5.6
