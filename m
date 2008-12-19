From: "Daniel Nascimento" <dnascimento@gmail.com>
Subject: Fwd: [PATCH 02/02] Reworked input layer and add more keys
Date: Fri, 19 Dec 2008 14:37:04 -0200
Message-ID: <4ff2fa00812190837p65d0cafegc62c01e577473d29@mail.gmail.com>
References: <200811291849.02054.dnascimento@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:22787 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYLSQhF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 11:37:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so982010rvb.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 08:37:04 -0800 (PST)
In-Reply-To: <200811291849.02054.dnascimento@gmail.com>
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
Subject: [PATCH 02/02] Reworked input layer and add more keys
To: linux-acpi@vger.kernel.org, Nicolas Trangez <ikke@nicolast.be>


I made some changes in the work of Nicolas to support my asus M51Sn laptop.
The higher event in my laptop is 153 so I think that will not be reasonable
declare a 154 array hardcoding each key. And if another table be necessary
the work will need to be redone.

I fill a array with KEY_UNKNOWN and then after I put the codes that I found
in my laptop. A new table can be added with other table contaning only the
differences for example.

Some keys are overriding by firmware but I let it in the table to know which
events are generated.

So this patch change the implementation of the keymap focusing only in the
keys that generate known events. And also makes it easier to support more
than one keymap table.

Add more keys events.
---
drivers/misc/asus-laptop.c |  182 +++++++++++++++++++++----------------------
1 files changed, 89 insertions(+), 93 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 46db3b0..b2cb7dc 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -24,7 +24,8 @@
*  http://sourceforge.net/projects/acpi4asus/
*
*  Credits:
- *  Nicolas Trangez  - Initial work to let ACPI buttons work over INPUT layer
+ *  Daniel Nascimento - Reworked input layer and add more keys
+ *  Nicolas Trangez - Initial work to let ACPI buttons work over INPUT layer
*  Pontus Fuchs   - Helper functions, cleanup
*  Johann Wiesner - Small compile fixes
*  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
@@ -254,11 +255,19 @@ ASUS_LED(pled, "phone");
ASUS_LED(gled, "gaming");

/* Input layer variables */
+/* Magic number set 154 because 153 is the highest event in M51Sn */
+#define ASUS_HOTK_MAP_LEN       154
+#define ASUS_HOTK_MAP_SIZE
ASUS_HOTK_MAP_LEN*sizeof(typeof(*hotk_keycode_map))
+
static u16 *hotk_keycode_map;
-static int hotk_keycode_map_size;
static struct input_dev *asus_hotk_inputdev;
static int asus_hotk_inputdev_registered;

