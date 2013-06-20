From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 3/3] ACPI / video: update video_extension.txt for backlight control
Date: Thu, 20 Jun 2013 15:08:57 +0800
Message-ID: <1371712137-4019-4-git-send-email-aaron.lu@intel.com>
References: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42935 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614Ab3FTHIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jun 2013 03:08:37 -0400
In-Reply-To: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Micael Dias <kam1kaz3@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

The ACPI video driver has changed a lot, and it doesn't export
interfaces in /proc any more, so the documentation for it should
be updated.
This update focuses on ACPI video driver's backlight control.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 Documentation/acpi/video_extension.txt | 121 ++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 26 deletions(-)

diff --git a/Documentation/acpi/video_extension.txt b/Documentation/acpi/video_extension.txt
index b2f9b15..78b32ac 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/acpi/video_extension.txt
@@ -8,30 +8,99 @@ defining the video POST device, retrieving EDID information or to
 setup a video output, etc.  Note that this is an ref. implementation
 only.  It may or may not work for your integrated video device.
 
-Interfaces exposed to userland through /proc/acpi/video:
-
-VGA/info : display the supported video bus device capability like Video ROM, CRT/LCD/TV.
-VGA/ROM :  Used to get a copy of the display devices' ROM data (up to 4k).
-VGA/POST_info : Used to determine what options are implemented.
-VGA/POST : Used to get/set POST device.
-VGA/DOS : Used to get/set ownership of output switching:
-	Please refer ACPI spec B.4.1 _DOS
-VGA/CRT : CRT output
-VGA/LCD : LCD output
-VGA/TVO : TV output
-VGA/*/brightness : Used to get/set brightness of output device
-
-Notify event through /proc/acpi/event:
-
-#define ACPI_VIDEO_NOTIFY_SWITCH        0x80
-#define ACPI_VIDEO_NOTIFY_PROBE         0x81
-#define ACPI_VIDEO_NOTIFY_CYCLE         0x82
-#define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT   0x83
-#define ACPI_VIDEO_NOTIFY_PREV_OUTPUT   0x84
-
-#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS      0x82
-#define ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS        0x83
-#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS        0x84
-#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS       0x85
-#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF           0x86
+The ACPI video driver does 3 things regarding backlight control:
 
+1 Export a sysfs interface for user space to control backlight level
+
+If the ACPI table has a video device, and acpi_backlight=vendor kernel
+command line is not present, the driver will register a backlight device
+and set the required backlight operation structure for it for the sysfs
+interface control. For every registered class device, there will be a
+directory named acpi_videoX under /sys/class/backlight.
+
+The backlight sysfs interface has a standard definition here:
+Documentation/ABI/stable/sysfs-class-backlight.
+
+And what ACPI video driver does is:
+actual_brightness: on read, control method _BQC will be evaluated to
+get the brightness level the firmware thinks it is at;
+bl_power: not implemented, will set the current brightness instead;
+brightness: on write, control method _BCM will run to set the requested
+brightness level;
+max_brightness: Derived from the _BCL package(see below);
+type: firmware
+
+Note that ACPI video backlight driver will always use index for
+brightness, actual_brightness and max_brightness. So if we have
+the following _BCL package:
+
+Method (_BCL, 0, NotSerialized)
+{
+	Return (Package (0x0C)
+	{
+		0x64,
+		0x32,
+		0x0A,
+		0x14,
+		0x1E,
+		0x28,
+		0x32,
+		0x3C,
+		0x46,
+		0x50,
+		0x5A,
+		0x64
+	})
+}
+
+The first two levels are for when laptop are on AC or on battery and are
+not used by Linux currently. The remaining 10 levels are supported levels
+that we can choose from. The applicable index values are from 0 (that
+corresponds to the 0x0A brightness value) to 9 (that corresponds to the
+0x64 brightness value) inclusive. Each of those index values is regarded
+as a "brightness level" indicator. Thus from the user space perspective
+the range of available brightness levels is from 0 to 9 (max_brightness)
+inclusive.
+
+2 Notify user space about hotkey event
+
+There are generally two cases for hotkey event reporting:
+i) For some laptops, when user presses the hotkey, a scancode will be
+   generated and sent to user space through the input device created by
+   the keyboard driver as a key type input event, with proper remap, the
+   following key code will appear to user space:
+
+	EV_KEY, KEY_BRIGHTNESSUP
+	EV_KEY, KEY_BRIGHTNESSDOWN
+	etc.
+
+For this case, ACPI video driver does not need to do anything(actually,
+it doesn't even know this happened).
+
+ii) For some laptops, the press of the hotkey will not generate the
+    scancode, instead, firmware will notify the video device ACPI node
+    about the event. The event value is defined in the ACPI spec. ACPI
+    video driver will generate an key type input event according to the
+    notify value it received and send the event to user space through the
+    input device it created:
+
+	event		keycode
+	0x86		KEY_BRIGHTNESSUP
+	0x87		KEY_BRIGHTNESSDOWN
+	etc.
+
+so this would lead to the same effect as case i) now.
+
+Once user space tool receives this event, it can modify the backlight
+level through the sysfs interface.
+
+3 Change backlight level in the kernel
+
+This works for machines covered by case ii) in Section 2. Once the driver
+received a notification, it will set the backlight level accordingly. This does
+not affect the sending of event to user space, they are always sent to user
+space regardless of whether or not the video module controls the backlight level
+directly. This behaviour can be controlled through the brightness_switch_enabled
+module parameter as documented in kernel-parameters.txt. It is recommended to
+disable this behaviour once a GUI environment starts up and wants to have full
+control of the backlight level.
-- 
1.8.3.3.gfada522

