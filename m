From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 24/24] acpi doc: convert acpi/video_extension.txt to rst format
Date: Fri, 29 Mar 2019 08:11:35 +0800
Message-ID: <20190329001135.15847-25-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst                  |  1 +
 ...ideo_extension.txt => video_extension.rst} | 63 ++++++++++---------
 2 files changed, 36 insertions(+), 28 deletions(-)
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (79%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index d856ba53da4d..f16d527d1958 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -29,3 +29,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    cppc_sysfs
    lpit
    ssdt-overlays
+   video_extension
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/acpi/video_extension.rst
similarity index 79%
rename from Documentation/acpi/video_extension.txt
rename to Documentation/acpi/video_extension.rst
index 79bf6a4921be..06f7e3230b6e 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/acpi/video_extension.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
 ACPI video extensions
-~~~~~~~~~~~~~~~~~~~~~
+=====================
 
 This driver implement the ACPI Extensions For Display Adapters for
 integrated graphics devices on motherboard, as specified in ACPI 2.0
@@ -8,9 +11,10 @@ defining the video POST device, retrieving EDID information or to
 setup a video output, etc.  Note that this is an ref. implementation
 only.  It may or may not work for your integrated video device.
 
-The ACPI video driver does 3 things regarding backlight control:
+The ACPI video driver does 3 things regarding backlight control.
 
-1 Export a sysfs interface for user space to control backlight level
+1. Export a sysfs interface for user space to control backlight level
+=====================================================================
 
 If the ACPI table has a video device, and acpi_backlight=vendor kernel
 command line is not present, the driver will register a backlight device
@@ -32,26 +36,26 @@ type: firmware
 
 Note that ACPI video backlight driver will always use index for
 brightness, actual_brightness and max_brightness. So if we have
-the following _BCL package:
+the following _BCL package::
 
-Method (_BCL, 0, NotSerialized)
-{
-	Return (Package (0x0C)
+	Method (_BCL, 0, NotSerialized)
 	{
-		0x64,
-		0x32,
-		0x0A,
-		0x14,
-		0x1E,
-		0x28,
-		0x32,
-		0x3C,
-		0x46,
-		0x50,
-		0x5A,
-		0x64
-	})
-}
+		Return (Package (0x0C)
+		{
+			0x64,
+			0x32,
+			0x0A,
+			0x14,
+			0x1E,
+			0x28,
+			0x32,
+			0x3C,
+			0x46,
+			0x50,
+			0x5A,
+			0x64
+		})
+	}
 
 The first two levels are for when laptop are on AC or on battery and are
 not used by Linux currently. The remaining 10 levels are supported levels
@@ -62,13 +66,15 @@ as a "brightness level" indicator. Thus from the user space perspective
 the range of available brightness levels is from 0 to 9 (max_brightness)
 inclusive.
 
-2 Notify user space about hotkey event
+2. Notify user space about hotkey event
+=======================================
 
 There are generally two cases for hotkey event reporting:
+
 i) For some laptops, when user presses the hotkey, a scancode will be
    generated and sent to user space through the input device created by
    the keyboard driver as a key type input event, with proper remap, the
-   following key code will appear to user space:
+   following key code will appear to user space::
 
 	EV_KEY, KEY_BRIGHTNESSUP
 	EV_KEY, KEY_BRIGHTNESSDOWN
@@ -82,7 +88,7 @@ ii) For some laptops, the press of the hotkey will not generate the
     about the event. The event value is defined in the ACPI spec. ACPI
     video driver will generate an key type input event according to the
     notify value it received and send the event to user space through the
-    input device it created:
+    input device it created::
 
 	event		keycode
 	0x86		KEY_BRIGHTNESSUP
@@ -94,13 +100,14 @@ so this would lead to the same effect as case i) now.
 Once user space tool receives this event, it can modify the backlight
 level through the sysfs interface.
 
-3 Change backlight level in the kernel
+3. Change backlight level in the kernel
+=======================================
 
 This works for machines covered by case ii) in Section 2. Once the driver
 received a notification, it will set the backlight level accordingly. This does
 not affect the sending of event to user space, they are always sent to user
 space regardless of whether or not the video module controls the backlight level
 directly. This behaviour can be controlled through the brightness_switch_enabled
-module parameter as documented in admin-guide/kernel-parameters.rst. It is recommended to
-disable this behaviour once a GUI environment starts up and wants to have full
-control of the backlight level.
+module parameter as documented in admin-guide/kernel-parameters.rst. It is
+recommended to disable this behaviour once a GUI environment starts up and
+wants to have full control of the backlight level.
-- 
2.20.1