+struct key_event {
+       u16 key;
+       u8  event;
+};
+
/*
* This function evaluates an ACPI method, given an int as parameter, the
* method is searched within the scope of the handle, can be NULL. The output
@@ -749,9 +758,8 @@ static void asus_hotk_notify(acpi_handle handle,
u32 event, void *data)
              lcd_blank(FB_BLANK_POWERDOWN);
      }

-       if (event < hotk_keycode_map_size) {
+       if (event < ASUS_HOTK_MAP_LEN) {
              keycode = hotk_keycode_map[event];
-               printk("Keycode: %04x (%d)\n", keycode, keycode);
      } else {
              keycode = KEY_UNKNOWN;
              printk("Scancode %d out of keymap\n", event);
@@ -1145,104 +1153,95 @@ static void __exit asus_laptop_exit(void)
      platform_driver_unregister(&asuspf_driver);
}

-static int asus_hotk_init(void)
+static int set_keycode_map(void)
{
-       int ret, i;
+       int i;

-       static u16 keycode_map_1[] __initdata = {
-               KEY_UNKNOWN, /* 0 */
-               KEY_UNKNOWN, /* 1 */
-               KEY_UNKNOWN, /* 2 */
-               KEY_UNKNOWN, /* 3 */
-               KEY_UNKNOWN, /* 4 */
-               KEY_UNKNOWN, /* 5 */
-               KEY_UNKNOWN, /* 6 */
-               KEY_UNKNOWN, /* 7 */
-               KEY_UNKNOWN, /* 8 */
-               KEY_UNKNOWN, /* 9 */
-               KEY_UNKNOWN, /* 10 */
-               KEY_UNKNOWN, /* 11 */
-               KEY_UNKNOWN, /* 12 */
-               KEY_UNKNOWN, /* 13 */
-               KEY_UNKNOWN, /* 14 */
-               KEY_UNKNOWN, /* 15 */
-               KEY_UNKNOWN, /* 16 */
-               KEY_UNKNOWN, /* 17 */
-               KEY_UNKNOWN, /* 18 */
-               KEY_UNKNOWN, /* 19 */
-               KEY_UNKNOWN, /* 20 */
-               KEY_UNKNOWN, /* 21 */
-               KEY_UNKNOWN, /* 22 */
-               KEY_UNKNOWN, /* 23 */
-               KEY_UNKNOWN, /* 24 */
-               KEY_UNKNOWN, /* 25 */
-               KEY_UNKNOWN, /* 26 */
-               KEY_UNKNOWN, /* 27 */
-               KEY_UNKNOWN, /* 28 */
-               KEY_UNKNOWN, /* 29 */
-               KEY_UNKNOWN, /* 30 */
-               KEY_UNKNOWN, /* 31 */
-               KEY_UNKNOWN, /* 32 */
-               KEY_UNKNOWN, /* 33 */
-               KEY_UNKNOWN, /* 34 */
-               KEY_UNKNOWN, /* 35 */
-               KEY_UNKNOWN, /* 36 */
-               KEY_UNKNOWN, /* 37 */
-               KEY_UNKNOWN, /* 38 */
-               KEY_UNKNOWN, /* 39 */
-               KEY_UNKNOWN, /* 40 */
-               KEY_UNKNOWN, /* 41 */
-               KEY_UNKNOWN, /* 42 */
-               KEY_UNKNOWN, /* 43 */
-               KEY_UNKNOWN, /* 44 */
-               KEY_UNKNOWN, /* 45 */
-               KEY_UNKNOWN, /* 46 */
-               KEY_UNKNOWN, /* 47 */
-               KEY_UNKNOWN, /* 48 */
-               KEY_UNKNOWN, /* 49 */
-               KEY_UNKNOWN, /* 50 */
-               KEY_UNKNOWN, /* 51 */
-               KEY_UNKNOWN, /* 52 */
-               KEY_UNKNOWN, /* 53 */
-               KEY_UNKNOWN, /* 54 */
-               KEY_UNKNOWN, /* 55 */
-               KEY_UNKNOWN, /* 56 */
-               KEY_UNKNOWN, /* 57 */
-               KEY_UNKNOWN, /* 58 */
-               KEY_UNKNOWN, /* 59 */
-               KEY_UNKNOWN, /* 60 */
-               KEY_UNKNOWN, /* 61 */
-               KEY_UNKNOWN, /* 62 */
-               KEY_UNKNOWN, /* 63 */
-               KEY_PREVIOUSSONG, /* 64 */
-               KEY_NEXTSONG, /* 65 */
-               KEY_UNKNOWN, /* 66 */
-               KEY_STOP, /* 67 */
-               KEY_UNKNOWN, /* 68 */
-               KEY_PLAYPAUSE, /* 69 */
-               KEY_UNKNOWN, /* 70 */
+       /* Some of these values are ovewriten by something */
+       static struct key_event map_1[] = {
+               { KEY_RESERVED, 17 }, /* Brightness up   */
+               { KEY_RESERVED, 18 }, /* Brightness up   */
+               { KEY_RESERVED, 19 }, /* Brightness up   */
+               { KEY_RESERVED, 20 }, /* Brightness up   */
+               { KEY_RESERVED, 21 }, /* Brightness up   */
+               { KEY_RESERVED, 22 }, /* Brightness up   */
+               { KEY_RESERVED, 23 }, /* Brightness up   */
+               { KEY_RESERVED, 24 }, /* Brightness up   */
+               { KEY_RESERVED, 25 }, /* Brightness up   */
+               { KEY_RESERVED, 26 }, /* Brightness up   */
+               { KEY_RESERVED, 27 }, /* Brightness up   */
+               { KEY_RESERVED, 28 }, /* Brightness up   */
+               { KEY_RESERVED, 29 }, /* Brightness up   */
+               { KEY_RESERVED, 30 }, /* Brightness up   */
+               { KEY_RESERVED, 31 }, /* Brightness up   */
+               { KEY_RESERVED, 32 }, /* Brightness down */
+               { KEY_RESERVED, 33 }, /* Brightness down */
+               { KEY_RESERVED, 34 }, /* Brightness down */
+               { KEY_RESERVED, 35 }, /* Brightness down */
+               { KEY_RESERVED, 36 }, /* Brightness down */
+               { KEY_RESERVED, 37 }, /* Brightness down */
+               { KEY_RESERVED, 38 }, /* Brightness down */
+               { KEY_RESERVED, 39 }, /* Brightness down */
+               { KEY_RESERVED, 40 }, /* Brightness down */
+               { KEY_RESERVED, 41 }, /* Brightness down */
+               { KEY_RESERVED, 42 }, /* Brightness down */
+               { KEY_RESERVED, 43 }, /* Brightness down */
+               { KEY_RESERVED, 44 }, /* Brightness down */
+               { KEY_RESERVED, 45 }, /* Brightness down */
+               { KEY_RESERVED, 46 }, /* Brightness down */
+               { KEY_VOLUMEUP, 48 },
+               { KEY_VOLUMEDOWN, 49 },
+               { KEY_MUTE,     50 },
+               { KEY_RESERVED, 51 }, /* LCD Switch */
+               { KEY_RESERVED, 52 }, /* LCD Switch */
+               { KEY_PREVIOUSSONG, 64 },
+               { KEY_NEXTSONG, 65 },
+               { KEY_STOP,     67 },
+               { KEY_PLAYPAUSE,69 },
+               { KEY_EMAIL,    80 },
+               { KEY_WWW,      81 },
+               { BTN_EXTRA,    92 },  /* Performance */
+               { KEY_WLAN,     93 },
+               { KEY_SWITCHVIDEOMODE,    97 },
+               { BTN_TOUCH,    107 }, /* Lock Mouse */
+               { KEY_BLUETOOTH,125 }, /* Bluetooth up */
+               { KEY_BLUETOOTH,126 }, /* Bluetooth down */
+               { KEY_CAMERA,   130 },
+               { KEY_TV,       138 },
+               { KEY_MEDIA,    149 },
+               { KEY_PHONE,    153 }
      };
