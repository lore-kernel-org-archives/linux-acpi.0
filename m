From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 23/23] Documentation: ACPI: move video_extension.txt to firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:53:06 +0800
Message-ID: <20190424175306.25880-24-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 .../acpi/video_extension.rst}                 | 83 +++++++++++--------
 2 files changed, 50 insertions(+), 34 deletions(-)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (70%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 0e60f4b7129a..ae609eec4679 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -23,3 +23,4 @@ ACPI Support
    i2c-muxes
    acpi-lid
    lpit
+   video_extension
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/firmware-guide/acpi/video_extension.rst
similarity index 70%
rename from Documentation/acpi/video_extension.txt
rename to Documentation/firmware-guide/acpi/video_extension.rst
index 79bf6a4921be..099b8607e07b 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/firmware-guide/acpi/video_extension.rst
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
+Export a sysfs interface for user space to control backlight level
+==================================================================
 
 If the ACPI table has a video device, and acpi_backlight=vendor kernel
 command line is not present, the driver will register a backlight device
@@ -22,36 +26,41 @@ The backlight sysfs interface has a standard definition here:
 Documentation/ABI/stable/sysfs-class-backlight.
 
 And what ACPI video driver does is:
-actual_brightness: on read, control method _BQC will be evaluated to
-get the brightness level the firmware thinks it is at;
-bl_power: not implemented, will set the current brightness instead;
-brightness: on write, control method _BCM will run to set the requested
-brightness level;
-max_brightness: Derived from the _BCL package(see below);
-type: firmware
+
+actual_brightness:
+  on read, control method _BQC will be evaluated to
+  get the brightness level the firmware thinks it is at;
+bl_power:
+  not implemented, will set the current brightness instead;
+brightness:
+  on write, control method _BCM will run to set the requested brightness level;
+max_brightness:
+  Derived from the _BCL package(see below);
+type:
+  firmware
 
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
@@ -62,13 +71,15 @@ as a "brightness level" indicator. Thus from the user space perspective
 the range of available brightness levels is from 0 to 9 (max_brightness)
 inclusive.
 
-2 Notify user space about hotkey event
+Notify user space about hotkey event
+====================================
 
 There are generally two cases for hotkey event reporting:
+
 i) For some laptops, when user presses the hotkey, a scancode will be
    generated and sent to user space through the input device created by
    the keyboard driver as a key type input event, with proper remap, the
-   following key code will appear to user space:
+   following key code will appear to user space::
 
 	EV_KEY, KEY_BRIGHTNESSUP
 	EV_KEY, KEY_BRIGHTNESSDOWN
@@ -84,23 +95,27 @@ ii) For some laptops, the press of the hotkey will not generate the
     notify value it received and send the event to user space through the
     input device it created:
 
+	=====		==================
 	event		keycode
+	=====		==================
 	0x86		KEY_BRIGHTNESSUP
 	0x87		KEY_BRIGHTNESSDOWN
 	etc.
+	=====		==================
 
 so this would lead to the same effect as case i) now.
 
 Once user space tool receives this event, it can modify the backlight
 level through the sysfs interface.
 
-3 Change backlight level in the kernel
+Change backlight level in the kernel
+====================================
 
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