-
-#define ASUS_HOTK_MAP_LEN       ARRAY_SIZE(keycode_map_1)
-#define ASUS_HOTK_MAP_SIZE      sizeof(keycode_map_1)
-#define ASUS_HOTK_MAP_TYPESIZE  sizeof(keycode_map_1[0])
-
-       /* Always use first keymap. TODO make this model-specific */
+
      hotk_keycode_map = kmalloc(ASUS_HOTK_MAP_SIZE, GFP_KERNEL);
-       hotk_keycode_map_size = ASUS_HOTK_MAP_LEN;
      if (!hotk_keycode_map) {
              printk(ASUS_ERR "failed to allocate memory for keymap\n");
              return -ENOMEM;
      }
-       printk(ASUS_NOTICE "using keycode_map_1\n");
-       memcpy(hotk_keycode_map, &keycode_map_1, ASUS_HOTK_MAP_SIZE);
-       /* TODO make sure no ACPI events are sent on known keycodes */

      asus_hotk_inputdev = input_allocate_device();
      if (!asus_hotk_inputdev) {
              printk(ASUS_ERR "unable to allocate input device\n");
              return -ENOMEM;
      }
+       for (i = 0; i < ASUS_HOTK_MAP_SIZE; i++)
+               hotk_keycode_map[i] = KEY_UNKNOWN;
+
+       /* Always use first keymap. TODO make this model-specific
+        * (not sure if it's needed more than one) */
+       printk(ASUS_NOTICE "using map_1\n");
+       for (i = 0; i < ARRAY_SIZE(map_1); i++)
+               hotk_keycode_map[map_1[i].event] = map_1[i].key;
+
+       return 0;
+}
+
+static int asus_hotk_init(void)
+{
+       int ret, i;
+
+       if ((ret = set_keycode_map()) != 0)
+               return ret;
+
      asus_hotk_inputdev->name = "Asus Extra Buttons";
      asus_hotk_inputdev->phys = ASUS_HOTK_FILE "/input0";
      asus_hotk_inputdev->id.bustype = BUS_HOST;
@@ -1255,16 +1254,13 @@ static int asus_hotk_init(void)
      set_bit(EV_KEY, asus_hotk_inputdev->evbit);
      set_bit(EV_MSC, asus_hotk_inputdev->evbit);
      set_bit(MSC_SCAN, asus_hotk_inputdev->mscbit);
-       asus_hotk_inputdev->keycodesize = ASUS_HOTK_MAP_TYPESIZE;
+       asus_hotk_inputdev->keycodesize = sizeof(hotk_keycode_map[0]);
      asus_hotk_inputdev->keycodemax = ASUS_HOTK_MAP_LEN;
      asus_hotk_inputdev->keycode = hotk_keycode_map;
      for (i = 0; i < ASUS_HOTK_MAP_LEN; i++) {
              if (hotk_keycode_map[i] != KEY_RESERVED) {
                      set_bit(hotk_keycode_map[i], asus_hotk_inputdev->keybit);
-               } /*else {
-                       if (i < sizeof(hotk_reserved_mask)*8)
-                               hotk_reserved_mask |= 1 << i;
-               }*/
+               }
      }

      ret = input_register_device(asus_hotk_inputdev);
--
1.5.6
